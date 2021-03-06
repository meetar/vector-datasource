SELECT
  'base' AS land,
  the_geom AS __geometry__,
  gid::varchar AS __id__
FROM
  simplified_land_polygons
WHERE
  the_geom && !bbox!
