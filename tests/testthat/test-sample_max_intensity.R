context("sample_max_intensity")

test_that("sample_max_intensity works", {

  expect_equal(
    ljosa2013 %>%
      dplyr::filter(Metadata_Plate == "Week1_22123" &
                      Metadata_Well == "B02") %>%
      sample_max_intensity(),
    list(Actin = 0.0869739833676661,
         DAPI = 0.0417340352483406,
         Tubulin = 0.197937590600443))

})
