CREATE TABLE speakers (
  id integer NOT NULL, 
  email varchar NOT NULL,
  name varchar NOT NULL,
  organization varchar,
  title varchar,
  years_in_role integer
); 

INSERT INTO speakers (id, email, name, organization, title, years_in_role)
VALUES (1, 'awilson@ABCcorp.com', 'A. Wilson', 'ABC Corp.', 'CTO', 6); 

-- ADD NOT NULL VALUE INTO TABLE
ALTER TABLE speakers 
ALTER COLUMN name SET NOT NULL; 

-- ADDING NOT NULL INTO EXISTING TABLE WHERE THERE ARE NULL VALUES FOR ROWS ALREADY
-- 1. default statement for all existing null values (removes null)
UPDATE speakers
SET organization = 'TBD'
WHERE organization IS NULL;
-- 2. set not null as constraint for table 
ALTER TABLE speakers
ALTER COLUMN organization SET NOT NULL; 

-- checks to make sure certain conditions are met
ALTER TABLE speakers
ADD CHECK (years_in_role < 100); 
-- checks for two conditions
ALTER TABLE speakers
ADD CHECK (years_in_role > 0 AND years_in_role < 100); 

-- checks to ensure that total standard_tickets_reserved + vip_tickets_reserved = total_tickets_reserved
ALTER TABLE attendees 
ADD CHECK (standard_tickets_reserved + vip_tickets_reserved = total_tickets_reserved); 

-- adds unique identifier to table
ALTER TABLE speakers
ADD UNIQUE (email); 

-- multi-column UNIQUE constraint that ensures attendees (identified by attendee_id) are registered for only one talk at a time (identified by session_timeslot)
CREATE TABLE registrations (
    id integer NOT NULL,
    attendee_id integer NOT NULL,
    session_timeslot timestamp NOT NULL,
    talk_id integer NOT NULL,
    UNIQUE (attendee_id, session_timeslot)
);

-- adding a primary key to a table
ALTER TABLE speakers
ADD PRIMARY KEY (id); 

-- adding a foreign key to a table 
ALTER TABLE talks
ADD FOREIGN KEY (speaker_id)
REFERENCES speakers(id); 

SELECT *
FROM speakers; 

INSERT INTO talks VALUES (
  21, 
  'Data Warehousing Best Practices',
  8,
  30,
 '2020-08-05 18:00'
);

-- However, another strategy you may consider is adding a CASCADE clause. 
-- Rather than preventing changes, CASCADE clauses (ON UPDATE CASCADE, 
-- ON DELETE CASCADE) cause the updates or deletes to automatically be applied
--  to any child tables.

-- automatically unregister attendees from a talk that’s been cancelled
ALTER TABLE talks
ADD FOREIGN KEY (speaker_id)
REFERENCES speakers (id) ON DELETE CASCADE;
-- shows all talks with all speakers
SELECT * 
FROM talks; 
-- removes all of speaker 2 talks from talks table
DELETE FROM speakers
WHERE id = 2; 
-- shows table with speaker_id=2 removed
SELECT * 
FROM talks; 

