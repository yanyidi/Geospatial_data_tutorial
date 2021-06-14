####################################################################################
# 10. Convert from .csv to a Shapefile 

plot_loc_HARV <- read.csv("/Users/kate/Desktop/BENV7503/tut/tut2_2009586/NEON-DS-Site-Layout-Files/HARV/HARV_PlotLocations.csv")
str(plot_loc_HARV)
names(plot_loc_HARV)

utm18nCRS <- st_crs(point_HARV)
class(utm18nCRS)

# .csv to sf object 
plot_loc_sp_HARV <- st_as_sf(plot_loc_HARV, coords = c("easting", "northing"), crs = utm18nCRS)
st_crs(plot_loc_sp_HARV)

# plot spatial object 
ggplot() + 
  geom_sf(data = plot_loc_sp_HARV) + 
  ggtitle("Map of Plot Locations")

# plot extent 
ggplot() + 
  geom_sf(data = aoi_boundary_HARV) + 
  geom_sf(data = plot_loc_sp_HARV) + 
  ggtitle("AOI Boundary Plot")

