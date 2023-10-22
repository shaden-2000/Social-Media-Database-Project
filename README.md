# Social-Media-Database-Project
## a description
 The project contains a database for a social media site, and analyzes the database to extract information using SQL and mySQl database.
 ### there is :
 - file that contain how to create tables using SQL
 - file that contain the data insertion using SQL
 - ERD
 - description of the relations between tables
 - analyze the data by answering a questions using SQL

## analyze the data

1 - What is the location of each user in the social media database?
```
SELECT username, location
FROM users
LEFT JOIN post ON users.user_id=post.user_id
GROUP BY users.username;

```
This query selects the usernames and locations of users from the "users" table, and joins it with the "post" table based on the user_id. It then groups the results by the usernames of users.

2 - Which hashtag has the highest number of followers in the social media database? (Give me the first 5 ones).
```
SELECT hashtag_id,
 (SELECT hashtag_name
  FROM hashtags
  WHERE hashtags.hashtag_id = hashtag_follow.hashtag_id) AS NAME , 
COUNT ( hashtag_id) AS number_followers
FROM hashtag_follow
GROUP BY hashtag_id
ORDER BY number_followers DESC LIMIT 5 ;


```
This query select hashtag_id and hashtag_name as Naem from hashtags and count the number followers  from hashtag_follow group by hashtag_id and order by decrease for the first 5.


3 - What are the most frequently used hashtags in the social media database?  (Give me the used for all hashtags and determine which one is the most).
```
SELECT hashtag_id ,
 (SELECT hashtag_name 
  FROM hashtags 
  WHERE hashtags.hashtag_id= hashtag_follow.hashtag_id)AS NAME,
COUNT(hashtag_id )as highest_number
FROM hashtag_follow
GROUP BY hashtag_id
ORDER BY highest_number DESC
LIMIT 5;



```
subquery were used , first to count how much each hashtag have been used from hashtag_follow table and name it highest_number, and the inner query result sent to the outer to determine the hashtag name and  order highest_number in decrease order to give the most frequently used hashtags



4 - Who is the most inactive user (or the user with the least activity) in the social media database? (Give me the first 5 and determine which one is the least).
```
SELECT user_id, count(*) AS activitycount 
FROM users 
GROUP BY user_id 
ORDER BY activitycount asc
LIMIT 5;




```

5 - Which posts have received the highest number of likes in the social media database?
```
SELECT p.post_id,
COUNT(l.user_id) AS like_count
FROM post p 
JOIN post_likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY like_count DESC;

```
This query selects the post_id from the "post" table and counts the number of likes for each post by joining it with the "post_likes" table. The results are then grouped by post_id and ordered in descending order based on the like count.

6 - What is the average number of posts per user in the social media database?

```
SELECT AVG(post_count) AS average_posts_per_user
FROM (
    SELECT user_id, COUNT(post_id) AS post_count
    FROM post
    GROUP BY user_id
) AS tabless;


```
This query selects the AVG(post_count) from the "tabless" table.  counts the number of post_id for each user_id  grouped by user_id.

7 - How many times has each user logged in to the social media platform?


```
SELECT user_id ,count(*) AS login
FROM login
GROUP BY user_id;


```


8 - Are there any users who have liked every single post in the social media database?


```
SELECT user_id
FROM post_likes
GROUP BY user_id 
HAVING COUNT(DISTINCT post_id) = (
 SELECT COUNT(*)
 FROM photos);


```


9 - Which users have never made a comment in the social media database? 


```
SELECT user_id
FROM users 
WHERE user_id NOT IN (
 SELECT DISTINCT user_id
 FROM comments);



```


10 - Are there any users who have commented on every post in the social media database?


```
SELECT users.user_id, users.username
FROM users
LEFT JOIN comments ON users.user_id = comments.user_id
WHERE comments.comment_id IS NULL;




```
This SQL query selects the user ID and username from the "users" table, joining it with the "comments" table on the user ID and filtering for users who have no corresponding comments.



11 - Which users are not followed by anyone in the social media database?



```
SELECT u.username
FROM users u
LEFT JOIN follows f ON u.user_id = f.followee_id
WHERE f.followee_id IS NULL;




```
This SQL code retrieves the usernames of users who are not followed by anyone in the social media database using a left join and a null check.


12 - Which users are not following anyone in the social media database?




```
SELECT user_id
FROM users 
WHERE user_id NOT IN (
 SELECT distinct follower_id
 FROM follows
);




```
 subquery were used ,  the user that will be selected is the user that is not following anyone  ,  the user that will be selected is from users table and this  query is in the outer query , the user that is not following anyone is from follows table and this query is inner query  




 
13 - Which users have posted more than five times in the social media database?




```
SELECT users.username , 
(
 SELECT  COUNT(post.user_id) 
 FROM post
 WHERE post.user_id = users.user_id
)AS posts
FROM users
GROUP BY users.user_id
HAVING posts > 5 ;



```
subquery were used to count first how much post for each user and use having clause to determine which users have posted more than five times






14 - Which users have more than 40 followers in the social media database?




```
SELECT u.username
FROM users u
JOIN follows f ON u.user_id = f.followee_id
GROUP BY u.username
HAVING COUNT(f.follower_id) > 40;




```

This SQL code retrieves the usernames of users who have more than 40 followers by joining the "users" and "follows" tables, grouping by username, and applying a filter with the "HAVING" clause.




15 - Are there any comments in the social media database that contain a specific word? (specific word = good or beautiful)




```
SELECT comment_id, comment_text
FROM comments
WHERE comment_text LIKE '%good%' OR comment_text LIKE '%beautiful%';





```
This SQL query selects the comment ID and comment text from the "comments" table in the "Social_Media" database, filtering the results to include comments that contain the words "good" or "beautiful" in their text.



16 - Which posts have the longest captions in the social media database?





```
SELECT post_id, caption
FROM post
ORDER BY LENGTH(caption) DESC
LIMIT 5;






```
This SQL query selects the post ID and caption from the "post" table in the "Social_Media" database, ordering the results by the length of the caption in descending order, and limits the output to the top 5 records.






