USE CodeAtlas;

-- 04_seed_data.sql
-- sample data for all 12 tables
-- total records: 150
-- run this file after 01_create_table.sql and 02_constraints.sql
-- this file assumes the tables are empty and their auto_increment ids start from 1.

-- 1. users: 10 records
insert into users (user_id, username, email) values
(1, 'tourist', 'tourist@example.com'),
(2, 'aditiie', 'aditi@example.com'),
(3, 'Dominater069', 'Dominater069@example.com'),
(4, 'Teja-Smart', 'teja@example.com'),
(5, 'kal013', 'kalp@example.com'),
(6, 'fatespeaker', 'fatespeaker@example.com'),
(7, 'cry', 'cry@example.com'),
(8, 'envariant', 'edward@example.com'),
(9, 'tsunk', 'tanish@example.com'),
(10, 'Mukundan314', 'mukundan@example.com');

-- 2. platforms: 3 records
insert into platforms (platform_id, platform_name, website) values
(1, 'Codeforces', 'https://codeforces.com'),
(2, 'AtCoder', 'https://atcoder.jp'),
(3, 'LeetCode', 'https://leetcode.com');

-- 3. platform_accounts: 20 records
insert into platform_accounts (account_id, user_id, platform_id, handle, current_rating) values
(1, 1, 1, 'tourist', 3382),
(2, 1, 2, 'tourist_at', 2100),
(3, 2, 1, 'aditiie', 0),
(4, 2, 2, 'aditiie_at', 810),
(5, 3, 1, 'Dominater069', 3083),
(6, 3, 2, 'Dominater069_at', 1950),
(7, 4, 1, 'Teja-Smart', 1690),
(8, 4, 2, 'Teja-Smart_at', 1050),
(9, 5, 1, 'kal013', 2753),
(10, 5, 2, 'kal013_at', 1800),
(11, 6, 1, 'fatespeaker', 1755),
(12, 6, 2, 'fatespeaker_at', 980),
(13, 7, 1, 'cry', 2301),
(14, 7, 2, 'cry_at', 1650),
(15, 8, 1, 'envariant', 1926),
(16, 8, 2, 'envariant_at', 1250),
(17, 9, 1, 'tsunk', 1996),
(18, 9, 2, 'tsunk_at', 1400),
(19, 10, 1, 'Mukundan314', 1862),
(20, 10, 2, 'Mukundan314_at', 1150);

-- 4. problems: 20 records
insert into problems (problem_id, platform_id, problem_code, problem_name, difficulty, problem_url) values
(1, 1, 'A100', 'Watermelon', 'Easy', 'https://codeforces.com/problemset/problem/4/A'),
(2, 1, 'A101', 'Way Too Long Words', 'Easy', 'https://codeforces.com/problemset/problem/71/A'),
(3, 1, 'A102', 'Team', 'Easy', 'https://codeforces.com/problemset/problem/231/A'),
(4, 1, 'A103', 'Beautiful Matrix', 'Easy', 'https://codeforces.com/problemset/problem/263/A'),
(5, 1, 'B201', 'Books', 'Medium', 'https://codeforces.com/problemset'),
(6, 1, 'B202', 'Array Operations', 'Medium', 'https://codeforces.com/problemset'),
(7, 1, 'C301', 'Graph Paths', 'Hard', 'https://codeforces.com/problemset'),
(8, 2, 'ABC001A', 'Snow Depth Difference', 'Easy', 'https://atcoder.jp/contests/abc001/tasks/abc001_1'),
(9, 2, 'ABC001B', 'Visibility', 'Easy', 'https://atcoder.jp/contests/abc001/tasks/abc001_2'),
(10, 2, 'ABC086A', 'Product', 'Easy', 'https://atcoder.jp/contests/abc086/tasks/abc086_a'),
(11, 2, 'ABC081B', 'Shift Only', 'Medium', 'https://atcoder.jp/contests/abc081/tasks/abc081_b'),
(12, 2, 'ABC085C', 'Otoshidama', 'Medium', 'https://atcoder.jp/contests/abc085/tasks/abc085_c'),
(13, 2, 'ABC183C', 'Travel', 'Hard', 'https://atcoder.jp/contests/abc183/tasks/abc183_c'),
(14, 2, 'ABC200D', 'Happy Birthday!', 'Hard', 'https://atcoder.jp/contests/abc200/tasks/abc200_d'),
(15, 3, 'LC001', 'Two Sum', 'Easy', 'https://leetcode.com/problems/two-sum/'),
(16, 3, 'LC002', 'Add Two Numbers', 'Medium', 'https://leetcode.com/problems/add-two-numbers/'),
(17, 3, 'LC003', 'Longest Substring Without Repeating Characters', 'Medium', 'https://leetcode.com/problems/longest-substring-without-repeating-characters/'),
(18, 3, 'LC004', 'Median of Two Sorted Arrays', 'Hard', 'https://leetcode.com/problems/median-of-two-sorted-arrays/'),
(19, 3, 'LC020', 'Valid Parentheses', 'Easy', 'https://leetcode.com/problems/valid-parentheses/'),
(20, 3, 'LC021', 'Merge Two Sorted Lists', 'Easy', 'https://leetcode.com/problems/merge-two-sorted-lists/');

