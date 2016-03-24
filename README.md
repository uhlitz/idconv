idconv
================

Wrapper functions to convert gene identifiers available from the org.Hs.eg.db bioconductor package.

Installation
============

    ## Skipping install for github remote, the SHA1 (1fe6150a) has not changed since last install.
    ##   Use `force = TRUE` to force installation

Examples
========

``` r
library(idconv)

# wrapper functions for specific identifiers:
SYMBOL_to_ENTREZID(c("EGR1", "FOS"))
```

    ## 'select()' returned 1:1 mapping between keys and columns

    ##   EGR1    FOS 
    ## "1958" "2353"

``` r
ENTREZID_to_SYMBOL(c("1958", "2353"))
```

    ## 'select()' returned 1:1 mapping between keys and columns

    ##   1958   2353 
    ## "EGR1"  "FOS"

``` r
SYMBOL_to_ENSEMBL(c("EGR1", "FOS"))
```

    ## 'select()' returned 1:1 mapping between keys and columns

    ##              EGR1               FOS 
    ## "ENSG00000120738" "ENSG00000170345"

``` r
ENSEMBL_to_SYMBOL(c("ENSG00000120738", "ENSG00000170345"))
```

    ## 'select()' returned 1:1 mapping between keys and columns

    ## ENSG00000120738 ENSG00000170345 
    ##          "EGR1"           "FOS"

``` r
# generalised functions:
IDX_to_IDY(ids = "NM_005252", from = "REFSEQ", to = "SYMBOL")
```

    ## 'select()' returned 1:1 mapping between keys and columns

    ## NM_005252 
    ##     "FOS"
