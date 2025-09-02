# ---- Packages ----
library(ggplot2)
library(dplyr)
library(grid)   # for arrow()

# ============================================================
# DATA (TOP → BOTTOM)
# ============================================================
steps <- tibble::tribble(
  ~title,                ~desc,
  "Shared Goals",        "Shared publications, grants,\nand research impact",
  "Integrated Results",  "Joint interpretation with biological &\ncomputational insight",
  "Coordinated Analysis","Integrated workflow execution with\ncontinuous communication",
  "Joint Planning",      "Collaborative experimental design\nand analysis planning",
  "Shared Knowledge",    "Bioinformaticians & researchers\nshare domain expertise"
) |> mutate(level = row_number())

# ---- Layout ----
band_h <- 1.0       # rectangle height
v_gap  <- 0.80      # vertical gap (longer arrows)
w_rect <- 4.8
x_left  <- -w_rect/2
x_right <-  w_rect/2

n <- nrow(steps)
steps <- steps |>
  mutate(
    ymin = (level - 1) * (band_h + v_gap),
    ymax = ymin + band_h,
    ymid = (ymin + ymax) / 2
  )

# ---- Small arrows strictly BETWEEN rectangles (pointing DOWN) ----
pad <- 0.08
gaps <- tibble(
  y_top = steps$ymax[-n],
  y_bot = steps$ymin[-1]
) |> mutate(y_mid = (y_top + y_bot)/2)

arrow_len <- pmin((gaps$y_bot - gaps$y_top) - 2*pad, 0.32)

arrowheads <- gaps |>
  transmute(
    x = 0, xend = 0,
    y    = y_mid + arrow_len/2,   # start slightly above mid…
    yend = y_mid - arrow_len/2    # …and point DOWN
  )

# ---- Right-side annotations ----
x_text <- x_right + 0.60  # text a bit closer to boxes

# ---- Palette (sleek, techy) ----
pal <- c("#111827", "#60A5FA", "#F59E0B", "#6366F1", "#3B82F6")
steps$fill <- pal[steps$level]

# ---- Plot ----
p_rect <- ggplot() +
  # rectangles
  geom_rect(
    data = steps,
    aes(xmin = x_left, xmax = x_right, ymin = ymin, ymax = ymax),
    fill = steps$fill, color = "white", linewidth = 1.2, radius = unit(8, "pt")
  ) +
  # titles inside
  geom_text(
    data = steps,
    aes(x = 0, y = ymid, label = title),
    color = "white", fontface = "bold", size = 5.2
  ) +
  # small arrowheads in each gap
  geom_segment(
    data = arrowheads,
    aes(x = x, y = y, xend = xend, yend = yend),
    color = "#E0E0E0", linewidth = 0.9,
    arrow = arrow(type = "closed", length = unit(4, "mm"))
  ) +
  # annotation text ONLY (no "—" leader)
  geom_text(
    data = steps,
    aes(x = x_text, y = ymid, label = desc),
    hjust = 0, color = "#E8E8E8", size = 5.6
  ) +
  # more room on the left & no clipping; less headroom at top
  coord_equal(
    xlim = c(-2.8, 9.2),
    ylim = c(-0.1, max(steps$ymax) + 0.6),
    expand = FALSE,
    clip = "off"
  ) +
  theme_void() +
  theme(
    plot.title = element_text(
      hjust = 0.5, face = "bold", size = 22, color = "white",
      margin = margin(b = 0)   # pull title tighter to panel
    ),
    plot.title.position = "panel",   # center over the panel area
    plot.background  = element_rect(fill = "transparent", color = NA),
    panel.background = element_rect(fill = "transparent", color = NA),
    plot.margin      = margin(4, 18, 6, 14)  # small top margin; a bit more left to be safe
  )

# ---- Save (transparent) ----
dir.create("slide_figures", showWarnings = FALSE)
ggsave("slide_figures/collaboration-model-rect.png", p_rect,
       width = 16, height = 8, dpi = 300, bg = "transparent")

p_rect
