# idconv

Wrapper functions to convert gene identifiers available from the org.Hs.eg.db package.

# Installation  

```
devtools::install_github("uhlitz/idconv")
```

# Examples

```
library(idconv)
SYMBOL_to_ENTREZID(c("EGR1", "FOS"))
ENTREZID_to_SYMBOL(c("1958", "2353"))
SYMBOL_to_ENSEMBL(c("EGR1", "FOS"))
ENSEMBL_to_SYMBOL(c("ENSG00000120738", "ENSG00000170345"))
IDX_to_IDY(ids = "NM_005252", from = "REFSEQ", to = "SYMBOL")
```

