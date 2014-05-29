#!/bin/sh
#
# After unpacking the contents of each zip archive, pipe this script to psql.
# example:
# bash shp2pgsql.sh | psql -U osm -d osm
#
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_10m_lakes.shp ne_10m_lakes
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_10m_ocean.shp ne_10m_ocean
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_10m_playas.shp ne_10m_playas
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_110m_lakes.shp ne_110m_lakes
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_110m_ocean.shp ne_110m_ocean
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_50m_lakes.shp ne_50m_lakes
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_50m_ocean.shp ne_50m_ocean
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_50m_playas.shp ne_50m_playas
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_50m_urban_areas.shp ne_50m_urban_areas
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_10m_urban_areas.shp ne_10m_urban_areas
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/ne_10m_parks_and_protected_lands_area.shp ne_10m_parks_and_protected_lands
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/simplified_land_polygons.shp simplified_land_polygons
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/land_polygons.shp land_polygons
shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom ./data/water_polygons.shp water_polygons
