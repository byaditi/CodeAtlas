USE CodeAtlas;

-- check constraint: rating cannot be negative
alter table platform_accounts
add constraint chk_rating
check (current_rating >= 0);

-- check constraint: difficulty must be valid
alter table problems
add constraint chk_difficulty
check (difficulty in ('Easy', 'Medium', 'Hard'));

-- check constraint: execution time cannot be negative
alter table submissions
add constraint chk_execution_time
check (execution_time_ms is null or execution_time_ms >= 0);

-- check constraint: memory cannot be negative
alter table submissions
add constraint chk_memory
check (memory_used_kb is null or memory_used_kb >= 0);