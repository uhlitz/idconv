#' List available fastqc analysis modules and their reported status
#'
#' \code{IDX_to_IDY} converts ids from identifier X to identifier Y using AnnotationDbi
#'
#' @param IDX input id type (e.g. "SYMBOL")
#' @param IDY output id type (e.g. "ENSEMBL")
#' @param ids vector of input identifiers to be converted to output identifiers
#' @return A vector of converted identifiers with same length as input identifiers
#' @examples
#' SYMBOL_to_ENTREZ(c("EGR1", "FOS"))
#' ENTREZ_to_SYMBOL(c("1958", "2353"))
#' SYMBOL_to_ENSEMBL(c("EGR1", "FOS"))
#' ENSEMBL_to_SYMBOL(c("ENSG00000120738", "ENSG00000170345"))
#' @export
IDX_to_IDY <- function(IDX, IDY, ids) {
  AnnotationDbi::select(org.Hs.eg.db::org.Hs.eg.db, keys = unique(ids),
                        columns = c(IDX, IDY),
                        keytype = IDX) %>%
    distinct_(IDX) %>% {
      setNames(.[ ,IDY], .[ ,IDX])
    } %>%
    .[ids]
}

SYMBOL_to_ENTREZ  <- function(ids) IDX_to_IDY("SYMBOL", "ENTREZID", ids = ids)
ENTREZ_to_SYMBOL  <- function(ids) IDX_to_IDY("ENTREZID", "SYMBOL", ids = ids)
ENSEMBL_to_SYMBOL <- function(ids) IDX_to_IDY("ENSEMBL", "SYMBOL", ids = ids)
SYMBOL_to_ENSEMBL <- function(ids) IDX_to_IDY("SYMBOL", "ENSEMBL", ids = ids)
