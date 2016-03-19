# idconv

An R package to convert hg19 (GRCh37) identifiers

# Installation  

```
devtools::install_github("uhlitz/idconv")
```

# Example

```
library(idconv)
SYMBOL_to_ENTREZ(c("EGR1", "FOS"))
ENTREZ_to_SYMBOL(c("1958", "2353"))
SYMBOL_to_ENSEMBL(c("EGR1", "FOS"))
ENSEMBL_to_SYMBOL(c("ENSG00000120738", "ENSG00000170345"))
```
