# /// script
# requires-python = ">=3.12"
# dependencies = ["fonttools>=4.50", "brotli>=1.1", "loguru>=0.7"]
# ///
"""Build static font instances for the CV PDF.

Google Fonts serves Lora and Open Sans as variable fonts, which Chromium's PDF
backend cannot embed on macOS: it falls back to Type3 bitmap glyphs and the
text looks blurry. This script downloads the upstream variable fonts and
writes static WOFF2 instances into ``assets/fonts`` for the print layout.
Run with::

    uv run scripts/build_print_fonts.py
"""

import io
import urllib.parse
import urllib.request
from pathlib import Path

from fontTools.ttLib import TTFont
from fontTools.varLib.instancer import instantiateVariableFont
from loguru import logger

OUT_DIR = Path(__file__).resolve().parent.parent / "assets" / "fonts"
UPSTREAM = "https://github.com/google/fonts/raw/main/ofl"

# (source file, output stem, axis location)
INSTANCES = [
    ("lora/Lora[wght].ttf", "lora-400", {"wght": 400}),
    ("lora/Lora[wght].ttf", "lora-700", {"wght": 700}),
    ("lora/Lora-Italic[wght].ttf", "lora-400-italic", {"wght": 400}),
    ("lora/Lora-Italic[wght].ttf", "lora-700-italic", {"wght": 700}),
    ("opensans/OpenSans[wdth,wght].ttf", "opensans-800", {"wdth": 100, "wght": 800}),
]
LICENSES = ["lora/OFL.txt", "opensans/OFL.txt"]


def fetch(path: str) -> bytes:
    """Download one file from the google/fonts repository."""
    url = f"{UPSTREAM}/{urllib.parse.quote(path)}"
    logger.debug("Fetching {}", url)
    with urllib.request.urlopen(url) as response:
        return response.read()


def main() -> None:
    """Download the variable fonts and write static WOFF2 instances."""
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    sources: dict[str, bytes] = {}
    for source, stem, location in INSTANCES:
        if source not in sources:
            sources[source] = fetch(source)
        font = instantiateVariableFont(TTFont(io.BytesIO(sources[source])), location)
        font.flavor = "woff2"
        target = OUT_DIR / f"{stem}.woff2"
        font.save(target)
        logger.info("Wrote {} ({} KB)", target.name, target.stat().st_size // 1024)
    for license_path in LICENSES:
        family = license_path.split("/")[0]
        (OUT_DIR / f"OFL-{family}.txt").write_bytes(fetch(license_path))


if __name__ == "__main__":
    main()
