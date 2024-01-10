---
title: "Numerical convergence of model Cauchy-characteristic extraction and matching"
authors:
- admin
- Nigel T. Bishop
- David Hilditch
- Denis Pollney
- Miguel Zilhão
date: "2023-11-14"
doi: "10.1103/PhysRevD.108.104033"
# Publication type.
# Accepts a single type but formatted as a YAML list (for Hugo requirements).
# Enter a publication type from the CSL standard.
publication_types: ["article-journal"]


abstract: Gravitational waves provide a powerful enhancement to our understanding of fundamental physics. To make the most of their detection we need to accurately model the entire process of their emission and propagation toward interferometers. Cauchy-characteristic extraction and matching are methods to compute gravitational waves at null infinity, a mathematical idealization of detector location, from numerical relativity simulations. Both methods can in principle contribute to modeling by providing highly accurate gravitational waveforms. An underappreciated subtlety in realizing this potential is posed by the (mere) weak hyperbolicity of the particular partial differential equation (PDE) systems solved in the characteristic formulation of the Einstein field equations. This shortcoming results from the popular choice of Bondi-like coordinates. So motivated, we construct toy models that capture that PDE structure and study Cauchy-characteristic extraction and matching with them. Where possible we provide energy estimates for their solutions and perform careful numerical norm convergence tests to demonstrate the effect of weak hyperbolicity on Cauchy-characteristic extraction and matching. Our findings strongly indicate that, as currently formulated, Cauchy-characteristic matching for the Einstein field equations would provide solutions that are, at best, convergent at an order lower than expected for the numerical method, and may be unstable. In contrast, under certain conditions, the extraction method can provide properly convergent solutions. Establishing however that these conditions hold for the aforementioned characteristic formulations is still an open problem.

tags:
#- Source Themes
featured: false
# links:
# - name: ""
#   url: ""
url_pdf: https://arxiv.org/pdf/2306.13010.pdf
url_code: 'https://github.com/ThanasisGiannakopoulos/model_CCE_CCM_public'
url_dataset: 'https://zenodo.org/records/7981430'
#url_poster: ''
url_project: ''
#url_slides: ''
#url_source: ''
#url_video: ''

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  caption: 'Model CCM norm convergence tests'
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
