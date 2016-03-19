#' List available fastqc analysis modules and their reported status
#'
#' \code{get_fastqc_modules} lists avaialble analysis modules from a fastqc report
#'
#' @param file Path to fastqc_data.txt file
#' @param report_linenumbers FALSE by default
#' @return A data_frame of modules available in a fastqc_data.txt report and their report status
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
