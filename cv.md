---
layout: page
title: Curriculum Vitae
cv_filename: nir_ben_zvi_cv
share-title: Nir Ben Zvi - Curriculum Vitae
share-description: My full cv, covering my entire professional experience.

---

{% capture cv_content %}
{% include {{page.cv_filename}}.md %}
{% endcapture %}

<ul class="list-inline text-center footer-links">
  <li class="list-inline-item">
    <a id="download-pdf" href="{{ "/assets/" | append: page.cv_filename | append: ".pdf" | relative_url }}" download title="Download PDF">
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


<style>
/* Pull a role's bullets up under its title instead of leaving the
   theme's full paragraph margin between them. */
#cv-content p:has(+ ul) {
  margin-bottom: 0.5rem;
}

/* Keep the table for print (it lays out cleanly in the PDF), but let the
   cells wrap on narrow screens instead of squeezing six columns. */
@media screen and (max-width: 600px) {
  #cv-content .cv-links tr {
    display: flex;
    flex-wrap: wrap;
    column-gap: 1.5rem;
    row-gap: 0.25rem;
  }
  #cv-content .cv-links td {
    display: block;
    padding: 0;
  }
}

@media print {
  nav, footer, .intro-header, #download-pdf {
    display: none !important;
  }
}
</style>
