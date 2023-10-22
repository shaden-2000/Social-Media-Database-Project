-- 1 What is the location of each user in the social media database?
select username, location
from users
 left join post on users.user_id=post.user_id
 GROUP BY users.username;
 
-- 2 Which hashtag has the highest number of followers in the social media database? (Give me the first 5 ones).
 select hashtag_id ,
 (select hashtag_name from hashtags where hashtags.hashtag_id= hashtag_follow.hashtag_id)AS NAME,
 count(hashtag_id )as highest_number
 from hashtag_follow
 group by hashtag_id
 order by highest_number DESC
 LIMIT 5;
 
 -- 3 What are the most frequently used hashtags in the social media database?  (Give me the used for all hashtags and determine which one is the most).
            SELECT users.username , (
            SELECT  COUNT(post.user_id) 
            FROM post
            WHERE post.user_id = users.user_id
            )AS posts
            FROM users
            GROUP BY users.user_id
            having posts > 5 ;
            
-- 4 Who is the most inactive user (or the user with the least activity) in the social media database?
-- (Give me the first 5 and determine which one is the least).
select user_id, count(*) AS activitycount 
from users 
group by user_id 
order by activitycount asc
limit 5;      

-- 5 Which posts have received the highest number of likes in the social media database?
 select p.post_id,
count(l.user_id) as like_count
from post p 
join post_likes l on p.post_id = l.post_id
group by p.post_id
order by like_count desc;

-- 6 What is the average number of posts per user in the social media database?
Use social_media;
SELECT AVG(post_count) AS average_posts_per_user
FROM (
    SELECT user_id, COUNT(post_id) AS post_count
    FROM post
    GROUP BY user_id
) AS post_counts;

-- 7 How many times has each user logged in to the social media platform?
SELECT user_id ,count(*) AS login
FROM login
group by user_id;

-- 8 Are there any users who have liked every single post in the social media database?
SELECT user_id
FROM post_likes
group by user_id 
having count(distinct post_id) = (select count(*) from photos);

-- 9 Which users have never made a comment in the social media database?
select user_id
from users 
where user_id NOT IN (select distinct user_id from comments);

-- 10 Are there any users who have commented on every post in the social media database?
SELECT users.user_id, users.username
FROM users
LEFT JOIN comments ON users.user_id = comments.user_id
WHERE comments.comment_id IS NULL;
-- 11 Which users are not followed by anyone in the social media database?
SELECT u.username
FROM users u
LEFT JOIN follows f ON u.user_id = f.followee_id
WHERE f.followee_id IS NULL;

-- 12 Which users are not following anyone in the social media database?
SELECT user_id
FROM users 
WHERE user_id NOT IN (
SELECT distinct follower_id
FROM follows
);

-- 13 Which users have posted more than five times in the social media database?
  SELECT users.username , 
          (
          SELECT  COUNT(post.user_id) 
          FROM post
         WHERE post.user_id = users.user_id
         )AS posts
         FROM users
        GROUP BY users.user_id
        having posts > 5 ;
        
-- 14 Which users have more than 40 followers in the social media database?
SELECT u.username
FROM users u
JOIN follows f ON u.user_id = f.followee_id
GROUP BY u.username
HAVING COUNT(f.follower_id) > 40;

-- 15 Are there any comments in the social media database that contain a 
-- specific word? (specific word = good or beautiful)
SELECT comment_id, comment_text
FROM comments
WHERE comment_text LIKE '%good%' OR comment_text LIKE '%beautiful%';

-- 16 Which posts have the longest captions in the social media database?
SELECT post_id, caption
FROM post
ORDER BY LENGTH(caption) DESC
LIMIT 5;
