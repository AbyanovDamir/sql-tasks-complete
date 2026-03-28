-- Задача 3: Классы с наименьшей средней позицией (PostgreSQL)
WITH ClassAvg AS (
    SELECT 
        c.class AS car_class,
        AVG(r.position) AS class_avg_position
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.class
),
MinClassAvg AS (
    SELECT MIN(class_avg_position) AS min_avg
    FROM ClassAvg
),
SelectedClasses AS (
    SELECT car_class
    FROM ClassAvg
    WHERE class_avg_position = (SELECT min_avg FROM MinClassAvg)
)
SELECT 
    c.name AS car_name,
    c.class AS car_class,
    ROUND(AVG(r.position), 4) AS average_position,
    COUNT(r.race) AS race_count,
    cls.country AS car_country,
    (SELECT COUNT(DISTINCT race) FROM Results WHERE car IN (SELECT name FROM Cars WHERE class = c.class)) AS total_races
FROM Cars c
JOIN Results r ON c.name = r.car
JOIN Classes cls ON c.class = cls.class
WHERE c.class IN (SELECT car_class FROM SelectedClasses)
GROUP BY c.name, c.class, cls.country
ORDER BY average_position;
