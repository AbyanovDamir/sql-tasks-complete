WITH CustomerBookings AS (
    SELECT 
        c.ID_customer,
        c.name,
        c.email,
        c.phone,
        COUNT(DISTINCT b.ID_booking) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        STRING_AGG(DISTINCT h.name, ', ' ORDER BY h.name) AS hotels_list,
        AVG(b.check_out_date - b.check_in_date) AS avg_stay_days
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name, c.email, c.phone
    HAVING COUNT(DISTINCT b.ID_booking) > 2 AND COUNT(DISTINCT h.ID_hotel) > 1
)
SELECT 
    name,
    email,
    phone,
    total_bookings,
    hotels_list,
    ROUND(avg_stay_days, 4) AS avg_stay_days
FROM CustomerBookings
ORDER BY total_bookings DESC;
