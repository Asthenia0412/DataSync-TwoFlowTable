USE mock_tpi;

-- Insert 1000 rows into university_core
INSERT INTO university_core (university_id, name_std, country_code, data_source, original_id, status, last_merge_time)
SELECT 
    n AS university_id,
    CONCAT('University ', n) AS name_std,
    CASE 
        WHEN n % 10 = 0 THEN 'USA'
        WHEN n % 10 = 1 THEN 'CHN'
        WHEN n % 10 = 2 THEN 'GBR'
        WHEN n % 10 = 3 THEN 'CAN'
        WHEN n % 10 = 4 THEN 'AUS'
        WHEN n % 10 = 5 THEN 'JPN'
        WHEN n % 10 = 6 THEN 'DEU'
        WHEN n % 10 = 7 THEN 'FRA'
        WHEN n % 10 = 8 THEN 'IND'
        ELSE 'SGP'
    END AS country_code,
    CASE 
        WHEN n % 3 = 0 THEN 'QS'
        WHEN n % 3 = 1 THEN 'THE'
        ELSE 'Internal'
    END AS data_source,
    CONCAT('ORIG_', n) AS original_id,
    CASE 
        WHEN n % 4 = 0 THEN 'Active'
        WHEN n % 4 = 1 THEN 'Merged'
        WHEN n % 4 = 2 THEN 'Pending'
        ELSE 'Inactive'
    END AS status,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS last_merge_time
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into qs_ranking_data
INSERT INTO qs_ranking_data (id, university_name, qs_rank, the_rank, year, created_at)
SELECT 
    n AS id,
    CONCAT('University ', FLOOR(RAND() * 1000) + 1) AS university_name,
    FLOOR(RAND() * 500) + 1 AS qs_rank,
    FLOOR(RAND() * 500) + 1 AS the_rank,
    2020 + FLOOR(RAND() * 6) AS year,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS created_at
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into program_data
INSERT INTO program_data (program_id, university_id, program_name, degree_type, duration)
SELECT 
    n AS program_id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    CONCAT('Program ', n) AS program_name,
    CASE 
        WHEN n % 3 = 0 THEN 'Bachelor'
        WHEN n % 3 = 1 THEN 'Master'
        ELSE 'PhD'
    END AS degree_type,
    12 + FLOOR(RAND() * 48) AS duration
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into scholarship_data
INSERT INTO scholarship_data (scholarship_id, university_id, name, amount, deadline)
SELECT 
    n AS scholarship_id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    CONCAT('Scholarship ', n) AS name,
    ROUND(RAND() * 20000 + 1000, 2) AS amount,
    DATE_ADD('2025-01-01', INTERVAL FLOOR(RAND() * 365) DAY) AS deadline
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into fee_data
INSERT INTO fee_data (id, university_id, tuition_fee, accommodation_fee, year)
SELECT 
    n AS id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    ROUND(RAND() * 50000 + 5000, 2) AS tuition_fee,
    ROUND(RAND() * 10000 + 2000, 2) AS accommodation_fee,
    2020 + FLOOR(RAND() * 6) AS year
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into admission_data
INSERT INTO admission_data (id, university_id, admission_rate, avg_gpa, intl_ratio)
SELECT 
    n AS id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    ROUND(RAND() * 50 + 5, 2) AS admission_rate,
    ROUND(RAND() * 1.5 + 2.5, 2) AS avg_gpa,
    ROUND(RAND() * 30 + 5, 2) AS intl_ratio
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into requirement_data
INSERT INTO requirement_data (id, university_id, ielts_min, toefl_min, documents)
SELECT 
    n AS id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    ROUND(5.5 + RAND() * 2, 1) AS ielts_min,
    FLOOR(70 + RAND() * 30) AS toefl_min,
    CONCAT('Transcript, Recommendation Letter, ', CASE WHEN n % 2 = 0 THEN 'Personal Statement' ELSE 'Resume' END) AS documents
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into faculty_data
INSERT INTO faculty_data (faculty_id, university_id, name, research_field)
SELECT 
    n AS faculty_id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    CONCAT('Faculty ', n) AS name,
    CASE 
        WHEN n % 4 = 0 THEN 'Computer Science'
        WHEN n % 4 = 1 THEN 'Engineering'
        WHEN n % 4 = 2 THEN 'Business'
        ELSE 'Medicine'
    END AS research_field
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into campus_data
INSERT INTO campus_data (id, university_id, location, latitude, facilities)
SELECT 
    n AS id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    CONCAT('Campus ', n) AS location,
    ROUND(RAND() * 180 - 90, 6) AS latitude,
    CASE 
        WHEN n % 3 = 0 THEN 'Library, Gym, Labs'
        WHEN n % 3 = 1 THEN 'Dormitories, Cafeteria'
        ELSE 'Sports Fields, Lecture Halls'
    END AS facilities
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into partner_data
INSERT INTO partner_data (id, university_id, partner_name, agreement_type)
SELECT 
    n AS id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    CONCAT('Partner ', n) AS partner_name,
    CASE 
        WHEN n % 3 = 0 THEN 'Exchange'
        WHEN n % 3 = 1 THEN 'Research'
        ELSE 'Dual Degree'
    END AS agreement_type
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;

-- Insert 1000 rows into event_data
INSERT INTO event_data (event_id, university_id, event_type, start_time)
SELECT 
    n AS event_id,
    (FLOOR(RAND() * 1000) + 1) AS university_id,
    CASE 
        WHEN n % 4 = 0 THEN 'Seminar'
        WHEN n % 4 = 1 THEN 'Workshop'
        WHEN n % 4 = 2 THEN 'Conference'
        ELSE 'Open Day'
    END AS event_type,
    NOW() + INTERVAL FLOOR(RAND() * 365) DAY AS start_time
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + 1 AS n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
    WHERE a.N + b.N * 10 + c.N * 100 < 1000
    ORDER BY n
) numbers;