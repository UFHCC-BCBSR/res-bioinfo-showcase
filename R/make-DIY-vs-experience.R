library(ggplot2)
library(gridExtra)
library(grid)

# Create the "WITHOUT" side (messy file structure)
without_text <- "📁 my_project/
├── 📁 data_backup/
│   ├── old_data.csv
│   ├── data_v2.xlsx  
│   └── final_data_FINAL.csv
├── 📁 scripts/
│   ├── analysis.R
│   ├── analysis_v2.R
│   ├── analysis_final.R
│   ├── analysis_FINAL_v3.R
│   ├── temp_script.py
│   └── untitled1.ipynb
├── 📁 results/
│   ├── plot1.png
│   ├── good_plot.pdf
│   ├── Figure_for_paper.tiff
│   └── random_output.txt
├── notes.txt
├── TODO.docx
└── meeting_notes_scattered.pdf
❌ No documentation
❌ No version control
❌ Unclear file organization
❌ Non-reproducible code
❌ Multiple 'final' versions"

# Create the "WITH" side (organized structure)
with_text <- "📄 Interactive Report
├── 🔍 Quality Control Results
├── 📈 Analysis Results & Plots  
├── 🧬 Differential Expression
├── 🔗 Links to Raw Data
└── 📋 Complete Methods
GitHub Repository
├── 📄 README.md
├── 📁 data/
├── 📁 scripts/
│   └── documented_analysis.R
├── 📁 results/
└── 📁 docs/
✅ Complete documentation
✅ Version controlled
✅ Organized file structure
✅ Reproducible workflows
✅ Methods transparency"

# Create tight plots with minimal spacing
p1 <- ggplot() +
  annotate("text", x = -0.4, y = 0.85,  # Same x as the text below
           label = "New to Bioinformatics",
           size = 4.5, fontface = "bold", color = "#e74c3c",
           hjust = 0) +  # Add hjust = 0 for left alignment
  annotate("text", x = -0.4, y = 0.75,
           label = without_text,
           size = 2.8, hjust = 0, vjust = 1,
           color = "white", family = "mono") +
  xlim(-0.5, 0.5) + ylim(0, 1) +
  theme_void() +
  theme(plot.background = element_rect(fill = "transparent", color = "transparent"),
        plot.margin = unit(c(0,0,0,0), "cm"))

p2 <- ggplot() +
  annotate("text", x = -0.4, y = 0.85,  # Same x as the text below
           label = "Experienced Bioinformatician",
           size = 4.5, fontface = "bold", color = "#27ae60",
           hjust = 0) +  # Add hjust = 0 for left alignment
  annotate("text", x = -0.4, y = 0.75,
           label = with_text,
           size = 2.8, hjust = 0, vjust = 1,
           color = "white") +
  xlim(-0.5, 0.5) + ylim(0, 1) +
  theme_void() +
  theme(plot.background = element_rect(fill = "transparent", color = "transparent"),
        plot.margin = unit(c(0,0,0,0), "cm"))

# Combine with no spacing between panels
combined_plot <- grid.arrange(p1, p2, ncol = 2,
                              widths = c(1, 1))

# Save
ggsave("slide_figures/experience.png", combined_plot,
       width = 6, height = 6, dpi = 300, bg = "transparent")