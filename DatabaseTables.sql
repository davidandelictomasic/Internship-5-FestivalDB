
CREATE TABLE festival (
    festival_id SERIAL PRIMARY KEY,
    festival_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    f_start_date DATE NOT NULL,
    f_end_date DATE NOT NULL,
    festival_status VARCHAR(20) NOT NULL,
    has_camp BOOLEAN DEFAULT FALSE
);
CREATE TABLE stage (
    stage_id SERIAL PRIMARY KEY,
    festival_id INT NOT NULL REFERENCES festival(festival_id),
    stage_name VARCHAR(100) NOT NULL,
    location_within_festival VARCHAR(50),
    max_capacity INT NOT NULL,
    covered BOOLEAN DEFAULT FALSE
);
CREATE TABLE performer (
    performer_id SERIAL PRIMARY KEY,
    performer_name VARCHAR(100) NOT NULL,
    country VARCHAR(100),
    genre VARCHAR(50),
    number_of_members INT,
    active BOOLEAN DEFAULT TRUE
);
CREATE TABLE performance (
    performance_id SERIAL PRIMARY KEY,
    festival_id INT NOT NULL REFERENCES festival(festival_id),
    stage_id INT NOT NULL REFERENCES stage(stage_id),
    performer_id INT NOT NULL REFERENCES performer(performer_id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    expected_number_of_attendees INT
);
CREATE TABLE visitor (
    visitor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    city VARCHAR(100),
    email VARCHAR(150),
    country VARCHAR(100)
);
CREATE TABLE ticket (
    ticket_id SERIAL PRIMARY KEY,
    ticket_type VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    ticket_description TEXT,
    valid_for VARCHAR(50)
);
CREATE TABLE visitor_order (
    order_id SERIAL PRIMARY KEY,
    visitor_id INT NOT NULL REFERENCES visitor(visitor_id),
    festival_id INT NOT NULL REFERENCES festival(festival_id),
    purchase_datetime TIMESTAMP NOT NULL,
    total_amount NUMERIC(10,2) NOT NULL
);
CREATE TABLE order_item (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES visitor_order(order_id),
    ticket_id INT NOT NULL REFERENCES ticket(ticket_id),
    quantity INT NOT NULL,
    price_per_unit NUMERIC(10,2) NOT NULL
);
CREATE TABLE mentor (
    mentor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    year_of_birth INT NOT NULL,
    area_of_expertise VARCHAR(100),
    years_of_experience INT NOT NULL
);
CREATE TABLE workshop (
    workshop_id SERIAL PRIMARY KEY,
    festival_id INT NOT NULL REFERENCES festival(festival_id),
    mentor_id INT NOT NULL REFERENCES mentor(mentor_id),
    workshopname VARCHAR(100) NOT NULL,
    difficulty_level VARCHAR(20) NOT NULL,
    max_participants INT NOT NULL,
    duration_hours INT NOT NULL,
    requires_prior_knowledge BOOLEAN DEFAULT FALSE
);
CREATE TABLE workshop_registration (
    registration_id SERIAL PRIMARY KEY,
    workshop_id INT NOT NULL REFERENCES workshop(workshop_id),
    visitor_id INT NOT NULL REFERENCES visitor(visitor_id),
    registration_status VARCHAR(20) NOT NULL,
    registration_time TIMESTAMP NOT NULL
);
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    festival_id INT NOT NULL REFERENCES festival(festival_id),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    staff_role VARCHAR(50) NOT NULL,
    contact VARCHAR(150),
    has_security_training BOOLEAN DEFAULT FALSE
);
CREATE TABLE membership_card (
    membership_id SERIAL PRIMARY KEY,
    visitor_id INT NOT NULL REFERENCES visitor(visitor_id),
    activation_date DATE NOT NULL,
    card_status VARCHAR(20) NOT NULL
);
CREATE TYPE festival_status_t AS ENUM ('planned','active','finished');

CREATE TYPE ticket_validity_t AS ENUM ('day','whole_festival');

CREATE TYPE difficulty_level_t AS ENUM ('beginner','intermediate','advanced');

CREATE TYPE registration_status_t AS ENUM ('registered','cancelled','attended');

ALTER TABLE festival
ALTER COLUMN festival_status TYPE festival_status_t
USING festival_status::festival_status_t;

ALTER TABLE ticket
ALTER COLUMN valid_for TYPE ticket_validity_t
USING valid_for::ticket_validity_t;

ALTER TABLE workshop
ALTER COLUMN difficulty_level TYPE difficulty_level_t
USING difficulty_level::difficulty_level_t;

ALTER TABLE workshop_registration
ALTER COLUMN registration_status TYPE registration_status_t
USING registration_status::registration_status_t;

ALTER TABLE mentor
ADD CONSTRAINT mentor_age_chk
CHECK (year_of_birth <= EXTRACT(YEAR FROM CURRENT_DATE) - 18);

ALTER TABLE mentor
ADD CONSTRAINT mentor_experience_chk
CHECK (years_of_experience >= 2);

ALTER TABLE staff
ADD CONSTRAINT security_age_check
CHECK (
    staff_role <> 'security'
    OR AGE(date_of_birth) >= INTERVAL '21 years'
);