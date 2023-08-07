-- SELECT *
-- FROM parts
-- LIMIT 10; 
-- makes code UNIQUE
ALTER TABLE parts
ADD UNIQUE (code); 

-- makes code NOT NULL
ALTER TABLE parts
ALTER COLUMN code SET NOT NULL;

-- describes all null descriptions, then makes not null constraint
UPDATE parts
SET description = 'NONE AVAILABLE'
WHERE description IS NULL; 

ALTER TABLE parts
ALTER COLUMN description SET NOT NULL; 

-- UPDATE parts
-- SET description = 'Updating table here'
-- WHERE id = 9; 

SELECT *
FROM parts; 

-- returns error as description cannot be null 
-- INSERT INTO parts (id, code, manufacturer_id) VALUES (
--   54,
--   'V1-009',
--   9
-- ); 
-- makes price_usd and quantity postive, not null figures
ALTER TABLE reorder_options
ADD CHECK (price_usd IS NOT NULL AND quantity IS NOT NULL); 

ALTER TABLE reorder_options
ADD CHECK (price_usd > 0 AND quantity > 0);

-- limits price per unit to between $.02 and $25.00
ALTER TABLE reorder_options
ADD CHECK (price_usd/quantity > .02 AND price_usd/quantity < 25); 

-- Form a relationship between parts and reorder_options that ensures all parts in reorder_options refer to parts tracked in parts
ALTER TABLE parts
ADD PRIMARY KEY (id); 

ALTER TABLE reorder_options
ADD FOREIGN KEY (part_id)
REFERENCES parts (id) ON DELETE CASCADE; 

-- each value in qty is greater than 0
ALTER TABLE locations
ADD CHECK (qty > 0); 

-- only one row for each combination of location and part
ALTER TABLE locations
ADD UNIQUE (part_id, location); 

DELETE FROM locations
WHERE part_id = 54; 
-- ensure all locations part_id have corresponding entries within parts table
ALTER TABLE locations
ADD FOREIGN KEY (part_id)
REFERENCES parts (id); 

SELECT *
FROM locations;
-- constraint that forms a relationship between parts and manufacturers that ensures that all parts have a valid manufacturer
ALTER TABLE parts
ADD FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(id); 

-- update manufacturer where two companies merged, update the parts with new manufacturer id
INSERT INTO manufacturers VALUES (
  11, 
  'Pip-NNC Industrial'
);

SELECT *
FROM manufacturers;
-- IN can be used as an OR to select multiple values
UPDATE parts
SET manufacturer_id = 11
WHERE manufacturer_id IN (1, 2); 

-- OR can also be used to accomplish the same thing
UPDATE parts
SET manufacturer_id = 11
WHERE manufacturer_id = 1 OR manufacturer_id = 2; 