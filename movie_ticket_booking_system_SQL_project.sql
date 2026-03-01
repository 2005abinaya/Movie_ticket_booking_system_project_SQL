CREATE DATABASE movie_ticket_booking;
USE movie_ticket_booking;
CREATE TABLE users(user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    password VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE admin (admin_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);
CREATE TABLE movies (movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150),
    genre VARCHAR(50),
    duration INT,
    language VARCHAR(50),
    release_date DATE
);
CREATE TABLE theatres (theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_name VARCHAR(100),
    location VARCHAR(100)
);
CREATE TABLE screens (screen_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT,
    screen_name VARCHAR(50),
    total_seats INT,
    FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id)
);
CREATE TABLE shows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    screen_id INT,
    show_date DATE,
    show_time TIME,
    price DECIMAL(10,2),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id)
);
CREATE TABLE seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    screen_id INT,
    seat_number VARCHAR(10),
    seat_type VARCHAR(20),
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id)
);
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    show_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (show_id) REFERENCES shows(show_id)
);
CREATE TABLE booking_seats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    seat_id INT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (seat_id) REFERENCES seats(seat_id)
);
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    rating INT,
    comment TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);
CREATE TABLE offers (
    offer_id INT PRIMARY KEY AUTO_INCREMENT,
    offer_name VARCHAR(100),
    discount_percentage INT,
    valid_from DATE,
    valid_to DATE
);
CREATE TABLE applied_offers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    offer_id INT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (offer_id) REFERENCES offers(offer_id)
);
CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100)
);
CREATE TABLE theatre_city_map (
    id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT,
    city_id INT,
    FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
    );
