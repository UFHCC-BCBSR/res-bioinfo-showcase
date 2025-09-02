library(DiagrammeR)

# Calculate circular positions manually
angles <- seq(0, -2*pi, length.out = 10)[1:9] + pi/2  # Negative for clockwise
radius <- 3

pos_string <- function(angle) {
  x <- cos(angle) * radius
  y <- sin(angle) * radius
  paste0(x, ",", y, "!")
}

flowchart <- grViz(paste0("
digraph project_lifecycle {
  graph [layout = neato, bgcolor = 'transparent']
  node [shape = circle, style = 'filled', fontcolor = 'white', 
        fillcolor = '#3b82f6', color = 'white', penwidth = 2,
        fixedsize = true, width = 1.5, height = 1.5]  # Force uniform size
  edge [color = 'white', arrowsize = 0.8]
  
  Proposal [penwidth = 6, pos = '", pos_string(angles[1]), "']
  Funding [pos = '", pos_string(angles[2]), "']
  DataGen [label = 'Data\\nGeneration', pos = '", pos_string(angles[3]), "']
  DataDel [label = 'Data\\nDelivery', penwidth = 6, pos = '", pos_string(angles[4]), "']
  Preproc [label = 'Pre-\\nprocessing', pos = '", pos_string(angles[5]), "']
  QC [label = 'Quality\\nControl', pos = '", pos_string(angles[6]), "']
  Analysis [pos = '", pos_string(angles[7]), "']
  Report [label = 'Analysis\\nReport', pos = '", pos_string(angles[8]), "']
  Publication [pos = '", pos_string(angles[9]), "']
  Archive [label = 'Data Management\\nand Sharing', pos = '0,0!']
  
  Proposal -> Funding -> DataGen -> DataDel -> Preproc -> QC -> Analysis -> Report -> Publication -> Proposal
  QC -> Preproc [style = dashed]
  Report -> Analysis [style = dashed] 
  Analysis -> Archive
}"))

flowchart
library(DiagrammeRsvg)
# Save
flowchart %>%
  export_svg() %>%
  charToRaw() %>%
  rsvg::rsvg_png("slide_figures/project-lifecycle.png", 
                 width = 800, height = 800)
