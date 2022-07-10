library(magick)
library(colorspace)

foo <- image_read('PXL_20220707_164341339.jpg')


boo <- image_scale(foo, '400')
boo <- image_crop(boo, '400x600+0+111')

doo <- as.raster(boo)

x <- as.vector(doo)
k <- kmeans(coords(as(sRGB(t(col2rgb(x) / 255)), 'polarLUV')), centers = 8)

# here's the centers
k$centers

# now just need to convert to colors and re-make the raster image

