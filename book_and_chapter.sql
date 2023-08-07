CREATE TABLE book (
  title varchar(100),
  isbn varchar(50) PRIMARY KEY,
  pages integer,
  price money,
  description varchar(256),
  publisher varchar(100)
);

CREATE TABLE chapter (
  id integer PRIMARY KEY,
  number integer,
  title varchar(50),
  content varchar(1024),
  book_isbn varchar(50) REFERENCES book(isbn)
);

-- comes back with foreign key added book.isbn
SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'chapter'; 

  SELECT *
FROM book; 

SELECT *
FROM chapter;
--query returns a table of books with associated chapters
SELECT book.title AS book, chapter.title AS chapters
FROM book, chapter
WHERE book.isbn = chapter.book_isbn; 

SELECT book.title  as title, book.price as price, book_details.language as language, book_details.rating as rating 
FROM book
JOIN book_details
ON book.isbn = book_details.book_isbn; 

CREATE TABLE books_authors (
  book_isbn varchar(50) REFERENCES book(isbn),
  author_email varchar(20) REFERENCES author(email),
  PRIMARY KEY (book_isbn, author_email)
); 

SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'books_authors';

  SELECT *
FROM book;

SELECT *
FROM author; 

INSERT INTO books_authors VALUES(
  '123457890', 'jkey@db.com'
); 

INSERT INTO books_authors VALUES(
  '123457890', 'cindex@db.com'
); 

INSERT INTO books_authors VALUES(
  '987654321', 'cindex@db.com'
); 

SELECT *
FROM books_authors;

SELECT book.title as book_title, author.name as author_name, book.description as book_description
FROM book
INNER JOIN books_authors
  ON books_authors.book_isbn = book.isbn
INNER JOIN author
  ON books_authors.author_email = author.email;