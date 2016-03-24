idconv
================

Wrapper functions to convert gene identifiers available from the org.Hs.eg.db bioconductor package.

Installation
============


    devtools::install_github("uhlitz/idconv")

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

Non-unique mappings
===================

If more than one mapping is available, `AnnotationDbi` returns a warning (1:many mappings) and `idconv` wrapper functions return NAs for target ids by default. If desired, wrapper functions in this package can be forced to return unique mappings. Forcing unique mappings is however not recommended.

``` r
# example for non-unique mapping:
SYMBOL_to_ENSEMBL("IER3")
```

    ## 'select()' returned 1:many mapping between keys and columns

    ## IER3 
    ##   NA

``` r
SYMBOL_to_ENSEMBL("IER3", force_unique = T)
```

    ## 'select()' returned 1:many mapping between keys and columns

    ##              IER3 
    ## "ENSG00000137331"
