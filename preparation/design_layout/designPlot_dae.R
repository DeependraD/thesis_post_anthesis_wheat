
require(dae)
data(package = "dae")
data(package = "agridat")
designPlot(des.mat, labels=1:4, col="lightblue", new=TRUE, plotcellboundary = TRUE,
           rtitle="Lanes", ctitle="Positions", chardivisor=3,
           rcellpropn = 1, ccellpropn=1)
designPlot(des.mat, labels=5:87, plotlabels=TRUE, col="grey", chardivisor=3, new=FALSE,
           plotcellboundary = TRUE)
designPlot(des.mat, labels=88:434, plotlabels=TRUE, col="lightgreen", chardivisor=3,
           new=FALSE, plotcellboundary = TRUE,
           blocksequence=TRUE, blockdefinition=cbind(4,10,12),
           blocklinewidth=3, blockcolour="blue")