\name{mesh2D}
\alias{mesh2D}
\title{Parse a 2D mesh file and plot the data}
\usage{
plotMesh(readMeshFileATLAS(<file name>)
}
\description{
Mesh files are used in FEM solutions for PDE problems to describe the geometry of the problem and the materials.

This package is used to parse a 2D mesh file in ATLAS format and plot the 2D mesh using a plot3D function. The function readMeshFileATLAS is loading a mesh data file in ATLAS format. Then use plotMesh to plot the data (elements and nodes) composing the mesh.
}
\examples{
plotMesh(readMeshFileATLAS("data/pre_geom2D.atl")
}
\figure{
plot_mesh_example.png}{options: width="60\%" alt="Figure: plot_mesh_example.png"
}

