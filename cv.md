---
layout: page
title: Full CV
cv_filename: nir_ben_zvi_cv
share-title: Nir Ben Zvi - Full CV
share-description: My full curriculum vitae, covering my entire professional experience.

---

{% capture cv_content %}
{% include {{page.cv_filename}}.md %}
{% endcapture %}

<ul class="list-inline text-center footer-links">
  <li class="list-inline-item">
    <a id="download-pdf" href="#" title="Download PDF">
      <span class="fa-stack fa-lg" aria-hidden="true">
        <i class="fas fa-circle fa-stack-2x"></i>
        <i class="fas fa-file-pdf fa-stack-1x fa-inverse"></i>
      </span>
      <span class="sr-only">Download PDF</span>
    </a>
  </li>
</ul>

<div id="cv-content">
  {{ cv_content | markdownify }}
</div>

<script>
document.getElementById("download-pdf").addEventListener("click", (e) => {
  e.preventDefault();
  // Set the document title to control the default filename
  const originalTitle = document.title;
  document.title = "{{page.cv_filename}}.pdf";
  
  window.print();
  
  // Reset the title after printing
  setTimeout(() => {
    document.title = originalTitle;
  }, 100);
});
</script>

<style>
@media print {
  /* Hide everything except the CV content */
  html, body {
    margin: 0 !important;
    padding: 0 !important;
    height: auto !important;
    overflow: visible !important;
  }
  
  body * {
    visibility: hidden;
  }
  
  /* Make CV content visible and position it at the top */
  #cv-content, #cv-content * {
    visibility: visible;
  }
  
  #cv-content {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    margin: 0 !important;
    padding: 0 !important;
  }
  
  /* Remove margins from first elements */
  #cv-content h1:first-child,
  #cv-content h2:first-child,
  #cv-content h3:first-child,
  #cv-content > *:first-child {
    margin-top: 0 !important;
    padding-top: 0 !important;
  }
  
  /* Hide the print button */
  #download-pdf {
    display: none;
  }
  
  /* Set page margins - this is the critical part */
  @page {
    size: auto;
    margin: 0.9cm;
  }
  
  /* Reset any fixed positioning that might affect layout */
  header, footer, nav, .sidebar, .header, .footer, .navigation {
    display: none !important;
  }
}
</style>
