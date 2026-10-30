use codeatlas;

-- 1. procedure to display all users
delimiter //

create procedure get_all_users()
begin
    select * from users;
end //

delimiter ;

-- 2. procedure to display problems by difficulty
delimiter //

create procedure get_problems_by_difficulty(in p_difficulty varchar(20))
begin
    select problem_id, problem_name, difficulty
    from problems
    where difficulty = p_difficulty;
end //

delimiter ;

-- 3. procedure to calculate user submission count
delimiter //

create procedure get_user_submissions(in p_user_id int)
begin
    select
        u.username,
        count(s.submission_id) as total_submissions
    from users u
    left join submissions s on u.user_id = s.user_id
    where u.user_id = p_user_id
    group by u.user_id, u.username;
end //

delimiter ;

-- 4. call procedures
call get_all_users();

call get_problems_by_difficulty('Hard');

call get_user_submissions(1);