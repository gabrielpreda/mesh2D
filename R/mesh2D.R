# mesh2D
#
#   This package is used to read a mesh file and plot it
#   For plot uses the package plot3D, the function polygon2D
#

library(R6)

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

# read a (2D) mesh file in ATLAS format, returns a mesh vector
# with the structure: dim(nNodes, nElements), nodes, elements
readMeshFileATLAS <- function(fileName) {
  fileName = as.character(fileName)
  conn <- file(fileName,open="r")
  linn <-readLines(conn)
  cnt = 1;
  # read the number of lines and elements
  # crtLine <- getStringsFromLine(linn[cnt])
  # nNodes <- as.integer(crtLine[1])
  # nElements <- as.integer(crtLine[2])
  # cat(sprintf("Nodes:%d, Elements: %d\n", nNodes,nElements))

  nodes <- list()
  elements <- list()
  crtLine <- getStringsFromLine(linn[cnt])
  if(crtLine[1] == "GRID") {
    cnt = cnt + 1;
    i = 1;
    while(as.integer((crtLine <- getStringsFromLine(linn[cnt]))[1]) != -1) {
      nodes[[i]] <- cNode$new(as.integer(crtLine[1]), as.numeric(crtLine[2:4]))
      i = i + 1;
      cnt = cnt + 1;
    }
  }
  nNodes <- length(nodes)
  cnt = cnt + 1;
  crtLine <- getStringsFromLine(linn[cnt])
  if(crtLine[1] == "CONC") {
    cnt = cnt + 1;
    i = 1;
    while(as.integer((crtLine <- getStringsFromLine(linn[cnt]))[1]) != -1) {
      nV <- getVertexFromTypeATLAS(as.integer(crtLine[2]))
      elements[[i]]<- cElement$new(as.integer(crtLine[1]),
                                   as.integer(crtLine[2]),
                                   as.integer(crtLine[3]),
                                   as.integer(crtLine[4:(3+nV)]))
      i = i + 1;
      cnt = cnt + 1;
    }
  }
  nElements <- length(elements)
  close(conn)

  mesh_data = list(dim = c(nNodes, nElements), nodes=nodes, elements=elements)
  return(mesh_data)
}

#
# plot a 2D mesh, given a mesh_data list
#
plotMesh <- function(mesh_data)
{
  elements <- mesh_data$elements
  nodes <- mesh_data$nodes
  nElements <- mesh_data$dim[2]
  cnt <- 0
  x <- vector();  y <- vector();  colorMaterial <- vector()

  for(i in 1:nElements) {
    type <- elements[[i]]$type
    nV <- getVertexFromTypeATLAS(type)
    for(j in 1:nV) {
      crtID <- elements[[i]]$nodeID[j]
      x[cnt+j] <- nodes[[crtID]]$x[1]
      y[cnt+j] <- nodes[[crtID]]$x[2]
    }
    if(i < nElements) {
      x[cnt + nV + 1] <- NA
      y[cnt + nV + 1] <- NA
    }
    colorMaterial[i] <- elements[[i]]$material

    cnt = cnt + nV + 1;
  }

  library(plot3D)
  polygon2D(x,y, border = "black", lwd = 1, colvar = colorMaterial, alpha= 0.2)
}
