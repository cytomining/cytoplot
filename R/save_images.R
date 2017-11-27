#' Save images
#'
#' @param df ...
#' @param per_row ...
#' @param max_intensity ...
#' @param type ...
#' @param quality ...
#' @param output_dir ...
#' @param is_url ...
#'
#' @return list of file names
#'
#' @importFrom magrittr %>%
#' @importFrom magrittr %<>%
#'
#' @export
#'
save_images <- function(df,
                        is_url = TRUE,
                        max_intensity = NULL,
                        output_dir = ".",
                        per_row = 3,
                        quality = 50,
                        site_order = NULL,
                        type = "jpg") {
  #TODO:implement !is_url
  stopifnot(is_url)

  df %>%
    tidyr::unite(group_id, Metadata_Plate, Metadata_Well, remove = FALSE) %>%
    split(.$group_id) %>%
    purrr::map(function(per_well) {
      per_well %>%
        dplyr::select(Metadata_Plate, Metadata_Well, Metadata_Site,
                      dplyr::matches("URL")) %>%
        tidyr::gather(Metadata_Channel, Metadata_URL,
                      -Metadata_Plate, -Metadata_Well, -Metadata_Site) %>%
        dplyr::arrange(Metadata_Channel, Metadata_Site)  %>%
        dplyr::rowwise() %>%
        dplyr::mutate(Metadata_Channel =
                        stringr::str_replace(Metadata_Channel, "URL_", "")) %>%
        dplyr::ungroup() %>%
        split(.$Metadata_Channel) %>%
        purrr::map(function(per_channel) {

          if (!is.null(site_order)) {

            per_channel %<>%
              rowwise() %>%
              mutate(Metadata_Site_ordered =
                       order(site_order)[[Metadata_Site]]) %>%
              ungroup()

            per_channel %<>%
              dplyr::arrange(Metadata_Site_ordered)

          } else {
            per_channel %<>%
              dplyr::arrange(Metadata_Site)

          }

          image <-
            per_channel$Metadata_URL %>%
            purrr::map(EBImage::readImage) %>%
            EBImage::combine() %>%
            EBImage::tile(nx = per_row, lwd = 0)

          if (!is.null(max_intensity)) {
            channel_name <-
              per_channel %>%
              dplyr::slice(1) %>%
              magrittr::extract2("Metadata_Channel")

            image %<>%
              EBImage::normalize(inputRange =
                                   c(0, max_intensity[[channel_name]]))
          }

          image_filename <-
            per_channel %>%
            dplyr::slice(1) %>%
            tidyr::unite(filename, Metadata_Plate,
                         Metadata_Well, Metadata_Channel) %>%
            dplyr::rowwise() %>%
            dplyr::mutate(filename = stringr::str_c(filename, ".", type)) %>%
            dplyr::ungroup() %>%
            magrittr::extract2("filename")

          image_filename <-
            file.path(output_dir, image_filename) %>%
            normalizePath()

          EBImage::writeImage(image, image_filename, quality = quality)

          image_filename

        })

    })
}
