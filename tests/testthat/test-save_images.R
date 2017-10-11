context("save_images")

test_that("save_images works", {
  save_images(dplyr::filter(ljosa2013,
                            Metadata_Plate == "Week1_22123" &
                              Metadata_Well == "B04"),
              per_row = 2)


  a <-
    EBImage::readImage("cytochalasin_b_10_Week1_22123_B04_Actin.jpg")

  b <-
    EBImage::readImage(
      system.file("extdata", "cytochalasin_b_10_Week1_22123_B04_Actin.jpg",
                  package = "cytoplot"))

  expect_equal(a, b)

  file.remove("cytochalasin_b_10_Week1_22123_B04_Actin.jpg")
  file.remove("cytochalasin_b_10_Week1_22123_B04_DAPI.jpg")
  file.remove("cytochalasin_b_10_Week1_22123_B04_Tubulin.jpg")
})
