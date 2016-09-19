context("save_images")

## TODO: Rename context
## TODO: Add more tests

test_that("save_images works", {
  df <- ljosa2013
  save_images(dplyr::slice(ljosa2013, 1),
              per_row = 3)
})
