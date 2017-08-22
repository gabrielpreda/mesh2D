test_that("plot data exists", {

  dat <- mesh2D::readMeshFileATLAS("../../data/pre_geom2D.atl")
  plotMesh(dat)
  expect_equal(file.exists("Rplots.pdf"),TRUE)
})
