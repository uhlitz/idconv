#' Wrapper functions to convert gene identifiers in org.Hs.eg.db package
#'
#' \code{IDX_to_IDY} converts ids from identifier X to identifier Y using AnnotationDbi.
#' By default, NAs are reported for non-unique mappings, but non-unique mappings can be
#' forced to return unique mappings. However, this is not recommended.
#'
#' @param ids vector of source identifiers to be converted to target identifiers
#' @param from source id type (e.g. "SYMBOL")
#' @param to target id type (e.g. "ENSEMBL")
#' @param force_unique by default, NAs are reported for non-unique mappings
#' @param org.db Allows to use a different annotation data base (e.g org.Mm.eg.db)
#' @return A vector of converted identifiers with same length as input identifiers
#' @examples
#' SYMBOL_to_ENTREZID(c("EGR1", "FOS"))
#' ENTREZID_to_SYMBOL(c("1958", "2353"))
#' SYMBOL_to_ENSEMBL(c("EGR1", "FOS"))
#' ENSEMBL_to_SYMBOL(c("ENSG00000120738", "ENSG00000170345"))
#' @export
IDX_to_IDY <- function(ids, from, to, force_unique = F, org.db = org.Hs.eg.db::org.Hs.eg.db) {

  # generate mapping table
  id_df <- AnnotationDbi::select(org.db, keys = unique(ids),
                                 columns = c(from, to),
                                 keytype = from)

  if(force_unique) {

    # force mappings to be unique if desired (not recommended)
    id_df <- id_df[match(unique(id_df[, from]), id_df[, from]), ]

  } else {

    # better through NAs for non-unique mappings
    non_unique_ids <- ids[rle(id_df[, from])$lengths > 1]
    id_df[id_df$SYMBOL %in% non_unique_ids, to] <- NA
    id_df <- id_df[match(unique(id_df[, from]), id_df[, from]), ]

  }

  # return vector of mappings
  setNames(id_df[, to], id_df[, from])[ids]

}

IDX_to_IDY_Hs <- function(ids, from, to, force_unique = F) {
  IDX_to_IDY(ids = ids, from = from, to = to,
             force_unique = force_unique, org.db = org.Hs.eg.db::org.Hs.eg.db)
}

IDX_to_IDY_Mm <- function(ids, from, to, force_unique = F) {
  IDX_to_IDY(ids = ids, from = from, to = to,
             force_unique = force_unique, org.db = org.Mm.eg.db::org.Mm.eg.db)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to ENTREZID
#' @export
SYMBOL_to_ENTREZID  <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "SYMBOL", "ENTREZID", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from ENTREZID to SYMBOL
#' @export
ENTREZID_to_SYMBOL  <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "ENTREZID", "SYMBOL", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to ENSEMBL
#' @export
SYMBOL_to_ENSEMBL <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "SYMBOL", "ENSEMBL", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from ENSEMBL to SYMBOL
#' @export
ENSEMBL_to_SYMBOL <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "ENSEMBL", "SYMBOL", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to REFSEQ
#' @export
SYMBOL_to_REFSEQ <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "SYMBOL", "REFSEQ", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from REFSEQ to SYMBOL
#' @export
REFSEQ_to_SYMBOL <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "REFSEQ", "SYMBOL", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from Symbol to Entrezid
#' @export
Symbol_to_Entrezid_  <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "SYMBOL", "ENTREZID", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from Entrezid to Symbol
#' @export
Entrezid_to_Symbol  <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "ENTREZID", "SYMBOL", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from Symbol to Ensembl
#' @export
Symbol_to_Ensembl <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "SYMBOL", "ENSEMBL", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from Ensembl to Symbol
#' @export
Ensembl_to_Symbol <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "ENSEMBL", "SYMBOL", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from Symbol to Refseq
#' @export
Symbol_to_Refseq <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "SYMBOL", "REFSEQ", force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from Refseq to Symbol
#' @export
Refseq_to_Symbol <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "REFSEQ", "SYMBOL", force_unique = force_unique)
}

