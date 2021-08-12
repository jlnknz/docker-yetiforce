-- do not allow connecting with root from somehere else than localhost
-- FIXME - check other permissions, e.g., can the `yeti` user connect from outside of our deployment network?
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
FLUSH PRIVILEGES;
