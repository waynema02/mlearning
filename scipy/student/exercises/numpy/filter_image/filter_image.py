"""
Filter Image
------------

Read in the "dc_metro" image and use an averaging filter
to "smooth" the image.  Use a "5 point stencil" where
you average the current pixel with its neighboring pixels::

              0 0 0 0 0 0 0
              0 0 0 x 0 0 0
              0 0 x x x 0 0
              0 0 0 x 0 0 0 
              0 0 0 0 0 0 0

Plot the image, the smoothed image, and the difference between the
two.

Bonus
~~~~~

Re-filter the image by passing the result image through the filter again. Do
this 50 times and plot the resulting image. 

See :ref:`filter-image-solution`.
"""

from scipy.misc.pilutil import imread
from pylab import subplot, imshow, title, show, gray, cm

# 'flatten' creates a 2D array from a JPEG.
img = imread('dc_metro.JPG', flatten=True) 

imshow(img, cmap=cm.hot)
show()