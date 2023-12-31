CREATE TABLE restaurant (
  id integer PRIMARY KEY,
  name varchar(100),
  description varchar(100),
  rating decimal, 
  telephone char(10),
  hours varchar(100)
);

CREATE TABLE address (
  id integer PRIMARY KEY,
  street_number varchar(10),
  street_name varchar(20),
  city varchar(20),
  state varchar(15),
  google_map_link varchar(50),
  restaurant_id integer REFERENCES restaurant(id) UNIQUE
); 

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'restaurant';

  SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'address';

CREATE TABLE category (
  id varchar(2) PRIMARY KEY,
  name varchar(20),
  description varchar(200)
); 

CREATE TABLE dish (
  id integer PRIMARY KEY,
  name varchar(50),
  description varchar(200),
  hot_and_spicy boolean
); 

CREATE TABLE categories_dishes (
  category_id varchar(2) REFERENCES category(id),
  dish_id integer REFERENCES dish(id),
  price money,
  PRIMARY KEY (dish_id, category_id)
); 

CREATE TABLE review (
  id integer PRIMARY KEY,
  rating decimal,
  description varchar(100),
  post_date date,
  restaurant_id integer REFERENCES restaurant(id)
); 

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'review';

  SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'category';

  SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'categories_dishes';

  SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'dishes';

/* 
 *--------------------------------------------
 Insert values for restaurant
 *--------------------------------------------
 */
INSERT INTO restaurant VALUES (
  1,
  'China Bytes',
  'Delectable Chinese Cuisine',
  3.9,
  '6175551212',
  'Mon - Fri 9:00 am to 9:00 pm, Weekends 10:00 am to 11:00 pm'
);

INSERT INTO address VALUES (
  1,
  '2020',
  'Busy Street',
  'Chinatown',
  'MA',
  'http://bit.ly/ChinaBytes',
  1
);

INSERT INTO review VALUES (
  1,
  5.0,
  'Would love to host another birthday party at China Byte!',
  '05-22-2020',
  1
);

INSERT INTO review VALUES (
  2,
  4.5,
  'Other than a small mix-up, I would give it a 5.0!',
  '04-01-2020',
  1
);

INSERT INTO review VALUES (
  3,
  3.9,
  'A reasonable place to eat for lunch, if you are in a rush!',
  '03-15-2020',
  1
);

/* 
 *--------------------------------------------
 Insert values for category
 *--------------------------------------------
 */
INSERT INTO category VALUES (
  'C',
  'Chicken',
  null
);

INSERT INTO category VALUES (
  'LS',
  'Luncheon Specials',
  'Served with Hot and Sour Soup or Egg Drop Soup and Fried or Steamed Rice  between 11:00 am and 3:00 pm from Monday to Friday.'
);

INSERT INTO category VALUES (
  'HS',
  'House Specials',
  null
);

INSERT INTO dish VALUES (
  1,
  'Chicken with Broccoli',
  'Diced chicken stir-fried with succulent broccoli florets',
  false
);

INSERT INTO dish VALUES (
  2,
  'Sweet and Sour Chicken',
  'Marinated chicken with tangy sweet and sour sauce together with pineapples and green peppers',
  false
);

INSERT INTO dish VALUES (
  3,
  'Chicken Wings',
  'Finger-licking mouth-watering entree to spice up any lunch or dinner',
  true
);

INSERT INTO dish VALUES (
  4,
  'Beef with Garlic Sauce',
  'Sliced beef steak marinated in garlic sauce for that tangy flavor',
  true
);

INSERT INTO dish VALUES (
  5,
  'Fresh Mushroom with Snow Peapods and Baby Corns',
  'Colorful entree perfect for vegetarians and mushroom lovers',
  false
);

INSERT INTO dish VALUES (
  6,
  'Sesame Chicken',
  'Crispy chunks of chicken flavored with savory sesame sauce',
  false
);

INSERT INTO dish VALUES (
  7,
  'Special Minced Chicken',
  'Marinated chicken breast sauteed with colorful vegetables topped with pine nuts and shredded lettuce.',
  false
);

INSERT INTO dish VALUES (
  8,
  'Hunan Special Half & Half',
  'Shredded beef in Peking sauce and shredded chicken in garlic sauce',
  true
);

SELECT *
FROM dish;

INSERT INTO categories_dishes VALUES (
  'C',
  1,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'C',
  3,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  1,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  4,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  5,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  6,
  15.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  7,
  16.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  8,
  17.95
);

SELECT *
FROM categories_dishes;

SELECT restaurant.name as restaurant, address.street_number as street_number, address.street_name as street_name, restaurant.telephone as telephone
FROM restaurant
JOIN address
ON restaurant.id = address.restaurant_id; 

-- get best rating from reviews
SELECT MAX(rating) as best_rating
FROM review; 

-- display dishes by category 
SELECT dish.name as dish_name, categories_dishes.price as price, category.name as category
FROM dish
INNER JOIN categories_dishes
  ON dish.id = categories_dishes.dish_id
INNER JOIN category
  ON category.id = categories_dishes.category_id
ORDER BY category.name; 

--display all dishes by dish name
SELECT dish.name as dish_name, categories_dishes.price as price, category.name as category
FROM dish
INNER JOIN categories_dishes
  ON dish.id = categories_dishes.dish_id
INNER JOIN category
  ON category.id = categories_dishes.category_id
ORDER BY dish.name; 

-- all spicy dishes
SELECT dish.name as spicy_dish_name, category.name as category, categories_dishes.price as price
FROM dish
INNER JOIN categories_dishes
  ON dish.id = categories_dishes.dish_id
INNER JOIN category
  ON category.id = categories_dishes.category_id
  WHERE dish.hot_and_spicy = 'true'; 

-- ALL dishes and there number of appearances
SELECT dish_id, COUNT(dish_id)
FROM categories_dishes
GROUP BY dish_id; 

-- all dishes that appear more than once
SELECT dish_id, COUNT(dish_id)
FROM categories_dishes
GROUP BY dish_id
  HAVING COUNT(dish_id) > 1; 

--incorporating dish name as well
SELECT categories_dishes.dish_id, dish.name, COUNT(categories_dishes.dish_id)
FROM categories_dishes
JOIN dish
  ON categories_dishes.dish_id = dish.id
GROUP BY dish_id, dish.name
  HAVING COUNT(dish_id) > 1; 

-- obtain best rating with details
SELECT rating, description
FROM review
  WHERE rating = (SELECT MAX(rating) as best_rating FROM review); 