INSERT INTO cities (city_name) VALUES
('Chennai'),('Coimbatore'),('Madurai'),
('Trichy'),('Salem');
INSERT INTO theatres (theatre_name, location) VALUES
('PVR Velachery','Velachery'),
('INOX Marina','Marina'),
('AGS Villivakkam','Villivakkam'),
('Rohini Theatre','Koyambedu'),
('Sathyam Cinemas','Royapettah');
INSERT INTO theatre_city_map (theatre_id, city_id) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1);
INSERT INTO screens (theatre_id, screen_name, total_seats) VALUES
(1,'Screen 1',150),
(1,'Screen 2',120),
(2,'Screen 1',200),
(3,'Screen 1',180),
(4,'Screen 1',160);
INSERT INTO movies (title, genre, duration, language, release_date) VALUES
('Leo','Action',160,'Tamil','2023-10-19'),
('Jailer','Action',150,'Tamil','2023-08-10'),
('Love Today','Romance',140,'Tamil','2023-11-01'),
('Avengers','Action',180,'English','2023-12-01'),
('KGF','Action',170,'Kannada','2023-09-15');
INSERT INTO shows (movie_id, screen_id, show_date, show_time, price) VALUES
(1,1,'2026-03-01','10:00:00',150),
(2,2,'2026-03-01','13:00:00',180),
(3,3,'2026-03-01','16:00:00',120),
(4,4,'2026-03-01','19:00:00',200),
(5,5,'2026-03-01','22:00:00',170);
INSERT INTO users (name,email,phone,password) VALUES
('Abi','abi@gmail.com','9876543210','1234'),
('Arun','arun@gmail.com','9876543211','1234'),
('Priya','priya@gmail.com','9876543212','1234'),
('Divya','divya@gmail.com','9876543213','1234'),
('Rahul','rahul@gmail.com','9876543214','1234');
INSERT INTO bookings (user_id, show_id, total_amount, status) VALUES
(1,1,300,'Confirmed'),
(2,2,180,'Confirmed'),
(3,3,120,'Cancelled'),
(4,4,400,'Confirmed'),
(5,5,170,'Confirmed');
INSERT INTO seats (screen_id, seat_number, seat_type) VALUES
(1,'A1','Regular'),
(1,'A2','Regular'),
(2,'B1','Premium'),
(3,'C1','Regular'),
(4,'D1','VIP');
INSERT INTO payments (booking_id,payment_method,payment_status) VALUES
(1,'UPI','Success'),
(2,'Card','Success'),
(3,'UPI','Failed'),
(4,'NetBanking','Success'),
(5,'Card','Success');
INSERT INTO reviews (user_id,movie_id,rating,comment) VALUES
(1,1,5,'Super movie'),
(2,2,4,'Mass'),
(3,3,3,'Good'),
(4,4,5,'Excellent'),
(5,5,4,'Nice');
INSERT INTO offers (offer_name,discount_percentage,valid_from,valid_to) VALUES
('Festival Offer',10,'2026-03-01','2026-03-31'),
('Weekend Offer',15,'2026-03-05','2026-03-10'),
('New User Offer',20,'2026-03-01','2026-04-01'),
('Summer Offer',25,'2026-04-01','2026-05-01'),
('Special Day Offer',5,'2026-03-01','2026-03-02');
INSERT INTO applied_offers (booking_id,offer_id) VALUES
(1,1),(2,2),(4,3),(5,1);
INSERT INTO admin (name,email,password) VALUES
('Admin1','admin1@gmail.com','admin123'),
('Admin2','admin2@gmail.com','admin123'),
('Admin3','admin3@gmail.com','admin123'),
('Admin4','admin4@gmail.com','admin123'),
('Admin5','admin5@gmail.com','admin123');
# All movies list
SELECT * FROM movies;
# Action genre movies
SELECT * FROM movies WHERE genre='Action';
# Movies running in Chennai
SELECT m.title
FROM movies m
JOIN shows s ON m.movie_id = s.movie_id
JOIN screens sc ON s.screen_id = sc.screen_id
JOIN theatres t ON sc.theatre_id = t.theatre_id
JOIN theatre_city_map tm ON t.theatre_id = tm.theatre_id
JOIN cities c ON tm.city_id = c.city_id
WHERE c.city_name='Chennai';
SELECT COUNT(*) FROM bookings;
# Total bookings count
SELECT COUNT(*) FROM bookings;
# Highest ticket price show
SELECT * FROM shows ORDER BY price DESC LIMIT 1;
# Total revenue
SELECT SUM(total_amount) FROM bookings WHERE status='Confirmed';
# Top rated movie
SELECT movie_id, AVG(rating) avg_rating
FROM reviews
GROUP BY movie_id
ORDER BY avg_rating DESC
LIMIT 1;
# Users who booked more than 3 times
SELECT user_id, COUNT(*) 
FROM bookings
GROUP BY user_id
HAVING COUNT(*) > 3;
# Cancelled bookings
SELECT * FROM bookings WHERE status='Cancelled';
# Seats booked for a show
SELECT seat_id FROM booking_seats
WHERE booking_id=1;
# Available seats for a show
SELECT s.seat_id
FROM seats s
WHERE s.screen_id = 1
AND s.seat_id NOT IN (
    SELECT bs.seat_id
    FROM booking_seats bs
    JOIN bookings b ON bs.booking_id = b.booking_id
    WHERE b.show_id = 1 AND b.status = 'Confirmed'
);
# Payment success list
SELECT * FROM payments
WHERE payment_status = 'Success';
# Bookings with applied offers
SELECT b.booking_id, o.offer_name
FROM bookings b
JOIN applied_offers ao ON b.booking_id = ao.booking_id
JOIN offers o ON ao.offer_id = o.offer_id;
# Theatre wise revenue
SELECT t.theatre_name, SUM(b.total_amount) revenue
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
JOIN screens sc ON s.screen_id = sc.screen_id
JOIN theatres t ON sc.theatre_id = t.theatre_id
GROUP BY t.theatre_name;
# City wise theatres count
SELECT c.city_name, COUNT(t.theatre_id) total_theatres
FROM cities c
JOIN theatre_city_map tm ON c.city_id = tm.city_id
JOIN theatres t ON tm.theatre_id = t.theatre_id
GROUP BY c.city_name;
# Today's shows
SELECT * FROM shows
WHERE show_date = CURDATE();
# Upcoming movies
SELECT * FROM movies
WHERE release_date > CURDATE();
# Users without bookings
SELECT * FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id FROM bookings
);
# Most active user
SELECT user_id, COUNT(*) total_bookings
FROM bookings
GROUP BY user_id
ORDER BY total_bookings DESC
LIMIT 1;
# Movie wise revenue
SELECT m.title, SUM(b.total_amount) revenue
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
JOIN movies m ON s.movie_id = m.movie_id
GROUP BY m.title;
# Peak show timing (most booked time)
SELECT s.show_time, COUNT(b.booking_id) total
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
GROUP BY s.show_time
ORDER BY total DESC
LIMIT 1;
# Highest earning theatre
SELECT t.theatre_name, SUM(b.total_amount) revenue
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
JOIN screens sc ON s.screen_id = sc.screen_id
JOIN theatres t ON sc.theatre_id = t.theatre_id
GROUP BY t.theatre_name
ORDER BY revenue DESC
LIMIT 1;
# Payment method usage count
SELECT payment_method, COUNT(*) 
FROM payments
GROUP BY payment_method;
# Reviews count per movie
SELECT movie_id, COUNT(*) review_count
FROM reviews
GROUP BY movie_id;
# Movies with no reviews
SELECT * FROM movies
WHERE movie_id NOT IN (
    SELECT DISTINCT movie_id FROM reviews
);
# Active offers
SELECT * FROM offers
WHERE CURDATE() BETWEEN valid_from AND valid_to;
# Booking count per day
SELECT DATE(booking_date), COUNT(*)
FROM bookings
GROUP BY DATE(booking_date);
# Monthly revenue
SELECT MONTH(booking_date) month, SUM(total_amount)
FROM bookings
GROUP BY MONTH(booking_date);
# Top 5 revenue movies
SELECT m.title, SUM(b.total_amount) revenue
FROM bookings b
JOIN shows s ON b.show_id = s.show_id
JOIN movies m ON s.movie_id = m.movie_id
GROUP BY m.title
ORDER BY revenue DESC
LIMIT 5;
# Most booked show
SELECT show_id, COUNT(*) total
FROM bookings
GROUP BY show_id
ORDER BY total DESC
LIMIT 1;
# Theatre with maximum screens
SELECT theatre_id, COUNT(*) screens
FROM screens
GROUP BY theatre_id
ORDER BY screens DESC
LIMIT 1;
# Average ticket price per movie
SELECT m.title, AVG(s.price)
FROM shows s
JOIN movies m ON s.movie_id = m.movie_id
GROUP BY m.title;
# Most used payment method
SELECT payment_method, COUNT(*) total
FROM payments
GROUP BY payment_method
ORDER BY total DESC
LIMIT 1;
# Fully booked shows
SELECT s.show_id
FROM shows s
JOIN bookings b ON s.show_id = b.show_id
GROUP BY s.show_id
HAVING SUM(b.total_amount) > 10000;
# Total seats per theatre
SELECT t.theatre_name, SUM(sc.total_seats)
FROM theatres t
JOIN screens sc ON t.theatre_id = sc.theatre_id
GROUP BY t.theatre_name;
# User last booking
SELECT * FROM bookings
WHERE user_id = 1
ORDER BY booking_date DESC
LIMIT 1;
# Movie running in multiple cities
SELECT m.title, COUNT(DISTINCT c.city_id) cities
FROM movies m
JOIN shows s ON m.movie_id = s.movie_id
JOIN screens sc ON s.screen_id = sc.screen_id
JOIN theatres t ON sc.theatre_id = t.theatre_id
JOIN theatre_city_map tm ON t.theatre_id = tm.theatre_id
JOIN cities c ON tm.city_id = c.city_id
GROUP BY m.title
HAVING cities > 1;
# Seat count booked per show
SELECT show_id, COUNT(bs.seat_id)
FROM bookings b
JOIN booking_seats bs ON b.booking_id = bs.booking_id
GROUP BY show_id;
# Cancelled booking revenue loss
SELECT SUM(total_amount)
FROM bookings
WHERE status='Cancelled';
# Total confirmed bookings
SELECT COUNT(*) FROM bookings
WHERE status='Confirmed';






