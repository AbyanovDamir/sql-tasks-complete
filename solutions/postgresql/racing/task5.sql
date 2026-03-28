-- Задача 5: Классы с наибольшим количеством автомобилей с позицией > 3.0 (PostgreSQL)
WITH CarAvg AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count,
        cls.country AS car_country,
        (SELECT COUNT(DISTINCT race) FROM Results WHERE car IN (SELECT name FROM Cars WHERE class = c.class)) AS total_races
    FROM Cars c
    JOIN Results r ON c.name = r.car
    JOIN Classes cls ON c.class = cls.class
    GROUP BY c.name, c.class, cls.country
),
LowPositionCars AS (
    SELECT 
        car_class,
        COUNT(*) AS low_position_count
    FROM CarAvg
    WHERE average_position > 3.0
    GROUP BY car_class
),
MaxLowCount AS (
    SELECT MAX(low_position_count) AS max_count
    FROM LowPositionCars
)
SELECT 
    ca.car_name,
    ca.car_class,
    ROUND(ca.average_position, 4) AS average_position,
    ca.race_count,
    ca.car_country,
    ca.total_races,
    lpc.low_position_count
FROM CarAvg ca
JOIN LowPositionCars lpc ON ca.car_class = lpc.car_class
WHERE lpc.low_position_count = (SELECT max_count FROM MaxLowCount)
ORDER BY lpc.low_position_count DESC;
