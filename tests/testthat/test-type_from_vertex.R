test_that("type of element translate in correct number of vertexes", {

  expect_equal(getVertexFromTypeATLAS("102"),2)
  expect_equal(getVertexFromTypeATLAS("203"),3)
  expect_equal(getVertexFromTypeATLAS("204"),4)
  expect_equal(getVertexFromTypeATLAS("304"),4)
  expect_equal(getVertexFromTypeATLAS("308"),8)

})
