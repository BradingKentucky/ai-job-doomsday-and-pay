<<<<<<< HEAD
library(ggplot2)
#Authors: Lucas

#template provided by Philip N.
# Scatter plot (x-axis = majors affected by AI(least to most), y-axis = median starting salary for graduates after one year of graduating) 

fancyplot = ggplot(majors, aes(broad_field_short, median_starting_salary, fill = broad_field_short, horiz = TRUE)) + geom_col() + 
  labs(x="degrees", y="starting salary") + theme(axis.text.x = element_blank()) + 
  scale_y_continuous(labels = scales::label_number(suffix = "k"))  
#aes() defines what will be in the chart
#labs defines labels
#theme lets us remove the axis text so its more clean
#scale_y lets us turn the test into normal numbers and not 1e02

fancyplot

=======
library(ggplot2)
#Authors: Lucas

#template provided by Philip N.
# Scatter plot (x-axis = majors affected by AI(least to most), y-axis = median starting salary for graduates after one year of graduating) 

fancyplot = ggplot(majors, aes(broad_field_short, median_starting_salary, fill = broad_field_short, horiz = TRUE)) + geom_col() + 
  labs(x="degrees", y="starting salary") + theme(axis.text.x = element_blank()) + 
  scale_y_continuous(labels = scales::label_number(suffix = "k"))  
#aes() defines what will be in the chart
#labs defines labels
#theme lets us remove the axis text so its more clean
#scale_y lets us turn the test into normal numbers and not 1e02

fancyplot

>>>>>>> d454c07ae5fc7e7c64ad1424d9cd090575d279bf
