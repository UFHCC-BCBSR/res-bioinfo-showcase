library(ggplot2)
library(ggraph)
library(igraph)
library(dplyr)

# Create network data with balanced positioning
nodes <- data.frame(
  id = c("Hub", "Docs", "Apps", "Reports", "Training"),
  label = c("Bioinformatics\nExpertise", "Documentation\nHub", "Custom\nApplications", "Interactive\nReporting", "Training &\nCommunity"),
  type = c("center", "resource", "resource", "resource", "resource"),
  # Perfect cross formation
  x = c(0, -3, 3, 0, 0),
  y = c(0, 0, 0, 3, -3)
)

edges <- data.frame(
  from = c("Hub", "Hub", "Hub", "Hub"),
  to = c("Docs", "Apps", "Reports", "Training")
)

# Create graph
g <- graph_from_data_frame(edges, vertices = nodes)

# Create the plot with larger circles
p <- ggraph(g, layout = "manual", x = nodes$x, y = nodes$y) +
  geom_edge_link(color = "#06b6d4", size = 3, alpha = 2) +
  geom_node_circle(aes(r = ifelse(type == "center", 1.2, 1.0), 
                       fill = type), 
                   color = "white", 
                   size = 2) +
  geom_node_text(aes(label = label), 
                 fontface = "bold", 
                 color = "white",
                 size = c(10, 8, 8, 8, 8), 
                 lineheight = 0.9) +
  scale_fill_manual(values = c("center" = "#1e3a8a", "resource" = "#0891b2")) +
  theme_void() +
  theme(legend.position = "none",
        plot.margin = margin(60, 30, 60, 30),
        plot.background = element_rect(fill = "transparent", color = NA)) +
  coord_fixed(ratio = 1) +
  xlim(-4, 4) +
  ylim(-6, 6)
p

ggsave("slide_figures/resources-ecosystem.png", p, width = 15, height = 20, dpi = 300, bg = "transparent")
