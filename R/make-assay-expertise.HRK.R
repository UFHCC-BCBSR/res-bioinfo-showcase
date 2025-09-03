# ---- Packages ----
library(ggplot2)
library(dplyr)
library(forcats)
library(packcircles)

# ---- Data ----
assays <- tibble::tibble(
  assay = c(
    "RNA-seq","ATAC-seq","CUT&RUN","CUT&Tag","ChIP-Seq","Hi-C",
    "WGS","EM-Seq","RRBS","WGBS","MAPit","Single-cell",
    "Spatial\nomics","CRISPR\nscreens","Metabolomics","Proteomics"
  ),
  counts = c(24,11,14,5,5,3,7,7,3,7,9,12,8,7,5,8)
)

# ---- Categorize (match the figure) ----
assays <- assays |>
  mutate(category = case_when(
    assay %in% c("RNA-seq","Single-cell") ~ "Transcriptomics",
    assay %in% c("CUT&RUN","CUT&Tag","ChIP-Seq","Hi-C") ~ "Chromatin Interactions",
    assay %in% c("ATAC-seq","WGBS","RRBS","EM-Seq","MAPit") ~ "Epigenetics",
    TRUE ~ "Other"                                # WGS, Spatial omics, CRISPR screens, Metabolomics, Proteomics
  )) |>
  mutate(category = forcats::fct_relevel(
    category,
    "Transcriptomics","Chromatin Interactions","Epigenetics","Other"
  ))

# ---- Layout ----
set.seed(42)
lay <- circleProgressiveLayout(assays$counts, sizetype = "area")
assays_plot <- dplyr::bind_cols(assays, lay)
vertices <- circleLayoutVertices(lay, npoints = 80) |>
  mutate(
    category = assays_plot$category[id],
    assay    = assays_plot$assay[id],
    counts   = assays_plot$counts[id]
  )

# ---- Colors / fonts (match the figure) ----
pal <- c(
  "Transcriptomics"         = "#21B37B",  # teal/green
  "Chromatin Interactions"  = "#7D7FC9",  # lavender-purple
  "Epigenetics"             = "#EC4C9A",  # magenta-pink
  "Other"                   = "#6F6F6F"   # medium gray
)
txt_white <- "#FFFFFF"
txt_lt    <- "#E6E6E6"
font_base <- ifelse(Sys.info()[["sysname"]] == "Darwin", "Helvetica", "sans")

# ---- Plot ----
p_bubbles <-
  ggplot() +
  geom_polygon(
    data = vertices,
    aes(x, y, group = id, fill = category),
    color = txt_white, linewidth = 0.6, alpha = 0.95
  ) +
  geom_text(
    data = assays_plot,
    aes(x, y, label = assay),
    color = txt_white, family = font_base, fontface = "bold",
    size = 4.6, lineheight = 0.95
  ) +
  # invisible points to create a size legend
  geom_point(
    data = assays_plot,
    aes(x = 0, y = 0, size = counts),
    alpha = 0
  ) +
  scale_fill_manual(values = pal) +
  scale_size_area(
    name = "Dataset count",
    max_size = 22,
    breaks = c(5, 10, 20),
    labels = c("5","10","20")
  ) +
  guides(
    fill = guide_legend(               # categories first, vertical
      title = NULL,
      direction = "vertical",
      override.aes = list(shape = 21, colour = NA, alpha = 1),
      order = 1
    ),
    size = guide_legend(               # dataset count below, vertical bubbles
      direction = "vertical",
      override.aes = list(fill = "grey80", colour = "grey80", alpha = 1),
      title.position = "top",
      order = 2
    )
  ) +
  coord_equal() +
  labs(title = "BCB-SR Bioinformatics datasets analyzed since 2023") +
  theme_void(base_family = font_base) +
  theme(
    plot.title = element_text(
      hjust = 0.5, face = "bold", size = 20, color = txt_white,
      margin = margin(b = 10)
    ),
    # Legend like the figure: right side, stacked
    legend.position = "right",
    legend.box      = "vertical",
    legend.justification = "center",
    legend.title = element_text(color = txt_lt, size = 18),
    legend.text  = element_text(color = txt_lt, size = 18),
    legend.key   = element_rect(fill = NA, color = NA),
    legend.key.size = unit(0.45, "cm"),
    plot.background  = element_rect(fill = NA, color = NA),
    panel.background = element_rect(fill = NA, color = NA),
    plot.margin = margin(10, 16, 10, 16)
  )

# ---- Save (transparent) ----
ggsave("slide_figures/assays-bubbles.png", p_bubbles,
       width = 12, height = 7, dpi = 300, bg = "transparent")

p_bubbles
