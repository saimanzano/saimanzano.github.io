library(maps); library(rbokeh)
table <- read.csv("input.csv")
latlon <- geocode_OSM(table$City, details = FALSE, as.data.frame = TRUE)
table$lat <- latlon$lat
table$long <- latlon$lon

plot <- suppressWarnings(figure(width = 800, height = 450, padding_factor = 0) %>% 
  ly_map("world", col = "gray") %>% x_range(c(-20,45)) %>% y_range(c(30,80))  %>% 
  ly_points(long, lat, data = table, size = 5,
            hover = c(Name, Year, Type), color = Type))
widgetframe::frameWidget(plot,width=600,height=400)
htmlwidgets::saveWidget(plot, "map.html")
