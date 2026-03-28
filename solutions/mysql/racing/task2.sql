-- Задача 2: Автомобиль с наименьшей средней позицией
WITH AvgPositions AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count,
        cls.country AS car_country
    FROM Cars c
    JOIN Results r ON c.name = r.car
    JOIN Classes cls ON c.class = cls.class
    GROUP BY c.name, c.class, cls.country
)
SELECT
    car_name,
    car_class,
    ROUND(average_position, 4) AS average_position,
    race_count,
    car_country
FROM AvgPositions
WHERE average_position = (SELECT MIN(average_position) FROM AvgPositions)
ORDER BY car_name
LIMIT 1;
