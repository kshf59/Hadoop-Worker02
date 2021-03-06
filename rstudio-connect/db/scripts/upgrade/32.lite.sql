CREATE TABLE temp_passwords (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  password TEXT NOT NULL DEFAULT '',
  expires DATETIME NOT NULL);

INSERT INTO temp_passwords (user_id, password, expires)
SELECT
  id,
  temp_password,
  DATE('now', '+1 month')
FROM users WHERE temp_password != "";

-- Remove the temp_password col from users

CREATE TABLE users_replacement (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   principal_id INTEGER NOT NULL,
   provider_key TEXT,
   username TEXT,
   email TEXT,
   password TEXT,
   first_name TEXT,
   last_name TEXT,
   user_role TEXT,
   password_expire DATETIME,
   created_time DATETIME,
   updated_time DATETIME,
   confirmed BOOLEAN NOT NULL DEFAULT FALSE);

INSERT INTO users_replacement
SELECT
  id,
  principal_id,
  provider_key,
  username,
  email,
  password,
  first_name,
  last_name,
  user_role,
  password_expire,
  created_time,
  updated_time,
  confirmed
FROM users;

DROP TABLE users;

ALTER TABLE users_replacement RENAME TO users;
