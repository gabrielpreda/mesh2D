test_that("data has right dimmensions", {

  dat <- mesh2D::readMeshFileATLAS("../../data/pre_geom2D.atl")
  nNodes = 207
  nElements = 224

  expect_equal(dat$dim[1],nNodes)
  expect_equal(dat$dim[2],nElements)
  expect_equal(length(dat$nodes),nNodes)
  expect_equal(length(dat$elements),nElements)

})
