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
) |> mutate(category = case_when(
  assay %in% c("RNA-seq", "Single-cell", "Spatial omics") ~ "Transcriptomics",
  assay %in% c("ChIP-Seq", "Hi-C", "CUT&Tag", "CUT&RUN") ~ "Chromatin Interactions",
  assay %in% c("ATAC-seq", "WGBS", "RRBS", "EM-Seq", "MAPit") ~ "Epigenetics",
  assay %in% c("CRISPR screens") ~ "Functional Genomics",
  TRUE ~ "Other"
)) |> 
  mutate(category = factor(category, 
                           levels = c("Transcriptomics", 
                                      "Chromatin Interactions", 
                                      "Epigenetics", "Other")))

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
  "Transcriptomics" = "#1B9E77",        # Teal: Vibrant yet soft, good for Transcriptomics
  "Chromatin Interactions" = "#7570B3", # Purple: Distinct for protein-DNA interactions
  "Epigenetics" = "#E7298A",           # Magenta: Bold for epigenetic modifications
  "Functional Genomics" = "#D95F02",    # Orange: Warm and distinct for CRISPR screens
  "Other" = "#666666"                  # Gray: Neutral for miscellaneous assays
)
txt_white <- "#FFFFFF"
txt_lt    <- "#E6E6E6"
font_base <- ifelse(Sys.info()[["sysname"]] == "Darwin", "Helvetica", "sans")

# ---- Plot (labels all inside; no ggrepel) ----
Thanks for sharing your full plotting code! I can see you’re creating a packcircles plot with a size legend (for counts) and a fill legend (for category), and you want the fill legend to be stacked vertically on the right with larger text, as discussed previously. However, your current code has both legends (size and fill) set to direction = "horizontal" in the guides() function, which is causing the fill legend to appear horizontal despite legend.direction = "vertical" in the theme() settings. To achieve a vertical fill legend while keeping the size legend horizontal, we need to adjust the guides() function to ensure the fill legend respects the vertical orientation.
Additionally, I’ll incorporate the desired legend order (Transcriptomics, Chromatin Interactions, Epigenetics, Other) from your previous request, ensure the text size is sufficient, and make the plot consistent with your provided code. Since you’re saving the plot with a transparent background, I’ll ensure all settings align with that goal.
Below is the updated R script, which modifies the guides() function to stack the fill legend vertically while keeping the size legend horizontal, and it includes all your existing plot elements (e.g., geom_text for assay labels, transparent background, etc.).textlibrary(packcircles)
library(ggplot2)
library(tibble)

# Your data
assays <- tibble::tibble(
  assay = c(
    "RNA-seq", "ATAC-seq", "CUT&RUN", "CUT&Tag", "ChIP-Seq", "Hi-C", "WGS",
    "EM-Seq", "RRBS", "WGBS", "MAPit", "Single-cell", "Spatial\nomics",
    "CRISPR\nscreens", "Metabolomics", "Proteomics"
  ),
  counts = c(
    24, 11, 14, 5, 5, 3, 7, 7, 3, 7, 9, 12, 8, 7, 5, 8
  )
) |>
  mutate(category = case_when(
    assay %in% c("RNA-seq", "Single-cell", "Spatial omics") ~ "Transcriptomics",
    assay %in% c("ChIP-Seq", "Hi-C", "CUT&Tag", "CUT&RUN") ~ "Chromatin Interactions",
    assay %in% c("ATAC-seq", "WGBS", "RRBS", "EM-Seq", "MAPit") ~ "Epigenetics",
    assay %in% c("CRISPR screens") ~ "Functional Genomics",
    TRUE ~ "Other"
  )) |>
  # Set category as a factor with custom order for legend
  mutate(category = factor(category, levels = c("Transcriptomics", "Chromatin Interactions", "Epigenetics", "Other")))

# Generate circle packing layout
packing <- circleProgressiveLayout(assays$counts, sizetype = "area")
vertices <- circleLayoutVertices(packing, npoints = 50) |> 
  mutate(id = rep(assays$assay, each = 50),
         category = rep(assays$category, each = 50))

# Assuming assays_plot is the data frame with circle centers for text labels
assays_plot <- packing |> 
  mutate(assay = assays$assay, counts = assays$counts, category = assays$category)

# Color palette
pal <- c(
  "Transcriptomics" = "#1B9E77",
  "Chromatin Interactions" = "#7570B3",
  "Epigenetics" = "#E7298A",
  "Functional Genomics" = "#D95F02",
  "Other" = "#666666"
)

# Define text colors (placeholders, adjust if defined elsewhere)
txt_white <- "#FFFFFF"  # White text
txt_lt <- "#D3D3D3"    # Light gray text
font_base <- "Arial"   # Placeholder font, replace with your font

