WITH CarAvg AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS car_avg_position,
        COUNT(r.race) AS race_count,
        cls.country AS car_country
    FROM Cars c
    JOIN Results r ON c.name = r.car
    JOIN Classes cls ON c.class = cls.class
    GROUP BY c.name, c.class, cls.country
),
ClassAvg AS (
    SELECT 
        car_class,
        AVG(car_avg_position) AS class_avg_position,
        COUNT(*) AS cars_in_class
    FROM CarAvg
    GROUP BY car_class
    HAVING COUNT(*) >= 2
)
SELECT 
    ca.car_name,
    ca.car_class,
    ROUND(ca.car_avg_position, 4) AS average_position,
    ca.race_count,
    ca.car_country
FROM CarAvg ca
JOIN ClassAvg cla ON ca.car_class = cla.car_class
WHERE ca.car_avg_position < cla.class_avg_position
ORDER BY ca.car_class, ca.car_avg_position;
