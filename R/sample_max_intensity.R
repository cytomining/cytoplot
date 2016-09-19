#' Robust max intensity
#'
#' @param df ...
#' @param is_url ...
#'
#' @return robust max intensities per channel
#'
#' @importFrom magrittr %>%
#' @importFrom stats quantile
#'
#' @export
#'
sample_max_intensity <- function(df, is_url=TRUE) {
  #TODO:implement !is.url
  stopifnot(is_url)

  df %>%
    dplyr::select(dplyr::matches("URL")) %>%
    tidyr::gather(Metadata_Channel, Metadata_URL) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(Metadata_Channel =
                    stringr::str_replace(Metadata_Channel, "URL_", "")) %>%
    dplyr::ungroup() %>%
    split(.$Metadata_Channel) %>%
    purrr::map(function(per_channel) {
      per_channel$Metadata_URL %>%
        purrr::map(EBImage::readImage) %>%
        purrr::map_dbl(function(image) {
          quantile(EBImage::imageData(image), c(.98))[[1]]
        }) %>%
        quantile(., c(.98)) %>%
        magrittr::extract2("98%")
    })
}

