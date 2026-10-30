
-- 1. platform-wise problem count (left join, count, group by)
select p.platform_name, count(pr.problem_id) as total_problems
from platforms p
left join problems pr on p.platform_id = pr.platform_id
group by p.platform_id, p.platform_name;

-- 2. submission verdict distribution (left join, count, group by)
select v.verdict_name, count(s.submission_id) as total_submissions
from verdicts v
left join submissions s on v.verdict_id = s.verdict_id
group by v.verdict_id, v.verdict_name;

-- 3. user submission activity (left join, count, group by, order by)
select u.username, count(s.submission_id) as total_submissions
from users u
left join submissions s on u.user_id = s.user_id
group by u.user_id, u.username
order by total_submissions desc;

-- 4. most attempted problems (left join, count, group by, order by, limit)
select p.problem_name, count(s.submission_id) as attempts
from problems p
left join submissions s on p.problem_id = s.problem_id
group by p.problem_id, p.problem_name
order by attempts desc
limit 10; -- will show only top 10 rows

-- 5. platform acceptance rates (left join, count, case, sum, round, group by)
-- warning: acceptance rate may return null if a platform has no submissions.
select
pl.platform_name,
count(s.submission_id) as total_submissions,
sum(case when v.verdict_name = 'Accepted' then 1 else 0 end) as accepted,
round(
sum(case when v.verdict_name = 'Accepted' then 1 else 0 end)
* 100.0 / count(s.submission_id), 2
) as acceptance_rate
from platforms pl
left join problems p on pl.platform_id = p.platform_id
left join submissions s on p.problem_id = s.problem_id
left join verdicts v on s.verdict_id = v.verdict_id
group by pl.platform_id, pl.platform_name;

-- 6. programming language usage (left join, count, group by, order by)
select l.language_name, count(s.submission_id) as total_submissions
from languages l
left join submissions s on l.language_id = s.language_id
group by l.language_id, l.language_name
order by total_submissions desc;

-- 7. contest participation summary (left join, count, avg, max, group by)
select c.contest_name,
count(cp.user_id) as total_participants,
avg(cp.score) as average_score,
max(cp.score) as highest_score
from contests c
left join contest_participation cp on c.contest_id = cp.contest_id
group by c.contest_id, c.contest_name;

-- 8. problems by difficulty (count, group by, order by)
select difficulty, count(problem_id) as total_problems
from problems
group by difficulty
order by total_problems desc;

-- 9. topic-wise problem counts (left join, count, group by, order by)
select t.tag_name, count(pt.problem_id) as total_problems
from tag t
left join problem_tag pt on t.tag_id = pt.tag_id
group by t.tag_id, t.tag_name
order by total_problems desc;

-- 10. active users (inner join, count, group by, having, order by)
-- users with at least 5 submissions are considered active.
select u.username, count(s.submission_id) as total_submissions
from users u
inner join submissions s on u.user_id = s.user_id
group by u.user_id, u.username
having count(s.submission_id) >= 5
order by total_submissions desc;
