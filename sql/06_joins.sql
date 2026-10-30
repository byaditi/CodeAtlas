use codeatlas;

-- 1. inner join: users and their platform accounts
select u.username, pa.handle, pa.current_rating
from users u
inner join platform_accounts pa
on u.user_id = pa.user_id;

-- 2. left join: all users and their submissions
select u.username, s.submission_id, s.submitted_at
from users u
left join submissions s
on u.user_id = s.user_id;

-- 3. right join: all platforms and their problems
select pl.platform_name, p.problem_name
from problems p
right join platforms pl
on p.platform_id = pl.platform_id;

-- 4. natural join: platforms and problems
select platform_name, problem_name, difficulty
from platforms
natural join problems;