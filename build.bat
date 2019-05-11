pandoc --toc --filter pandoc-fignos --filter pandoc-citeproc --bibliography=references.bib --csl=ieee.csl^
  --template=./kandi_template.latex kandi.md -o kandi.pdf

kandi.pdf