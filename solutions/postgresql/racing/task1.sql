-- Задача 1: Автомобили с наименьшей средней позицией в каждом классе (PostgreSQL)
WITH AvgPositions AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
MinAvgByClass AS (
    SELECT 
        car_class,
        MIN(average_position) AS min_avg_position
    FROM AvgPositions
    GROUP BY car_class
)
SELECT 
    ap.car_name,
    ap.car_class,
    ROUND(ap.average_position, 4) AS average_position,
    ap.race_count
FROM AvgPositions ap
JOIN MinAvgByClass mac ON ap.car_class = mac.car_class 
    AND ap.average_position = mac.min_avg_position
ORDER BY ap.average_position;
