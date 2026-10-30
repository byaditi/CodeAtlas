USE CodeAtlas;

-- add a new column
alter table users
add column country varchar(50) default 'India';

-- modify an existing column
alter table users
modify username varchar(100) not null;

-- rename a column
alter table users
rename column country to user_country;