library(ggplot2)
library(dplyr)
library(ggrepel)
#Authors: Lucas

#template provided by Philip N.
# Scatter plot (x-axis = majors affected by AI(least to most), y-axis = median starting salary for graduates after one year of graduating) 
cleanMajor = read.csv("data/processed/ai_salary_majors_clean.csv")

medianMajorMoney = summarize(majors, MedStartSalary = floor(median(median_starting_salary)), .by = broad_field_short)    
medianMajorMoney

fancyplot = ggplot(medianMajorMoney, aes(broad_field_short, MedStartSalary, fill = broad_field_short, horiz = TRUE)) + geom_col() + 
  labs(x="degrees", y="starting salary") + theme(axis.text.x = element_blank()) + 
  scale_y_continuous(labels = scales::dollar)  
#aes() defines what will be in the chart
#labs defines labels
#theme lets us remove the axis text so its more clean
#scale_y lets us turn the test into normal numbers and not 1e02

fancyplot


#Author: Emmanuel Zuniga
salaryExposurePlot <- ggplot(
  plotData,
  aes(x = ai_exposure, y = median_starting_salary)
) +
  # All majors
  geom_point(
    color = "#547C99",
    alpha = 0.45,
    size = 1.8
  ) +
  # Highlight the selected majors
  geom_point(
    data = labelMajors,
    color = "#C46528",
    size = 2.5
  ) +
  # Labels for selected majors
  geom_label_repel(
    data = labelMajors,
    aes(label = plot_label),
    size = 3,
    color = "#333333",
    fill = "white",
    label.size = NA,
    label.padding = grid::unit(0.2, "lines"),
    box.padding = 0.9,
    point.padding = 0.5,
    segment.color = "grey65",
    segment.size = 0.3,
    min.segment.length = 0,
    max.overlaps = Inf,
    max.time = 2,
    seed = 42
  ) +
  labs(
    title = "AI Exposure and Starting Salary",
    subtitle = "Each dot represents one college major",
    x = "AI exposure score",
    y = "Median starting salary",
    caption = "Selected salary and exposure extremes are highlighted."
  ) +
  scale_y_continuous(
    labels = scales::label_dollar(
      scale = 0.001,
      suffix = "k",
      accuracy = 1
    ),
    breaks = scales::breaks_pretty(n = 5),
    expand = expansion(mult = c(0.12, 0.18))
  ) +
  scale_x_continuous(
    breaks = scales::breaks_pretty(n = 5),
    expand = expansion(mult = 0.15)
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(
      color = "#EAEAEA",
      linewidth = 0.4
    ),
    plot.title = element_text(
      face = "bold",
      size = 19,
      margin = margin(b = 6)
    ),
    plot.subtitle = element_text(
      color = "grey45",
      margin = margin(b = 18)
    ),
    axis.title = element_text(color = "grey30"),
    axis.title.x = element_text(margin = margin(t = 12)),
    axis.title.y = element_text(margin = margin(r = 12)),
    axis.text = element_text(color = "grey40"),
    plot.caption = element_text(
      hjust = 0,
      color = "grey50",
      size = 9,
      margin = margin(t = 14)
    ),
    plot.background = element_rect(
      fill = "white",
      color = NA
    ),
    plot.margin = margin(20, 25, 15, 20)
  )

# Display in a larger window
windows(width = 14, height = 9)
print(salaryExposurePlot)

# Save the updated graph
ggsave(
  "ai_exposure_vs_starting_salary.png",
  plot = salaryExposurePlot,
  width = 14,
  height = 9,
  units = "in",
  dpi = 300,
  bg = "white"
)