-- 5. tag: 8 records
insert into tag (tag_id, tag_name) values
(1, 'arrays'),
(2, 'strings'),
(3, 'math'),
(4, 'sorting'),
(5, 'binary search'),
(6, 'graphs'),
(7, 'dynamic programming'),
(8, 'greedy');

-- 6. problem_tag: 20 records
insert into problem_tag (problem_id, tag_id) values
(1, 3),
(2, 2),
(3, 8),
(4, 3),
(5, 1),
(6, 4),
(7, 6),
(8, 3),
(9, 3),
(10, 3),
(11, 1),
(12, 3),
(13, 6),
(14, 7),
(15, 1),
(16, 2),
(17, 2),
(18, 5),
(19, 2),
(20, 1);

-- 7. contests: 4 records
insert into contests (contest_id, platform_id, contest_name, start_time, duration_minutes, contest_url) values
(1, 1, 'Codeforces Round 950', '2026-01-10 17:35:00', 120, 'https://codeforces.com/contests'),
(2, 1, 'Codeforces Round 951', '2026-02-12 17:35:00', 120, 'https://codeforces.com/contests'),
(3, 2, 'AtCoder Beginner Contest 390', '2026-03-01 17:00:00', 100, 'https://atcoder.jp/contests/'),
(4, 3, 'LeetCode Weekly Contest 440', '2026-03-08 08:00:00', 90, 'https://leetcode.com/contest/');

-- 8. contest_problem: 8 records
insert into contest_problem (contest_id, problem_id, points) values
(1, 1, 500.00),
(1, 5, 1000.00),
(2, 2, 500.00),
(2, 7, 1500.00),
(3, 8, 100.00),
(3, 11, 300.00),
(4, 15, 300.00),
(4, 18, 1000.00);

-- 9. contest_participation: 8 records
insert into contest_participation (contest_id, user_id, rank_position, score) values
(1, 1, 1250, 750.00),
(1, 2, 420, 1200.00),
(1, 3, 1800, 500.00),
(2, 4, 310, 1500.00),
(2, 5, 2100, 350.00),
(3, 6, 85, 700.00),
(3, 7, 420, 450.00),
(4, 8, 190, 900.00);

-- 10. languages: 4 records
insert into languages (language_id, language_name) values
(1, 'C++17'),
(2, 'C++20'),
(3, 'Python 3'),
(4, 'Java');

-- 11. verdicts: 5 records
insert into verdicts (verdict_id, verdict_name) values
(1, 'Accepted'),
(2, 'Wrong Answer'),
(3, 'Time Limit Exceeded'),
(4, 'Runtime Error'),
(5, 'Compilation Error');

