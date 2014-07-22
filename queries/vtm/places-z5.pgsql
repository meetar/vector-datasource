SELECT name, place, boundary, admin_level, __geometry__

FROM
(
    --
    -- Place Border
    --
    SELECT  
    name,
    '' AS place,
    boundary,
    admin_level, 
    way AS __geometry__ 
  
    FROM planet_osm_polygon 
    
    WHERE way && !bbox! 

    AND boundary='administrative' 

    AND admin_level = '4' -- state
    
    --
    -- Place Name
    --
    UNION

    SELECT 
      name, 
      place,
      '' AS boundary,
      '' AS admin_level,
      way AS __geometry__ 

    FROM planet_osm_point 

    WHERE name IS NOT NULL 

    AND place IN (
      'ocean', 
      'country',
      'state',
      'sea'
    )

    AND way && !bbox!

) AS places
