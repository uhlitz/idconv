#' Wrapper functions to convert gene identifiers in org.Hs.eg.db package
#'
#' \code{IDX_to_IDY} converts ids from identifier X to identifier Y using AnnotationDbi
#'
#' @param from source id type (e.g. "SYMBOL")
#' @param to target id type (e.g. "ENSEMBL")
#' @param ids vector of source identifiers to be converted to target identifiers
#' @return A vector of converted identifiers with same length as input identifiers
#' @examples
#' SYMBOL_to_ENTREZID(c("EGR1", "FOS"))
#' ENTREZID_to_SYMBOL(c("1958", "2353"))
#' SYMBOL_to_ENSEMBL(c("EGR1", "FOS"))
#' ENSEMBL_to_SYMBOL(c("ENSG00000120738", "ENSG00000170345"))
#' @export
IDX_to_IDY <- function(ids, from, to) {
  id_df <- AnnotationDbi::select(org.Hs.eg.db::org.Hs.eg.db, keys = unique(ids),
                                 columns = c(from, to),
                                 keytype = from)
  id_df <- id_df[match(unique(id_df[, from]), id_df[, to]), ]
  setNames(id_df[, to], id_df[, from])[ids]
}

#' @describeIn IDX_to_IDY convert from SYMBOL to ENTREZID
#' @export
SYMBOL_to_ENTREZID  <- function(ids) IDX_to_IDY(ids = ids, "SYMBOL", "ENTREZID")

#' @describeIn IDX_to_IDY convert from ENTREZID to SYMBOL
#' @export
ENTREZID_to_SYMBOL  <- function(ids) IDX_to_IDY(ids = ids, "ENTREZID", "SYMBOL")

#' @describeIn IDX_to_IDY convert from SYMBOL to ENSEMBL
#' @export
SYMBOL_to_ENSEMBL <- function(ids) IDX_to_IDY(ids = ids, "SYMBOL", "ENSEMBL")

#' @describeIn IDX_to_IDY convert from ENSEMBL to SYMBOL
#' @export
ENSEMBL_to_SYMBOL <- function(ids) IDX_to_IDY(ids = ids, "ENSEMBL", "SYMBOL")

#' @describeIn IDX_to_IDY convert from SYMBOL to REFSEQ
#' @export
SYMBOL_to_REFSEQ <- function(ids) IDX_to_IDY(ids = ids, "SYMBOL", "REFSEQ")

#' @describeIn IDX_to_IDY convert from REFSEQ to SYMBOL
#' @export
REFSEQ_to_SYMBOL <- function(ids) IDX_to_IDY(ids = ids, "REFSEQ", "SYMBOL")
