################################################################################
# 6. Open and Plot Shapefiles 

install.packages(c("dplyr", "ggplot2", "raster", "rgdal", "rasterVis"))

## error downloading 'sf': https://github.com/r-spatial/sf/issues/1536 
install.packages("rgeos", repos="http://R-Forge.R-project.org", type="source")
install.packages("rgdal", repos="http://R-Forge.R-project.org", type="source")
library(devtools)
install_github("r-spatial/sf", configure.args = "--with-proj-lib=/usr/local/lib/")
library(sf)
library(ggplot2)

## import 
aoi_boundary_HARV <- st_read("/Users/kate/Desktop/BENV7503/tut/tut2_2009586/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")
lines_HARV <- st_read("/Users/kate/Desktop/BENV7503/tut/tut2_2009586/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")
point_HARV <- st_read("/Users/kate/Desktop/BENV7503/tut/tut2_2009586/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

## data structure 
st_geometry_type(aoi_boundary_HARV)
st_geometry_type(lines_HARV)
st_geometry_type(point_HARV)

st_crs(aoi_boundary_HARV)

st_bbox(aoi_boundary_HARV)
st_bbox(lines_HARV)
st_bbox(point_HARV)

## plot a shapefile 
ggplot() + 
  geom_sf(data = aoi_boundary_HARV, size = 3, color = "black", fill = "cyan1") + 
  ggtitle("AOI Boundary Plot") + 
  coord_sf()

################################################################################

# 7. Explore and Plot by Vector Layer Attributes 
  
## import 
library(raster)
library(dplyr)

## explore data 
ncol(aoi_boundary_HARV)
ncol(lines_HARV)
ncol(point_HARV)
names(lines_HARV)

lines_HARV$TYPE
levels(lines_HARV$TYPE)

## subset features 
footpath_HARV <- lines_HARV %>%
  filter(TYPE == "footpath")
nrow(footpath_HARV)

## plot 
ggplot() +
  geom_sf(data = footpath_HARV, aes(color = factor(OBJECTID)), size = 1.5) + 
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Footpaths") + 
  coord_sf()

## try boardwalk 
boardwalk_HARV <- lines_HARV %>%
  filter(TYPE == "boardwalk")

ggplot() +
  geom_sf(data = boardwalk_HARV, aes(color = factor(OBJECTID)), size = 1.5) + 
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Boardwalks") + 
  coord_sf()

##try stone wall 
stone_wall_HARV <- lines_HARV %>%
  filter(TYPE == "stone wall")

ggplot() +
  geom_sf(data = stone_wall_HARV, aes(color = factor(OBJECTID)), size = 1.5) + 
  labs(color = 'Wall ID') + 
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Stone Walls") + 
  coord_sf()

## customize plots 
road_colors <- c("red", "green", "navy", "purple")
ggplot() + 
  geom_sf(data = lines_HARV, aes(color = TYPE)) + 
  scale_color_manual(values = road_colors) + 
  labs(color = 'Road Type') + 
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails") + 
  coord_sf()


line_widths <- c(1,2,3,4)
ggplot() + 
  ## adjust line width 
  geom_sf(data = lines_HARV, aes(color = TYPE, size = TYPE)) + 
  scale_color_manual(values = road_colors) + 
  labs(color = 'Road Type') + 
  ## adjust line width 
  scale_size_manual(values = line_widths) + 
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails - Line width varies") + 
  coord_sf()

library(ggsci)
ggplot() + 
  geom_sf(data = lines_HARV, aes(color = TYPE)) + 
  labs(color = 'Road Type') + 
  ## add legend 
  theme_classic() + 
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails") + 
  coord_sf()
