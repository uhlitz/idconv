#' List available fastqc analysis modules and their reported status
#'
#' \code{IDX_to_IDY} converts ids from identifier X to identifier Y using AnnotationDbi
#'
#' @param IDX input id type (e.g. "SYMBOL")
#' @param IDY output id type (e.g. "ENSEMBL")
#' @param ids vector of input identifiers to be converted to output identifiers
#' @return A vector of converted identifiers with same length as input identifiers
#' @examples
#' SYMBOL_to_ENTREZID(c("EGR1", "FOS"))
#' ENTREZID_to_SYMBOL(c("1958", "2353"))
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
#' @describeIn IDX_to_IDY convert from SYMBOL to ENTREZID
#' @export
SYMBOL_to_ENTREZID  <- function(ids) IDX_to_IDY("SYMBOL", "ENTREZID", ids = ids)

#' @describeIn IDX_to_IDY convert from ENTREZID to SYMBOL
#' @export
ENTREZID_to_SYMBOL  <- function(ids) IDX_to_IDY("ENTREZID", "SYMBOL", ids = ids)

#' @describeIn IDX_to_IDY convert from SYMBOL to ENSEMBL
#' @export
SYMBOL_to_ENSEMBL <- function(ids) IDX_to_IDY("SYMBOL", "ENSEMBL", ids = ids)

#' @describeIn IDX_to_IDY convert from ENSEMBL to SYMBOL
#' @export
ENSEMBL_to_SYMBOL <- function(ids) IDX_to_IDY("ENSEMBL", "SYMBOL", ids = ids)

#' @describeIn IDX_to_IDY convert from SYMBOL to REFSEQ
#' @export
SYMBOL_to_REFSEQ <- function(ids) IDX_to_IDY("SYMBOL", "REFSEQ", ids = ids)

#' @describeIn IDX_to_IDY convert from REFSEQ to SYMBOL
#' @export
REFSEQ_to_SYMBOL <- function(ids) IDX_to_IDY("REFSEQ", "SYMBOL", ids = ids)
