####################################################################
# 8. Plot Multiple Shapefile 

ggplot() + 
  #area
  geom_sf(data = aoi_boundary_HARV, fill = "grey", color = "grey") + 
  #line
  geom_sf(data = lines_HARV, aes(color = TYPE), size = 1) + 
  #point
  geom_sf(data = point_HARV) + 
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()

## customize legend 
ggplot() + 
  geom_sf(data = aoi_boundary_HARV, fill = "grey", color = "grey") + 
  geom_sf(data = lines_HARV, aes(color = TYPE), show.legend = "line", size = 1) + 
  geom_sf(data = point_HARV, aes(fill = Sub_Type), color = "black") + 
  scale_color_brewer(palette = "Dark2", name = "Line Type") + 
  scale_fill_manual(values = "black", name = "Tower Location") + 
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()

## challenge 1
plotloc_HARV <- st_read("/Users/kate/Desktop/BENV7503/tut/tut2_2009586/NEON-DS-Site-Layout-Files/HARV/PlotLocations_HARV.shp")

ggplot() + 
  geom_sf(data = lines_HARV, aes(color = TYPE), show.legend = "line") + 
  geom_sf(data = plotloc_HARV, aes(fill = soilTypeOr), 
          shape = 21, show.legend = 'point') + 
  scale_color_manual(name = "Line Type", values = road_colors,
                     guide = guide_legend(override.aes = list(linetype = "solid", shape = NA))) + 
  scale_fill_manual(name = "Soil Type", values = c("lightblue", "darkgreen"),
                    guide = guide_legend(override.aes = list(linetype = "blank", shape = 21, colour = c("lightblue", "darkgreen")))) + 
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()


###############################################################################
# 9. Handling Spatial Projection & CRS 

# read US state boundary file 
state_boundary_US <- st_read("/Users/kate/Desktop/BENV7503/tut/tut2_2009586/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-State-Boundaries-Census-2014.shp")

ggplot() + 
  geom_sf(data = state_boundary_US) + 
  ggtitle("Map of Contiguous US State Boundaries") + 
  coord_sf()
### looks good 

# US boundary layer 
country_boundary_US <- st_read("/Users/kate/Desktop/BENV7503/tut/tut2_2009586/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-Boundary-Dissolved-States.shp")

ggplot() + 
  geom_sf(data = country_boundary_US, color = "gray18", size = 2) + 
  geom_sf(data = state_boundary_US, color = "gray40") + 
  ggtitle("Map of Contiguous US State Boundaries") + 
  coord_sf()

# add flux tower 
st_crs(point_HARV)
st_crs(state_boundary_US)
st_crs(country_boundary_US)

# view object extent 
st_bbox(point_HARV)
st_bbox(state_boundary_US)
st_bbox(country_boundary_US)

# reproject vector data 
## ggplot automatically converts all objects to the same CRS before plotting 
ggplot() + 
  geom_sf(data = country_boundary_US, size = 2, color = "gray18") + 
  geom_sf(data = state_boundary_US, color = "gray40") + 
  geom_sf(data = point_HARV, shape = 19, color = "purple") + 
  ggtitle("Map of Contiguous US State Boundaries") + 
  coord_sf()

