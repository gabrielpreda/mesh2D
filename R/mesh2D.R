# mesh2D
#
#   This package is used to read a mesh file and plot it
#   For plot uses the package plot3D, the function polygon2D
#


# read a (2D) mesh file in ATLAS format, returns a mesh vector
# with the structure: dim(nNodes, nElements), nodes, elements
readMeshFileATLAS <- function(fileName) {
  fileName = as.character(fileName)
  conn <- file(fileName,open="r")
  linn <-readLines(conn)
  cnt = 1;

  #initialize the nodes and elements lists
  nodes <- list()
  elements <- list()

  # read nodes
  if((crtLine <- getStringsFromLine(linn[cnt]))[1] == "GRID") {
    cnt = cnt + 1;
    i = 1;
    while(as.integer((crtLine <- getStringsFromLine(linn[cnt]))[1]) != -1) {
      nodes[[i]] <- cNode$new(as.integer(crtLine[1]), as.numeric(crtLine[2:4]))
      i = i + 1;
      cnt = cnt + 1;
    }
  }
  #set the nodes list dimmensions
  nNodes <- length(nodes)

  cnt = cnt + 1;
  #read elements
  if((crtLine <- getStringsFromLine(linn[cnt]))[1] == "CONC") {
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
  #set the elements list dimmension
  nElements <- length(elements)
  close(conn)

  #return a mesh data object containing the dimmensions for nodes and elements list and the lists of nodes and elements
  mesh_data = list(dim = c(nNodes, nElements), nodes=nodes, elements=elements)
  return(mesh_data)
}

#
# plot a 2D mesh, given a mesh_data list
#

plotMesh <- function(mesh_data, domains=NA,showEdges=TRUE, showElem=TRUE)
{

  elements <- mesh_data$elements
  nodes <- mesh_data$nodes
  nElements <- mesh_data$dim[2]
  cnt <- 0
  x <- vector();  y <- vector();  colorMaterial <- vector()

  for(i in 1:nElements) {
    mat = elements[[i]]$material
    if(!is.na(domains))
      colorMaterial[i] <- NA
    else
      colorMaterial[i]<- mat
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
    if(mat %in% domains)
      colorMaterial[i] <- mat
    cnt = cnt + nV + 1;
  }

  library(plot3D)
  palette = c("red", "blue", "green", "magenta", "lightblue", "yellow", "cyan", "tomato", "gold", "darkblue")
  if(!is.na(domains))
    col = palette[min(domains):max(domains)]
  else
    col = palette

  facets=FALSE
  border = NA

  if(showElem)
    facets=TRUE
  if(showEdges)
    border = "white"

  polygon2D(x,y, border = border, NAcol = "white", lwd = 0.5, colvar = colorMaterial, col=col, alpha= 1, facets = facets)

}
