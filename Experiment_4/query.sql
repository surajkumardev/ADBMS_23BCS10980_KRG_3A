1148. Article Views I
Table: Views
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
Write a solution to find all the authors who viewed at least one of their own articles.
Return the result table sorted by ID in ascending order.
The result format is in the following example.


Answer---> 
select DISTINCT author_id as id
from Views
where author_id = viewer_id
group  by author_id; 
