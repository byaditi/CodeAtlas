use codeatlas;

-- 1. create a view for problem details with platform names
create or replace view problem_platform_view as
select
p.problem_id,
p.problem_name,
p.problem_code,
p.difficulty,
pl.platform_name
from problems p
inner join platforms pl
on p.platform_id = pl.platform_id;

-- 2. display all problem details using view
select * from problem_platform_view;

-- 3. create a view for user submission statistics
create or replace view user_submission_view as
select
u.user_id,
u.username,
count(s.submission_id) as total_submissions
from users u
left join submissions s
on u.user_id = s.user_id
group by u.user_id, u.username;

-- 4. display user submission statistics
select * from user_submission_view;

-- 5. create a view for accepted submissions
create or replace view accepted_submissions_view as
select
s.submission_id,
u.username,
p.problem_name,
l.language_name,
s.submitted_at
from submissions s
inner join users u on s.user_id = u.user_id
inner join problems p on s.problem_id = p.problem_id
inner join languages l on s.language_id = l.language_id
inner join verdicts v on s.verdict_id = v.verdict_id
where v.verdict_name = 'Accepted';

-- 6. display accepted submissions
select * from accepted_submissions_view;