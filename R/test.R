# source("palettes.R")
# library(ggplot2)
#
 pal=whistledown_palette("featherington", 5,type = "discrete")
 ggplot(diamonds, aes(carat, fill = cut)) +
   geom_density(position = "stack") +
   scale_fill_manual(values=pal)  +
   theme_classic()

 ggplot(diamonds, aes(x = x, y = y, color = carat)) +
   #geom_density(position = "stack") +
   geom_point()+
   scale_color_gradientn(colors=pal)  +
   theme_classic()

 whistledown_palette(name="red",n=5)
 whistledown_palette(name="danbury",n=5)
 whistledown_palette(name="danbury",n=7)
 whistledown_palette(name="sharmaji",n=7)
 whistledown_palette(name="featherington",n=7,type = "continuous")

