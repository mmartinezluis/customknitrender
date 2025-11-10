
<!-- README.md is generated from README.Rmd. Please edit that file -->

# customknitrender

<!-- badges: start -->

<!-- badges: end -->

The goal of customknitrender is to make it easy to switch between output
formats for rmarkdown files when the files share the `output` yaml
parameter from a single source.

## Installation

You can install the development version of customknitrender from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mmartinezluis/customknitrender")
```

## Usage

<!-- ```text -->

<!--   ProjectRoot -->

<!--   ├── Data -->

<!--   │   ├── raw_data.csv -->

<!--   │   └── clean_data.csv -->

<!--   ├── Scripts -->

<!--   │   ├── data_prep.R -->

<!--   │   └── analysis.R -->

<!--   ├── Output -->

<!--   │   └── results.html -->

<!--   └── README.md -->

<!-- ``` -->

Assume that you have a project in RStudio with the following structure:

``` text
  ProjectRoot
  ├── article_1.Rmd
  ├── article_2.Rmd
  └── article_3.Rmd
```

where each article file contains the following `output` configuration
(`header-includes` is extra configuration for latex/pdf output):

``` yaml
---
output:
  pdf_document:
    latex_engine: xelatex
    number_sections: yes
  html_document: default
  word_document: default
header-includes:
  - \usepackage{ragged2e}
  - \usepackage{indentfirst}
---
```

If you wanted all article rmarkdown files to share the same `output`
rather than repeating the code within each file and, optionally, share
the same `header-includes` latex configuration, you can create an
`_output.yaml` file in the same directory where the rmarkdown files are,
and move the `output` configurations there, and also create a
`header.tex` file, and move the `header-includes` code there:

``` text
  ProjectRoot
  ├── _output.yaml
  ├── article_1.Rmd
  ├── article_2.Rmd
  ├── article_3.Rmd
  └── header.tex
```

where \_output.yaml is defined as

``` yaml
pdf_document:
  latex_engine: xelatex
  number_sections: yes
  includes:
    in_header: header.tex
html_document:
  default
word_document:
  default
```

(notice that no top-bottom dashes are needed nor the `output` key in the
yaml file), and header.tex as

``` tex
\usepackage{ragged2e}
\usepackage{indentfirst}
```

(notice that no dashes are needed in the tex file).

With this, the frontmatter of the article files reduces to

``` text
---

---
```

Now all three article files contain the same configuration for pdf,
html, and word document output (which is great when you need the same
config). However, when you press the `Knit` button from RStudio within
one of the article files, regardless of whether you press “Knit to
HTML”, “Knit to PDF”, or “Knit to Word”, the file will be knitted to
PDF. This is because the Knit button runs knitr’s `knit` function with
the first output type written in `_output.yaml`. Hence, if you wanted to
render any article file in HTML instead, you would need to move the
`word_document` key to the top of the `_output.yaml` file, save the
file, and then go to, say, article_1.Rmd, and knit the file. Hence, for
any time you would like to switch the output format, you woud need to do
a cut-paste-save in `_output.yaml`, and a save in your desired file.
Here is where the `customknitrender` package comes into play. The
package provides a function, `in_format(x)`, that you can use in the
frontmatter of your rmarkdown files to specify the desired output format
using integers:

``` yaml
---
knit: !r customknitrender::in_format(3)
---

{r}
library(customknitrender)
```

will render the file in **pdf format**, where `knit` is a key to
override the Knit button, and the syntax `!r ...` is needed to be able
to call a function within yaml content. Using

``` text
customknitrender::in_format(33)
```

renders the file in **html format**, and using any other integer
defaults to **word document** format (e.g., `in_format(333)`,
`in_format(4)`, …).
