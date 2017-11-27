context("sample_max_intensity")

test_that("sample_max_intensity works", {

  expect_equal(
    ljosa2013 %>%
      dplyr::filter(Metadata_Plate == "Week1_22123" &
                      Metadata_Well == "B02") %>%
      sample_max_intensity(),
    list(Actin = 0.08764782177462424,
         DAPI = 0.04174868390936141,
         Tubulin = 0.1989776455329213))

})
