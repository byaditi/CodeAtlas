use codeatlas;

-- this demonstrates before insert, after insert, and before update triggers.
-- 1. create submission audit table
create table if not exists submission_audit (
    audit_id int auto_increment primary key,
    submission_id bigint,
    action_type varchar(20),
    action_time timestamp default current_timestamp
);

-- 2. before insert trigger: validate execution time
delimiter //

create trigger before_submission_insert
before insert on submissions
for each row
begin
    if new.execution_time_ms < 0 then
        signal sqlstate '45000'
        set message_text = 'execution time cannot be negative';
    end if;
end //

delimiter ;

-- 3. after insert trigger: record new submission
delimiter //

create trigger after_submission_insert
after insert on submissions
for each row
begin
    insert into submission_audit (submission_id, action_type)
    values (new.submission_id, 'insert');
end //

delimiter ;

-- 4. before update trigger: validate rating
delimiter //

create trigger before_rating_update
before update on platform_accounts
for each row
begin
    if new.current_rating < 0 then
        signal sqlstate '45000'
        set message_text = 'rating cannot be negative';
    end if;
end //

delimiter ;

-- 5. verify triggers
show triggers;

-- 6. test after insert trigger
insert into submissions
(user_id, problem_id, language_id, verdict_id, contest_id, execution_time_ms, memory_used_kb)
values (1, 1, 1, 1, null, 50, 1024);

-- 7. verify audit entry
select * from submission_audit;

-- 8. test before update trigger
update platform_accounts
set current_rating = -10
where account_id = 1;