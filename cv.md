---
layout: page
title: Full CV
---

<!-- https://jekyllrb.com/docs/includes/#including-files-relative-to-another-file -->
<!-- {% include nir_ben_zvi.md %} -->

<button id="download-pdf">Download PDF</button>

<div id="pdf-content">
  {% include nir_ben_zvi.md %}
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
<script>
document.getElementById("download-pdf").addEventListener("click", () => {
  const element = document.getElementById("pdf-content");
  html2pdf().from(element).save("CV.pdf");
});
</script>

