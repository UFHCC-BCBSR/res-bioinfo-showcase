library(ggplot2)
library(dplyr)
library(forcats)
library(packcircles)

assays <- tibble::tibble(
  assay = c(
    "RNA-seq","ATAC-seq","CUT&RUN","CUT&Tag","ChIP-Seq","Hi-C",
    "WGS","EM-Seq","RRBS","WGBS","MAPit","Single-cell",
    "Spatial\nomics","CRISPR\nscreens","Metabolomics","Proteomics"
  ),
  counts = c(24,11,14,5,5,3,7,7,3,7,9,12,8,7,5,8)
)
assays <- assays |>
  mutate(category = case_when(
    assay %in% c("RNA-seq","Single-cell") ~ "Transcriptomics",
    assay %in% c("CUT&RUN","CUT&Tag","ChIP-Seq","Hi-C") ~ "Chromatin Interactions",
    assay %in% c("ATAC-seq","WGBS","RRBS","EM-Seq","MAPit") ~ "Epigenetics",
    TRUE ~ "Other" # WGS, Spatial omics, CRISPR screens, Metabolomics, Proteomics
  )) |>
  mutate(category = forcats::fct_relevel(
    category,
    "Transcriptomics","Chromatin Interactions","Epigenetics","Other"
  ))
set.seed(42)
lay <- circleProgressiveLayout(assays$counts, sizetype = "area")
assays_plot <- dplyr::bind_cols(assays, lay)
vertices <- circleLayoutVertices(lay, npoints = 80) |>
  mutate(
    category = assays_plot$category[id],
    assay = assays_plot$assay[id],
    counts = assays_plot$counts[id]
  )
pal <- c(
  "Transcriptomics" = "#3B82F6", # Neural Blue (medium blue)
  "Chromatin Interactions" = "#0F172A", # Neural Dark (very dark navy)
  "Epigenetics" = "skyblue4", # Neural Gray (light gray)
  "Other" = "blue" # Light blue (distinct from both other blues)
)
txt_white <- "#FFFFFF"
txt_black <- "#000000"
font_base <- ifelse(Sys.info()[["sysname"]] == "Darwin", "Helvetica", "sans")

p_bubbles <-
  ggplot() +
  geom_polygon(
    data = vertices,
    aes(x, y, group = id, fill = category),
    color = txt_black, linewidth = 0.6, alpha = 0.95
  ) +
  geom_text(
    data = assays_plot,
    aes(x, y, label = assay),
    color = txt_white, family = font_base, fontface = "bold",
    size = ifelse(assays_plot$assay == "Metabolomics", 3.8, 4.6),
    lineheight = 0.95
  ) +
  scale_fill_manual(values = pal) +
  guides(
    fill = guide_legend(
      title = NULL,
      direction = "vertical",
      override.aes = list(shape = 21, colour = txt_black, alpha = 1),
      keyheight = unit(1.2, "cm"),
      byrow = TRUE
    )
  ) +
  coord_equal() +
  ggtitle("BCB-SR Bioinformatics datasets analyzed since 2023",
          subtitle = "Circle size represents dataset count (3-24)") +
  theme_void(base_family = font_base) +
  theme(
    plot.title = element_text(
      hjust = 0.5, face = "bold", size = 20, color = txt_black,
      margin = margin(b = 10)
    ),
    plot.subtitle = element_text(
      hjust = 0.5, size = 16, color = txt_black,
      margin = margin(b = 5)
    ),
    legend.position = "right",
    legend.title = element_text(color = txt_black, size = 18),
    legend.text = element_text(color = txt_black, size = 18, margin = margin(t = 8, b = 8)),
    legend.key = element_rect(fill = NA, color = NA),
    legend.key.size = unit(0.45, "cm"),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(10, 16, 10, 16)
  )

ggsave("slide_figures/assays-bubbles.HRK.white.png", p_bubbles,
       width = 12, height = 7, dpi = 300, bg = "white")
p_bubbles