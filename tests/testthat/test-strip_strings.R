test_that("strip strings working well", {

  expect_equal(length(getStringsFromLine("1 2 3 4")),4)
  expect_equal(length(getStringsFromLine("12 23 34 3456 321")),5)
  expect_equal(getStringsFromLine("abcdef"),"abcdef")
  expect_equal(getStringsFromLine("ab cd ef gh"),c("ab", "cd", "ef", "gh"))
  expect_equal(length(getStringsFromLine("203 1 2 1 2 3 4+
                                         5 6 7 8")),11)
})
