---
title: "Hyperbolicity of General Relativity in Bondi-like gauges"
authors:
- admin
- David Hilditch
- Miguel Zilhão
date: "2020-09-15"
doi: "10.1103/PhysRevD.102.064035"
# Publication type.
# Accepts a single type but formatted as a YAML list (for Hugo requirements).
# Enter a publication type from the CSL standard.
publication_types: ["article-journal"]


abstract: Bondi-like (single-null) characteristic formulations of general relativity are used for numerical work in both asymptotically flat and anti–de Sitter spacetimes. The well posedness of the resulting systems of partial differential equations, however, remains an open question. The answer to this question affects accuracy and, potentially, the reliability of conclusions drawn from numerical studies based on such formulations. A numerical approximation can converge to the continuum limit only for well-posed systems; for the initial value problem in the L2 norm, this is characterized by strong hyperbolicity. We find that, due to a shared pathological structure, the systems arising from the aforementioned formulations are, however, only weakly hyperbolic. We present numerical tests for toy models that demonstrate the consequence of this shortcoming in practice for the characteristic initial boundary value problem. Working with alternative norms in which our model problems may be well posed, we show that convergence may be recovered. Finally, we examine the well posedness of a model for Cauchy-characteristic matching in which model symmetric and weakly hyperbolic systems communicate through an interface, with the latter playing the role of general relativity in the Bondi gauge on characteristic slices. We find that, due to the incompatibility of the norms associated with the two systems, the composite problem does not naturally admit energy estimates.

tags:
#- Source Themes
featured: false
# links:
# - name: ""
#   url: ""
url_pdf: https://arxiv.org/pdf/2007.06419.pdf
url_code: 'https://github.com/ThanasisGiannakopoulos/BondiToy'
url_dataset: 'https://zenodo.org/records/3929666'
#url_poster: ''
url_project: ''
#url_slides: ''
#url_source: ''
#url_video: ''

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  caption: 'Convergence tests in a lopsided norm'
  focal_point: ""
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
projects: [characteristic_gr]

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
#slides: example
---
