library(magick)

img <- image_read("slide_figures/project_lifecycle.png")

# 1) Remove black background
img2 <- image_transparent(img, color = "black", fuzz = 5)

# 2) Get size
info <- image_info(img2)
margin <- round(0.08 * info$height)        # 20% top + bottom
new_h <- info$height + 2 * margin

# 3) Ensure background is transparent
img2 <- image_background(img2, "none")

# 4) Expand canvas with transparent padding
out <- image_extent(
  img2,
  geometry = paste0(info$width, "x", new_h),
  gravity  = "center"
)

image_write(out, path = "slide_figures/project_lifecycle_transparent.png", format = "png")
