use codeatlas;

-- 1. verify all tables
show tables;

-- 2. verify views
show full tables
where table_type = 'VIEW';

-- 3. verify stored procedures
show procedure status
where db = 'codeatlas';

-- 4. verify triggers
show triggers;

-- 5. verify indexes
show index from problems;
show index from submissions;

-- 6. verify audit records
select * from submission_audit;