-- 12. submissions: 40 records
insert into submissions
(submission_id, user_id, problem_id, language_id, verdict_id, contest_id, submitted_at, execution_time_ms, memory_used_kb)
values
(1, 1, 1, 1, 1, 1, '2026-01-10 18:00:00', 45, 1024),
(2, 1, 2, 1, 1, 1, '2026-01-10 18:15:00', 38, 980),
(3, 1, 15, 2, 2, null, '2026-01-12 10:00:00', 52, 2048),
(4, 1, 15, 2, 1, null, '2026-01-12 10:08:00', 41, 2048),
(5, 2, 1, 1, 1, 1, '2026-01-10 18:02:00', 39, 1024),
(6, 2, 5, 3, 2, 1, '2026-01-10 18:30:00', 110, 4096),
(7, 2, 5, 1, 1, 1, '2026-01-10 18:42:00', 67, 3072),
(8, 2, 16, 4, 1, null, '2026-01-15 12:00:00', 85, 4096),
(9, 3, 3, 3, 1, null, '2026-01-18 09:00:00', 95, 2048),
(10, 3, 4, 3, 3, null, '2026-01-18 09:20:00', 1000, 4096),
(11, 3, 4, 1, 1, null, '2026-01-18 09:35:00', 55, 2048),
(12, 3, 17, 2, 2, null, '2026-01-20 11:00:00', 120, 8192),
(13, 4, 7, 1, 1, 2, '2026-02-12 18:00:00', 210, 8192),
(14, 4, 6, 1, 1, 2, '2026-02-12 18:20:00', 130, 4096),
(15, 4, 18, 2, 3, null, '2026-02-14 14:00:00', 2000, 8192),
(16, 4, 18, 2, 1, null, '2026-02-14 14:30:00', 180, 8192),
(17, 5, 2, 3, 1, null, '2026-02-16 10:00:00', 75, 2048),
(18, 5, 19, 3, 1, null, '2026-02-16 10:15:00', 60, 2048),
(19, 5, 20, 1, 2, null, '2026-02-17 11:00:00', 90, 3072),
(20, 5, 20, 1, 1, null, '2026-02-17 11:10:00', 48, 3072),
(21, 6, 8, 1, 1, 3, '2026-03-01 17:10:00', 35, 1024),
(22, 6, 11, 1, 1, 3, '2026-03-01 17:25:00', 70, 2048),
(23, 6, 12, 3, 2, null, '2026-03-03 13:00:00', 150, 4096),
(24, 6, 12, 1, 1, null, '2026-03-03 13:20:00', 90, 3072),
(25, 7, 9, 3, 1, null, '2026-03-05 09:00:00', 65, 2048),
(26, 7, 13, 2, 4, null, '2026-03-06 09:30:00', 300, 6144),
(27, 7, 13, 2, 1, null, '2026-03-06 10:00:00', 190, 6144),
(28, 8, 15, 1, 1, 4, '2026-03-08 08:10:00', 42, 2048),
(29, 8, 18, 1, 2, 4, '2026-03-08 08:30:00', 250, 8192),
(30, 8, 18, 1, 1, 4, '2026-03-08 08:45:00', 175, 8192),
(31, 8, 16, 4, 1, null, '2026-03-10 15:00:00', 95, 4096),
(32, 9, 10, 3, 1, null, '2026-03-12 10:00:00', 55, 2048),
(33, 9, 14, 2, 3, null, '2026-03-13 10:00:00', 2000, 8192),
(34, 9, 14, 2, 2, null, '2026-03-13 10:30:00', 800, 8192),
(35, 9, 14, 2, 1, null, '2026-03-13 11:00:00', 350, 8192),
(36, 10, 7, 1, 1, null, '2026-03-15 16:00:00', 160, 8192),
(37, 10, 17, 1, 1, null, '2026-03-16 16:00:00', 110, 6144),
(38, 10, 18, 1, 1, null, '2026-03-17 16:00:00', 145, 8192),
(39, 10, 19, 1, 1, null, '2026-03-18 16:00:00', 40, 2048),
(40, 10, 20, 1, 1, null, '2026-03-19 16:00:00', 44, 2048);

-- verify total records across all 12 tables
select
(select count(*) from users) +
(select count(*) from platforms) +
(select count(*) from platform_accounts) +
(select count(*) from problems) +
(select count(*) from tag) +
(select count(*) from problem_tag) +
(select count(*) from contests) +
(select count(*) from contest_problem) +
(select count(*) from contest_participation) +
(select count(*) from languages) +
(select count(*) from verdicts) +
(select count(*) from submissions) as total_records;

-- verify final
select 'users' as table_name, count(*) as total from users
union all
select 'platforms', count(*) from platforms
union all
select 'platform_accounts', count(*) from platform_accounts
union all
select 'problems', count(*) from problems
union all
select 'tag', count(*) from tag
union all
select 'problem_tag', count(*) from problem_tag
union all
select 'contests', count(*) from contests
union all
select 'contest_problem', count(*) from contest_problem
union all
select 'contest_participation', count(*) from contest_participation
union all
select 'languages', count(*) from languages
union all
select 'verdicts', count(*) from verdicts
union all
select 'submissions', count(*) from submissions;