-- 1
SELECT 
    w.festival_id, 
    w.difficulty_level, 
    f.f_end_date
FROM workshop w
JOIN festival f 
    ON w.festival_id = f.festival_id
WHERE w.difficulty_level = 'advanced' AND EXTRACT(YEAR FROM f.f_end_date) = 2025;
-- 2
SELECT performer_id, festival_id, stage_id,start_time FROM performance WHERE expected_number_of_attendees > 10000;
-- 3
SELECT *FROM festival WHERE EXTRACT(YEAR FROM f_end_date) = 2025;
-- 4
SELECT * FROM workshop WHERE difficulty_level = 'advanced';
-- 5
SELECT * FROM workshop WHERE duration_hours > 4;
-- 6
SELECT * FROM workshop WHERE requires_prior_knowledge = true;
-- 7
SELECT * FROM mentor WHERE years_of_experience > 10;
-- 8
SELECT * FROM mentor WHERE year_of_birth < 1985;
-- 9
SELECT * FROM visitor WHERE city = 'Split';
-- 10 
SELECT * FROM visitor WHERE email LIKE '%@gmail.com'
-- 11
SELECT * FROM visitor WHERE date_of_birth > CURRENT_DATE - INTERVAL '25 years';
-- 12 
SELECT * FROM ticket WHERE price > 120;
-- 13
SELECT * FROM ticket WHERE ticket_type = 'VIP';
-- 14
SELECT * FROM ticket WHERE valid_for = 'whole_festival';
-- 15
SELECT * FROM staff WHERE has_security_training = true;




