use codeatlas;

-- 1. create index on problem name
create index idx_problem_name
on problems(problem_name);

-- 2. create index on submission user id
create index idx_submission_user
on submissions(user_id);

-- 3. create composite index on submission user and date
create index idx_submission_user_date
on submissions(user_id, submitted_at);

-- 4. display indexes on problems
show indexes from problems;

-- 5. display indexes on submissions
show indexes from submissions;