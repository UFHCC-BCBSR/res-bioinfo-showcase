# ---- Packages ----
# install.packages("tidyverse") # if needed
library(ggplot2)
library(dplyr)
library(forcats)

# ---- Data (EDIT ME) ----
# Dummy totals for each assay mentioned in the slide + notes.
assays <- tibble::tibble(
  assay = c(
    "RNA-seq",
    "ATAC-seq",
    "CUT&RUN",
    "EM-Seq (Methyl-Seq)",
    "RRBS",
    "WGBS",
    "MAPit / NOMe-Seq",
    "Single-cell (RNA/ATAC)",
    "Spatial transcriptomics",
    "CRISPR screens",
    "AI-driven rare disease"
  ),
  counts = c(
    24,  # RNA-seq
    11,  # ATAC-seq
    14,   # CUT&RUN
    7,   # EM-Seq
    5,   # RRBS
    9,   # WGBS
    12,   # MAPit / NOMe-Seq
    8,  # Single-cell
    7,   # Spatial
    5,   # CRISPR screens
    2    # AI-driven rare disease
  )
)

# ---- Aesthetics ----
# Neutral palette + light text so it reads on a dark slide theme.
bar_fill   <- "#A8B0B8"   # soft tech-gray
text_col   <- "#E8E9EA"   # near-white (good over dark)
grid_col   <- "#7A848E"   # subtle grid on dark
font_base  <- ifelse(Sys.info()[["sysname"]] == "Darwin", "Helvetica", "sans")

assays <- assays %>%
  mutate(assay = fct_reorder(assay, counts))  # order by count

# ---- Plot ----
p <- ggplot(assays, aes(x = counts, y = assay)) +
  geom_col(fill = bar_fill, width = 0.7) +
  geom_text(aes(label = scales::comma(counts)),
            hjust = -0.15, size = 4.2, color = text_col, family = font_base) +
  scale_x_continuous(expand = expansion(mult = c(0, 0.08))) +
  labs(
    x = NULL, y = NULL,
    title = "Datasets analyzed by BCB-SR Bioinformatics since 2021"
  ) +
  theme_minimal(base_size = 16, base_family = font_base) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor   = element_blank(),
    panel.grid.major.x = element_line(color = grid_col, linewidth = 0.25),
    axis.text.y        = element_text(color = text_col, size = 13),
    axis.text.x        = element_text(color = text_col, size = 11),
    plot.title         = element_text(
      hjust = 0.5, size = 18, face = "bold", color = text_col,
      margin = margin(b = 12)
    ),
    plot.margin        = margin(10, 20, 10, 10),
    plot.background    = element_rect(fill = NA, color = NA),
    panel.background   = element_rect(fill = NA, color = NA)
  ) +
  coord_cartesian(clip = "off")


# ---- Save (transparent PNG) ----
out_path <- "slide_figures/assays-analyzed.png"
ggsave(out_path, p, width = 10, height = 6, dpi = 300, bg = "transparent")
