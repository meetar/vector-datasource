SELECT name,
       amenity AS kind,
       way AS __geometry__,
       osm_id AS __id__

FROM planet_osm_point

WHERE (
      "amenity" IN ('parking')
)
