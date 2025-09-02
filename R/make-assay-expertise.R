# ---- Packages ----
library(ggplot2)
library(dplyr)
library(forcats)
library(packcircles)

# ---- Data ----
assays <- tibble::tibble(
  assay = c(
    "RNA-seq",         # 24
    "ATAC-seq",        # 11
    "CUT&RUN",         # 14
    "CUT&Tag",         # 5
    "ChIP-Seq",        # 5
    "Hi-C",            # 3
    "WGS",             # 7
    "EM-Seq",          # 7
    "RRBS",            # 3
    "WGBS",            # 7
    "MAPit",           # 9
    "Single-cell",     # 12
    "Spatial\nomics",   # 8
    "CRISPR\nscreens",  # 7
    "Metabolomics",    # 5
    "Proteomics"       # 8
  ),
  counts = c(
    24,  # RNA-seq
    11,  # ATAC-seq
    14,  # CUT&RUN
    5,  # CUT&Tag
    5,  # ChIP-Seq
    3,  # Hi-C
    7,  # WGS
    7,  # EM-Seq
    3,  # RRBS
    7,  # WGBS
    9,  # MAPit
    12,  # Single-cell
    8,  # Spatial omics
    7,  # CRISPR screens
    5,  # Metabolomics
    8   # Proteomics
  )
)


# ---- Categorize ----
assays <- assays |>
  mutate(category = case_when(
    assay %in% c("RNA-seq","Single-cell","Spatial omics") ~ "Transcriptomics",
    assay %in% c("ChIP-Seq","Hi-C","CUT&Tag","ATAC-seq","CUT&RUN","WGBS","RRBS","EM-Seq","MAPit") ~ "Epigenetics",
    assay %in% c("CRISPR screens") ~ "Functional Genomics",
    TRUE ~ "Other"
  ))

# ---- Layout ----
set.seed(42)
lay <- circleProgressiveLayout(assays$counts, sizetype = "area")  # x, y, radius
assays_plot <- dplyr::bind_cols(assays, lay)
vertices <- circleLayoutVertices(lay, npoints = 80) |>
  dplyr::mutate(
    category = assays_plot$category[id],
    assay    = assays_plot$assay[id],
    counts   = assays_plot$counts[id]
  )

# ---- Colors / fonts for dark slide ----
pal <- c(
  "Transcriptomics"     = "#2F80ED",
  "Epigenetics"         = "#EB5757",
  "Functional Genomics" = "#F2994A",
  "Other"               = "#9B9B9B"
)
txt_white <- "#FFFFFF"
txt_lt    <- "#E6E6E6"
font_base <- ifelse(Sys.info()[["sysname"]] == "Darwin", "Helvetica", "sans")

# ---- Plot (labels all inside; no ggrepel) ----
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
    labels = c("5", "10", "20")
  ) +
  guides(
    # show size legend first (row 1), horizontal
    size = guide_legend(
      direction = "horizontal",
      override.aes = list(fill = "grey75", color = "grey75", alpha = 0.9),
      label.position = "bottom", title.position = "left",
      order = 1
    ),
    # then color legend (row 2), horizontal chips
    fill = guide_legend(
      direction = "horizontal",
      order = 2
    )
  ) +
  coord_equal() +
  labs(title = "BCB-SR Bioinformatics datasets analyzed since 2023") +
  theme_void(base_family = font_base) +
  theme(
    plot.title = element_text(
      hjust = 0.5, face = "bold", size = 14, color = txt_white,
      margin = margin(b = 10)
    ),
    legend.position = "bottom",   # move to left
    #legend.box = "vertical",    # stack if multiple legends
    legend.box = "horizontal",          # keep them side by side
    legend.box.just = "left",           # left-justify box contents
    legend.justification = c("center", "top"), # align top
    legend.title = element_text(color = txt_lt, size = 9),
    legend.text  = element_text(color = txt_lt, size = 8),
    legend.key   = element_rect(fill = NA, color = NA),
    legend.key.size = unit(0.35, "cm"),   # shrink keys
    plot.background  = element_rect(fill = NA, color = NA),  # transparent
    panel.background = element_rect(fill = NA, color = NA),
    plot.margin = margin(10, 14, 10, 14)
  )


# ---- Save (transparent) ----
ggsave("slide_figures/assays-bubbles.png", p_bubbles,
       width = 12, height = 7, dpi = 300, bg = "transparent")

p_bubbles
