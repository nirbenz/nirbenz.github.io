# /// script
# requires-python = ">=3.12"
# dependencies = ["playwright>=1.47", "loguru>=0.7"]
# ///
"""Render the CV page to a PDF with headless Chromium.

Builds the site, serves the ``_site`` directory locally and prints the
``/cv-pdf/`` page to ``assets/nir_ben_zvi_cv.pdf``. Run with::

    uv run --with playwright playwright install chromium
    uv run scripts/render_cv_pdf.py
"""

import argparse
import subprocess
import threading
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

from loguru import logger
from playwright.sync_api import sync_playwright

REPO_ROOT = Path(__file__).resolve().parent.parent
SITE_DIR = REPO_ROOT / "_site"
OUTPUT = REPO_ROOT / "assets" / "nir_ben_zvi_cv.pdf"
PAGE_PATH = "/cv-pdf/"


def build_site() -> None:
    """Build the Jekyll site into ``_site`` using the repo Gemfile."""
    logger.info("Building Jekyll site")
    subprocess.run(["bundle", "exec", "jekyll", "build"], cwd=REPO_ROOT, check=True)


def render_pdf(base_url: str, output: Path) -> None:
    """Print the CV page at ``base_url`` to ``output`` using Chromium."""
    with sync_playwright() as playwright:
        browser = playwright.chromium.launch()
        page = browser.new_page()
        page.goto(f"{base_url}{PAGE_PATH}", wait_until="networkidle")
        page.emulate_media(media="print")
        page.pdf(path=str(output), prefer_css_page_size=True, print_background=True)
        browser.close()


def main() -> None:
    """Parse arguments, build the site and render the PDF."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--skip-build", action="store_true", help="reuse the existing _site directory")
    parser.add_argument("--output", type=Path, default=OUTPUT)
    args = parser.parse_args()

    if not args.skip_build:
        build_site()

    handler = partial(SimpleHTTPRequestHandler, directory=str(SITE_DIR))
    server = ThreadingHTTPServer(("127.0.0.1", 0), handler)
    threading.Thread(target=server.serve_forever, daemon=True).start()
    base_url = f"http://127.0.0.1:{server.server_port}"
    logger.debug("Serving {} at {}", SITE_DIR, base_url)

    try:
        render_pdf(base_url, args.output)
    finally:
        server.shutdown()
    logger.info("Wrote {}", args.output)


if __name__ == "__main__":
    main()
