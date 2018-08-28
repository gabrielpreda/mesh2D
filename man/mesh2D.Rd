\name{mesh2D}
\alias{mesh2D}
\title{Parse a 2D mesh file and plot the data}
\usage{
Plot a mesh:
plotMesh(readMeshFileATLAS(<file name>))

Plot the mesh for a list of material domains:
plotMesh(readMeshFileATLAS(<file name>), <list-of-domains>)

Plot the mesh for a list of material domains, specify if solid domains are shown:
plotMesh(readMeshFileATLAS("data/pre_geom2D.atl"), <list-of-domains>, <showElem>)

Plot the mesh for a list of material domains, specify if solid domains and edges are shown:
plotMesh(readMeshFileATLAS("data/pre_geom2D.atl"), <list-of-domains>, <showElem>,<showEdges>)
}
\description{
Mesh files are used in FEM solutions for PDE problems to describe the geometry of the problem and the materials.

This package is used to parse a 2D mesh file in ATLAS format and plot the 2D mesh using a plot3D function. The function readMeshFileATLAS is loading a mesh data file in ATLAS format. Then use plotMesh to plot the data (elements and nodes) composing the mesh.
}
\examples{
Plot a mesh:
plotMesh(readMeshFileATLAS("data/pre_geom2D.atl"))

Plot the mesh for a list of material domains (1,2 and 4):
plotMesh(readMeshFileATLAS("data/pre_geom2D.atl"), c(1:2,4))

Plot the mesh for a list of material domains (1,3), specify to show only material domains:
plotMesh(readMeshFileATLAS("data/pre_geom2D.atl"), c(1,3), showElem=TRUE)

Plot the mesh for a list of material domains (2,4), specify to show as wireframes:
plotMesh(readMeshFileATLAS("data/pre_geom2D.atl"), c(2,4), showElem=FALSE, showEdges=FALSE)
}
\figure{
plot_mesh_example.png}{options: width="60\%" alt="Figure: plot_mesh_example.png"
}

