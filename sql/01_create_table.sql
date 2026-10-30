CREATE DATABASE CodeAtlas;
USE CodeAtlas;
SELECT DATABASE();

 -- 1. store CodeAtlas users
 CREATE TABLE users (
 user_id int auto_increment primary key,  -- 'auto_increment' automatically generates the next number whenever you insert a new row.
 username varchar(50) not null unique,
 email varchar(100) not null unique,
 created_at timestamp default current_timestamp
 );
 
 -- 2. stores coding platforms
 CREATE TABLE platforms (
 platform_id int auto_increment primary key,
 platform_name varchar(50) not null unique,
 website varchar(200) not null unique
 );
 
 -- 3. links users to their platform accounts 
 create table platform_accounts (
 account_id int auto_increment primary key,
 user_id int not null,
 platform_id int not null,
 handle varchar(100) not null,
 current_rating int default 0,
 
 foreign key (user_id) references users(user_id),
 foreign key (platform_id) references platforms(platform_id),
 unique(platform_id, handle), -- to prevent duplicate platform accounts in CodeAtlas
 unique(user_id, platform_id) -- composite unique constraint
 );
 -- display all tables 
 SHOW TABLES;
 -- 4. store coding problems
 create table problems (
 problem_id int auto_increment primary key,
 platform_id int not null,
 problem_code varchar(50) not null,
 problem_name varchar(200) not null,
 difficulty varchar(20),
 problem_url varchar(200),
 foreign key (platform_id) references platforms(platform_id),
 unique(platform_id,problem_code)
 );
 
 -- 5. store problem topics
 create table tag (
 tag_id int auto_increment primary key,
 tag_name varchar(50) not null unique
 );
 
-- 6. connect problems with topics
-- many-to-many relationship using a composite primary key.

 create table problem_tag (
 problem_id int,
 tag_id int,
 primary key (problem_id, tag_id), -- composite primary key
 foreign key (problem_id) references problems(problem_id) on delete cascade, -- foreign key with cascade delete
 foreign key (tag_id) references tag(tag_id) on delete cascade
 );
 
 SHOW TABLES;
 
 -- 7. sotre contests
 create table contests (
 contest_id int auto_increment primary key,
 platform_id int not null,
 contest_name varchar(150) not null,
 start_time datetime,
 duration_minutes INT
 contest_url varchar(300),
 foreign key (platform_id) references platforms(platform_id)
 );
 
-- 8. connect contest with problem
-- many-to-many relationship using a composite primary key.

 create table contest_problem (
 contest_id int,
 problem_id int,
 points decimal(6,2),
 primary key(contest_id, problem_id), -- composite primary key
 foreign key (contest_id) references contests(contest_id) on delete cascade, -- foreign key with cascade delete
 foreign key (problem_id) references problems(problem_id) on delete cascade
 );
 
 -- 9. store contest particiaption (relationship between users and contests)
 create table contest_participation (
 contest_id int,
 user_id int,
 rank_position int,
 score decimal(8,2),
 primary key (contest_id, user_id),
 foreign key (contest_id) references contests(contest_id),
 foreign key (user_id) references  users(user_id)
 );
 
 -- 10. store programming language 
 create table languages (
 language_id int auto_increment primary key,
 language_name varchar(100) not null unique
 );
 
 -- 11. store submission verdict
 create table verdicts (
 verdict_id int auto_increment primary key,
 verdict_name varchar(100) not null unique
 );
 
 -- 12. store submissions (one-to-many relationships)
 create table submissions (
 submission_id bigint auto_increment primary key,
 user_id int not null,
 problem_id int not null,
 language_id int not null, 
 verdict_id int not null,
 contest_id int,    -- submissions is nullable because a user can submit a solution outside a contest.
 submitted_at datetime default current_timestamp,
 execution_time_ms int,
 memory_used_kb int,
 foreign key (contest_id) references contests(contest_id),
 foreign key (problem_id) references problems(problem_id),
 foreign key (language_id) references languages(language_id),
 foreign key (verdict_id) references verdicts(verdict_id),
 foreign key (user_id) references users(user_id)
 );
 SHOW TABLES;
 