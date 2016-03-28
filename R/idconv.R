#' Wrapper functions to convert gene identifiers in org.Hs.eg.db or org.Mm.eg.db package
#'
#' \code{IDX_to_IDY} converts ids from identifier X to identifier Y using AnnotationDbi.
#' By default, target ids are concatenated for non-unique mappings, but non-unique mappings can be
#' forced to return unique mappings. However, this is not recommended.
#'
#' @param ids vector of source identifiers to be converted to target identifiers
#' @param from source id type (e.g. "SYMBOL")
#' @param to target id type (e.g. "ENSEMBL")
#' @param to_sub target sub id type (e.g. "NM" for "REFSEQ")
#' @param force_unique by default, NAs are reported for non-unique mappings
#' @param org.db Allows to use a different annotation data base (e.g org.Mm.eg.db::org.Mm.eg.db)
#' @return A vector of converted identifiers with same length as input identifiers
#' @examples
#' SYMBOL_to_ENTREZID(c("EGR1", "FOS"))
#' ENTREZID_to_SYMBOL(c("1958", "2353"))
#' SYMBOL_to_ENSEMBL(c("EGR1", "FOS"))
#' ENSEMBL_to_SYMBOL(c("ENSG00000120738", "ENSG00000170345"))
#' @export
IDX_to_IDY <- function(ids, from, to, to_sub = NULL, force_unique = F,
                       org.db = org.Hs.eg.db::org.Hs.eg.db) {

  # generate mapping table
  id_df <- AnnotationDbi::select(org.db, keys = unique(ids),
                                 columns = c(from, to),
                                 keytype = from)

  if(!is.null(to_sub)) {

    id_df <- id_df[grep(to_sub, id_df[, to]), ]

  }

  if(force_unique == T & !is.na(force_unique)) {

    # force mappings to be unique if desired (not recommended)
    id_df <- id_df[match(unique(id_df[, from]), id_df[, from]), ]

  } else if (force_unique == F | is.na(force_unique)) {

    # better concatenate all values for non-unique mappings or return NAs
    # for this, first determine non unique ids
    non_unique_ids <- ids[rle(id_df[, from])$lengths > 1]

    if (is.na(force_unique)) {

      # ...or set them NA
      id_df[id_df[, from] %in% non_unique_ids, to] <- NA

    }

    else {

      # and concatenate them...
      id_df[id_df[, from] %in% non_unique_ids, to] <-
        paste(id_df[id_df[, from] %in% non_unique_ids, to], collapse= ";")

    }

    # and finally reduce the data.frame to have unique ids
    id_df <- id_df[match(unique(id_df[, from]), id_df[, from]), ]


  } else {

    stop("force_unique must be NA, TRUE or FALSE")

  }

  # return vector of mappings
  setNames(id_df[, to], id_df[, from])[ids]

}

IDX_to_IDY_Hs <- function(ids, from, to, to_sub, force_unique = F) {
  IDX_to_IDY(ids = ids, from = from, to = to, to_sub = to_sub,
             force_unique = force_unique, org.db = org.Hs.eg.db::org.Hs.eg.db)
}

IDX_to_IDY_Mm <- function(ids, from, to, to_sub, force_unique = F) {
  IDX_to_IDY(ids = ids, from = from, to = to, to_sub = to_sub,
             force_unique = force_unique, org.db = org.Mm.eg.db::org.Mm.eg.db)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to ENTREZID
#' @export
SYMBOL_to_ENTREZID  <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "SYMBOL", "ENTREZID", NULL, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from ENTREZID to SYMBOL
#' @export
ENTREZID_to_SYMBOL  <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "ENTREZID", "SYMBOL", NULL, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to ENSEMBL
#' @export
SYMBOL_to_ENSEMBL <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "SYMBOL", "ENSEMBL", NULL, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from ENSEMBL to SYMBOL
#' @export
ENSEMBL_to_SYMBOL <- function(ids, force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "ENSEMBL", "SYMBOL", NULL, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to REFSEQ
#' @export
SYMBOL_to_REFSEQ <- function(ids, to_sub = "NM", force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "SYMBOL", "REFSEQ", to_sub = to_sub, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from REFSEQ to SYMBOL
#' @export
REFSEQ_to_SYMBOL <- function(ids, to_sub = "NM", force_unique = F) {
  IDX_to_IDY_Hs(ids = ids, "REFSEQ", "SYMBOL", to_sub = to_sub, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to ENTREZID (murine)
#' @export
SYMBOL_to_ENTREZID_Mm  <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "SYMBOL", "ENTREZID", NULL, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from ENTREZID to SYMBOL (murine)
#' @export
ENTREZID_to_SYMBOL_Mm  <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "ENTREZID", "SYMBOL", NULL, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to ENSEMBL (murine)
#' @export
SYMBOL_to_ENSEMBL_Mm <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "SYMBOL", "ENSEMBL", NULL, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from ENSEMBL to SYMBOL (murine)
#' @export
ENSEMBL_to_SYMBOL_Mm <- function(ids, force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "ENSEMBL", "SYMBOL", NULL, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from SYMBOL to REFSEQ (murine)
#' @export
SYMBOL_to_REFSEQ_Mm <- function(ids, to_sub = "NM", force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "SYMBOL", "REFSEQ", to_sub = to_sub, force_unique = force_unique)
}

#' @describeIn IDX_to_IDY convert from REFSEQ to SYMBOL (murine)
#' @export
REFSEQ_to_SYMBOL_Mm <- function(ids, to_sub = "NM", force_unique = F) {
  IDX_to_IDY_Mm(ids = ids, "REFSEQ", "SYMBOL", to_sub = to_sub, force_unique = force_unique)
}

