library(ggplot2)
library(dplyr)

# Create pyramid data with proper trapezoid coordinates
create_pyramid_level <- function(level, width_bottom, width_top, y_bottom, y_top, color, label, description) {
  data.frame(
    level = level,
    x = c(-width_bottom/2, width_bottom/2, width_top/2, -width_top/2, -width_bottom/2),
    y = c(y_bottom, y_bottom, y_top, y_top, y_bottom),
    color = color,
    label = label,
    description = description,
    center_x = 0,
    center_y = y_bottom + 0.4,  # or whatever offset looks good,
    text_x = width_bottom/2 + 0.3,  # Reduced spacing
    text_y = (y_bottom + y_top) / 2
  )
}


# Create all pyramid levels
pyramid_levels <- bind_rows(
  create_pyramid_level(1, 6, 5, 0, 1, "#3498db", "Shared Knowledge", 
                       "Bioinformaticians & researchers share\ndomain expertise"),
  create_pyramid_level(2, 5, 4, 1, 2, "#e74c3c", "Joint Planning", 
                       "Collaborative experimental design\nand analysis planning"),
  create_pyramid_level(3, 4, 3, 2, 3, "#f39c12", "Coordinated Analysis", 
                       "Integrated workflow execution with\ncontinuous communication and feedback"),
  create_pyramid_level(4, 3, 2, 3, 4, "#2ecc71", "Integrated Results", 
                       "Joint interpretation of results with\ncombined biological and computational insights"),
  create_pyramid_level(5, 2, 0, 4, 6, "#34495e", "Shared\nGoals",  # Changed height to 6
                       "Shared publications, grants, and\nresearch impact with mutual investment")
)

# Get unique levels for labels
level_labels <- pyramid_levels %>%
  group_by(level) %>%
  slice(1) %>%
  ungroup()

# Create the plot
p <- ggplot() +
  # Draw pyramid segments
  geom_polygon(data = pyramid_levels, 
               aes(x = x, y = y, group = level, fill = I(color)), 
               color = "white", size = 1.5) +
  
  # Add level labels (no icons)
  geom_text(data = level_labels,
            aes(x = center_x, y = center_y, label = label), 
            color = "white", size = 4.5) +
  
  # Add description text to the right (light gray for dark backgrounds)
  geom_text(data = level_labels,
            aes(x = text_x, y = text_y, label = description),
            hjust = 0, size = 4.0, color = "#e8e8e8") +
  
  # Add connecting lines
  geom_segment(data = level_labels,
               aes(x = text_x - 0.2, y = text_y, 
                   xend = text_x - 0.05, yend = text_y),
               color = "#cccccc", size = 0.5) +
  
  # Styling
  scale_x_continuous(limits = c(-3.5, 8)) +
  scale_y_continuous(limits = c(-0.2, 6.2)) +  # Increased top limit
  coord_equal() +
  theme_void() +
  theme(
    plot.background = element_rect(fill = "transparent", color = NA),
    panel.background = element_rect(fill = "transparent", color = NA),
    plot.margin = margin(10, 10, 10, 10)
  )

# Display the plot
print(p)

# Save the plot with transparent background
ggsave("slide_figures/collaboration-model.png", p, 
       width = 10, height = 6, dpi = 300, bg = "transparent")
