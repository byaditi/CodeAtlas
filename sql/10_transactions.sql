-- TCL (Transaction Control Language)

use codeatlas;

-- 1. start a transaction
start transaction;

-- 2. update platform rating
update platform_accounts
set current_rating = current_rating + 10
where account_id = 1;

-- 3. create a savepoint
savepoint sp1;

-- 4. make another update
update platform_accounts
set current_rating = current_rating + 20
where account_id = 1;

-- 5. rollback to savepoint
rollback to sp1;

-- 6. commit transaction
commit;

-- 7. verify committed changes
select handle, current_rating
from platform_accounts
where account_id = 1;

-- 8. start another transaction
start transaction;

-- 9. insert a temporary tag
insert into tag (tag_name)
values ('transaction_demo');

-- 10. rollback the transaction
rollback;

-- 11. verify rollback
select * from tag
where tag_name = 'transaction_demo';