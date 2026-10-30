use codeatlas;

-- 1. insert a new user
insert into users (username, email)
values ('maspy', 'maspy@example.com');

-- 2. retrieve user information
select * from users;

-- 3. update user information
update users
set username = 'maspy_solved_all'
where username = 'maspy';

-- 4. retrieve updated user
select * from users
where username = 'maspy_solved_all';

-- 5. delete a user
delete from users
where username = 'maspy_solved_all';

-- 6. verify deletion
select * from users
where username = 'maspy_solved_all';