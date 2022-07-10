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

# hcl space
hclColz <- as(sRGB(t(col2rgb(colz) / 255)), 'polarLUV')
i <- sample(nrow(coords(hclColz)), size = 6000)

rt <- coords(hclColz)[i, 2:3]
xy <- cbind(x = rt[, 1] * cos(rt[, 2]), y = rt[, 1] * sin(rt[, 2]))

plot(sqrt(abs(xy)) * sign(xy))
plot(xy)


plot(sqrt(coords(hclColz)[i, 2:3]))


k <- kmeans(coords(), centers = 8)

# here's the centers
k$centers

# now just need to convert to colors and re-make the raster image

