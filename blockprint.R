library(magick)
library(colorspace)

x <- image_read('PXL_20220707_164341339.jpg')

# make image smaller
y <- image_scale(x, '400')

# crop how i like it
y <- image_crop(y, '400x600+0+111')

# convert to raster (so each cell = pixel w/ color hex)
r <- as.raster(y)
colz <- as.vector(r)

# LAB space
labColz <- coords(as(sRGB(t(col2rgb(colz)) / 255), 'LAB'))


# clusters
k <- kmeans(labColz, centers = 12)

# new colors from clusters
newColz <- hex(LAB(k$centers))[k$cluster]

# make a new raster of the image
newImg <- as.raster(matrix(newColz, nrow = nrow(r), byrow = TRUE))

# convert to image magick class image
image_read(newImg)

