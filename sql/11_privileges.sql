use codeatlas;
-- Create a test user
-- 1. create a database user
create user if not exists 'codeatlas_user'@'localhost'
identified by 'CodeAtlas@123';

-- 2. grant select privilege
grant select on codeatlas.* to 'codeatlas_user'@'localhost';

-- 3. grant insert privilege
grant insert on codeatlas.* to 'codeatlas_user'@'localhost';

-- 4. display user privileges
show grants for 'codeatlas_user'@'localhost';

-- 5. revoke insert privilege
revoke insert on codeatlas.* from 'codeatlas_user'@'localhost';

-- 6. display updated privileges
show grants for 'codeatlas_user'@'localhost';