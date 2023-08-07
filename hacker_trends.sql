--  SELECT *
--  FROM hacker_news;

 SELECT title, score
 FROM hacker_news
 ORDER BY score DESC
 LIMIT 5;

 SELECT SUM(score)
 FROM hacker_news;

 SElECT user, SUM(score)
 FROM hacker_news
 GROUP BY user
 HAVING SUM(score) > 200
 ORDER BY 2 DESC;

SELECT (517 + 309 + 304 + 282) / 6366.0;

SELECT user, COUNT(*)
FROM hacker_news
WHERE url LIKE '%watch?v=dQw4w9WgXcQ'
-- GROUP BY user
-- ORDER BY COUNT(*) DESC;
GROUP BY 1
ORDER BY 2 DESC;

-- SELECT CASE
--   WHEN url like '%github%' THEN 'GitHub'
--   WHEN url like '%medium.com%' THEN 'Medium'
--   WHEN url like '%nytimes.com%' THEN 'New York Times'
--   ELSE 'Something else'
--   END AS 'Source'
-- FROM hacker_news;

SELECT CASE
  WHEN url like '%github%' THEN 'GitHub'
  WHEN url like '%medium.com%' THEN 'Medium'
  WHEN url like '%nytimes.com%' THEN 'New York Times'
  ELSE 'Something else'
  END AS 'Source',
  COUNT(*)
FROM hacker_news
GROUP BY 1;

SELECT timestamp
FROM hacker_news
LIMIT 10;

SELECT timestamp, 
  strftime('%H', timestamp)
FROM hacker_news
GROUP BY 1
LIMIT 20; 

-- SELECT strftime('%H', timestamp),
--   AVG(score),
--   COUNT(*)
-- FROM hacker_news
-- GROUP BY 1
-- ORDER BY 2 DESC;

SELECT strftime('%H', timestamp) AS 'Hour',
  ROUND(AVG(score), 1) AS 'Average Score',
  COUNT(*) AS 'Number of Stories'
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;

