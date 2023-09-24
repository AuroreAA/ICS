---
title: 'ICS: A new implementation and numerically stable algorithms for invariant coordinate selection in R'
tags:
- R
- dimension reduction
- exploratory data analysis
- numerical stability
- scatter matrices
date: "24 September 2023"
output:
  html_document:
    df_print: paged
authors:
- name: Andreas Alfons
  orcid: 0000-0002-2513-3788
  affiliation: 1
- name: Aurore Archimbaud^[Corresponding author]
  orcid: 0000-0002-6511-9091
  affiliation: 1
- name: Klaus Nordhausen
  orcid: 0000-0002-3758-8501
  affiliation: 2
- name: Anne Ruiz-Gazen
  orcid: 0000-0001-8970-8061
  affiliation: 3
bibliography: paper.bib
affiliations:
- name: Erasmus School of Economics, Erasmus University Rotterdam, Netherlands
  index: 1
- name: Department of Mathematics and Statistics, University of Jyväskylä, Finland
  index: 2
- name: Toulouse School of Economics, Université Toulouse 1 Capitole, France
  index: 3
---


# Summary

Describe the functionality of the add-on package `ICS` [@ICS] for the statistical computing environment `R` [@RCore], similarly to the `DESCRIPTION` file.


# Statement of need

Outline the new developments: more flexible main function `ICS()`, numerically more stable algorithms (whitening, QR algorithm), object-oriented handling of scatter matrices. Mention re-implementation using `S3` classes instead of `S4` classes, as the latter are more accessible to a broader audience of `R` users. Highlight the relevance of the package by citing papers that have used it.


# Related software

Describe related packages such as `ICSOutlier` and `ICSClust`.


# Examples

Illustrate how to use the new functions as well as the advantages of the QR algorithm using the examples from the paper on the QR algorithm [@archimbaud2023].


# Acknowledgements

This work was partly supported by a grant of the \emph{Dutch Research Council} (NWO, research program Vidi, project number VI.Vidi.195.141), by the Austrian Science Fund P31881-N32, by the HiTEc COST Action (CA21163), and by the French \emph{Agence Nationale de la Recherche} under grant ANR-17-EURE-0010 (Investissements d'Avenir program).

# References
