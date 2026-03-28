WITH CustomerSpending AS (
    SELECT 
        c.ID_customer,
        c.name,
        COUNT(b.ID_booking) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        SUM(r.price * (b.check_out_date - b.check_in_date)) AS total_spent
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name
    HAVING COUNT(b.ID_booking) > 2 AND COUNT(DISTINCT h.ID_hotel) > 1
)
SELECT 
    ID_customer,
    name,
    total_bookings,
    ROUND(total_spent, 2) AS total_spent,
    unique_hotels
FROM CustomerSpending
WHERE total_spent > 500
ORDER BY total_spent;
