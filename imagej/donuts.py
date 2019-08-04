#@ OpService ops
#@ UIService ui
#@OUTPUT ImgPlus phantom
#@OUTPUT ImgPlus convolved
#@OUTPUT ImgPlus deconvolved1
#@OUTPUT ImgPlus deconvolved2

from net.imglib2 import Point
from net.imglib2.algorithm.region.hypersphere import HyperSphere

xSize=200;
ySize=200;

# create an empty image
phantom=ops.create().img([xSize, ySize])

location = Point(phantom.numDimensions())
location.setPosition([xSize/2, ySize/2])

hyperSphere = HyperSphere(phantom, location, 20)

for value in hyperSphere:
        value.setReal(16)

ui.show("phantom", phantom)

psf1=ops.create().kernelGauss([2, 2])
psf2=ops.create().kernelGauss([4, 4])

# convolve psf with phantom
convolved=ops.filter().convolve(phantom, psf1)

deconvolved1=ops.deconvolve().richardsonLucy(convolved, psf1, 100);
deconvolved2=ops.deconvolve().richardsonLucy(convolved, psf2, 100);
