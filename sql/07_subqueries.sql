use codeatlas;

-- 1. single row subquery: problems with hard difficulty
select problem_name, difficulty
from problems
where difficulty = (
    select max(difficulty)
    from problems
);

-- 2. multi row subquery: users who have made submissions
select username
from users
where user_id in (
    select user_id
    from submissions
);

-- 3. correlated subquery: users with more submissions than average
select u.username, count(s.submission_id) as total_submissions
from users u
join submissions s on u.user_id = s.user_id
group by u.user_id, u.username
having count(s.submission_id) > (
    select avg(user_submissions)
    from (
        select count(*) as user_submissions
        from submissions
        group by user_id
    ) as submission_counts
);

-- 4. exists: users who have at least one submission
select u.username
from users u
where exists (
    select 1
    from submissions s
    where s.user_id = u.user_id
);

-- 5. not exists: users who have no submissions
select u.username
from users u
where not exists (
    select 1
    from submissions s
    where s.user_id = u.user_id
);

-- 6. subquery with max: highest rated platform account
select handle, current_rating
from platform_accounts
where current_rating = (
    select max(current_rating)
    from platform_accounts
);