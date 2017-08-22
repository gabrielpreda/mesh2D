# mesh2D

Parse a 2D mesh file and plot the data

## Getting Started

Mesh files are used in FEM solutions for PDE problems to describe the geometry of the problem and the materials.

This package is used to parse a 2D mesh file in ATLAS format and plot the 2D mesh using a *plot3D* function, *polygon2D*. The function readMeshFileATLAS is loading a mesh data file in ATLAS format. Then use plotMesh to plot the data (elements and nodes) composing the mesh.

This package is using R6 (object oriented R allowing easy manipulation of nodes and elements in the data structure).

### Prerequisites

To install this project you will need RStudio (version 1.0.1 or above recommended) and R (version 3.4 or above recommended). Also, you will need to install *plot3D* package

```
install.packeges("plot3D")
```

### Installing

Installation of the project is straightforward using RStudio. Alternativelly, after you build the package archive using RStudio, you can also install the package with the regular R command

```
install.packeges("mesh2D")
```

## Running the tests

To run the tests, you can load the project in RStudio and select *Build*/*Test Package* command from the menu.

## Example of usage

The package includes a data file *data/pre_geom2D.atl*. This data file is used in the test package as well. To test the package functionality with this data file and inspect the resulted plot, here is a code snapshot to be used

````
#read the data file and populate a mesh object 'dat'
dat <- mesh2D::readMeshFileATLAS("data/pre_geom2D.atl")
#plot the mesh in a 2D polygon plot
plotMesh(dat)

````

## Authors

* **Gabriel Preda** - *Initial work* - [mesh2D](https://github.com/gabrielpreda/mesh2D)

## License

This project is licensed under the Apache License 2.0