# Plot
Thanks for the clarification! Since the circle sizes in the packcircles plot represent the dataset counts, and you want to revert to the original size legend circles (i.e., max_size = 22 in scale_size_area()), I’ll update the code to restore the larger circles in the size legend. Additionally, you want the "Dataset count" (size) legend to appear after the categories (fill) legend, which can be achieved by adjusting the order parameter in the guides() function. The fill legend will remain vertical with the category order (Transcriptomics, Chromatin Interactions, Epigenetics, Other), and the size legend will also stay vertical, as requested.
Below is the updated R script, incorporating these changes while preserving all other elements of your plot, including the vertical legends, assay labels, transparent background, and other styling.textlibrary(packcircles)
library(ggplot2)
library(tibble)

# Your data
assays <- tibble::tibble(
  assay = c(
    "RNA-seq", "ATAC-seq", "CUT&RUN", "CUT&Tag", "ChIP-Seq", "Hi-C", "WGS",
    "EM-Seq", "RRBS", "WGBS", "MAPit", "Single-cell", "Spatial\nomics",
    "CRISPR\nscreens", "Metabolomics", "Proteomics"
  ),
  counts = c(
    24, 11, 14, 5, 5, 3, 7, 7, 3, 7, 9, 12, 8, 7, 5, 8
  )
) |>
  mutate(category = case_when(
    assay %in% c("RNA-seq", "Single-cell", "Spatial omics") ~ "Transcriptomics",
    assay %in% c("ChIP-Seq", "Hi-C", "CUT&Tag", "CUT&RUN") ~ "Chromatin Interactions",
    assay %in% c("ATAC-seq", "WGBS", "RRBS", "EM-Seq", "MAPit") ~ "Epigenetics",
    assay %in% c("CRISPR screens") ~ "Functional Genomics",
    TRUE ~ "Other"
  )) |>
  # Set category as a factor with custom order for legend
  mutate(category = factor(category, levels = c("Transcriptomics", "Chromatin Interactions", "Epigenetics", "Other")))

# Generate circle packing layout
packing <- circleProgressiveLayout(assays$counts, sizetype = "area")
vertices <- circleLayoutVertices(packing, npoints = 50) |> 
  mutate(id = rep(assays$assay, each = 50),
         category = rep(assays$category, each = 50))

# Assuming assays_plot is the data frame with circle centers for text labels
assays_plot <- packing |> 
  mutate(assay = assays$assay, counts = assays$counts, category = assays$category)

# Color palette
pal <- c(
  "Transcriptomics" = "#1B9E77",
  "Chromatin Interactions" = "#7570B3",
  "Epigenetics" = "#E7298A",
  "Functional Genomics" = "#D95F02",
  "Other" = "#666666"
)

# Define text colors and font (placeholders, adjust if defined elsewhere)
txt_white <- "#FFFFFF"  # White text
txt_lt <- "#D3D3D3"    # Light gray text
font_base <- "Arial"   # Placeholder font, replace with your font

# Plot
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
  # Invisible points to create a size legend
  geom_point(
    data = assays_plot,
    aes(x = 0, y = 0, size = counts),
    alpha = 0
  ) +
  scale_fill_manual(values = pal) +
  scale_size_area(
    name = "Dataset count",
    max_size = 22,  # Reverted to original size for legend circles
    breaks = c(5, 10, 20),
    labels = c("5", "10", "20")
  ) +
  guides(
    # Fill legend: vertical, appears first
    fill = guide_legend(
      direction = "vertical",  # Stack categories vertically
      order = 1  # Appears first (top)
    ),
    # Size legend: vertical, appears second
    size = guide_legend(
      direction = "vertical",  # Stack size legend vertically
      override.aes = list(fill = "grey75", color = "grey75", alpha = 0.9),
      label.position = "right",  # Labels to the right of circles
      title.position = "top",    # Title above the legend
      order = 2  # Appears second (below fill legend)
    )
  ) +
  coord_equal() +
  labs(title = "BCB-SR Bioinformatics datasets analyzed since 2023", fill = NULL) +
  theme_void(base_family = font_base) +
  theme(
    plot.title = element_text(
      hjust = 0.5, face = "bold", size = 14, color = txt_white,
      margin = margin(b = 10)
    ),
    legend.position = "right",              # Place legend on the right
    legend.direction = "vertical",          # Stack legend items vertically
    legend.box = "vertical",                # Ensure vertical stacking of legends
    legend.justification = c("center", "top"),  # Align legend to top-right
    legend.text = element_text(color = txt_lt, size = 10),  # Larger text
    legend.key = element_rect(fill = NA, color = NA),       # No key borders
    legend.key.size = unit(0.5, "cm"),      # Key size for fill legend
    legend.box.spacing = unit(0.5, "cm"),   # Space between fill and size legends
    plot.background = element_rect(fill = NA, color = NA),  # Transparent background
    panel.background = element_rect(fill = NA, color = NA), # Transparent panel
    plot.margin = margin(10, 30, 10, 14)    # Extra right margin for vertical legends
  )


# ---- Save (transparent) ----
svg(filename = "slide_figures/assays-bubbles.svg", 
    height = 7,
    width = 12, 
    pointsize = 16, 
    family = 'sans')
p_bubbles
dev.off()

ggsave("slide_figures/assays-bubbles.g", p_bubbles,
       width = 12, height = 7, dpi = 300, bg = "transparent")

p_bubbles
