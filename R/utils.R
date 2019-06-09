if (!require("pacman")) install.packages("pacman")
pacman::p_load("R6")

cElement <- R6Class("cElement",
                    public=list(
                      id=NULL,
                      type=NULL,
                      material=NULL,
                      nodeID=NULL,
                      initialize = function(id, type, material, nodeID) {
                        self$id <- id
                        self$type <- type
                        self$material <- material
                        self$nodeID <- nodeID
                      }
                    )
)
cNode <-R6Class("cNode",
                public=list(
                  id=NULL,
                  x=NULL,
                  initialize = function(id, x) {
                    self$id <- id
                    self$x <- x
                  }
                )
)

# return number of vertex for an element, given the ATLAS element type
getVertexFromTypeATLAS <- function(type) {
  type <- as.integer(type)
  nV <- type - (as.integer(type/100)*100)
  return(nV)
}

#read the current line and return a vector with tokens
getStringsFromLine <- function(crtLine) {
  crtLine <- as.character(crtLine)
  crtLine <- trimws(crtLine,"left")
  crtLine <- unlist(strsplit(crtLine, split=" |[ ]+"));
  return(crtLine)
}
