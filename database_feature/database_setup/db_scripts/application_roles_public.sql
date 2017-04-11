
SET search_path = public;

CREATE ROLE "app_read_role" VALID UNTIL 'infinity';
CREATE ROLE "app_read_write_role" VALID UNTIL 'infinity';
CREATE ROLE "app_write_role" VALID UNTIL 'infinity';

CREATE ROLE "app_read" LOGIN PASSWORD 'readerpwd' VALID UNTIL 'infinity';
GRANT "app_read_role" TO "app_read";

CREATE ROLE "app_read_write" LOGIN PASSWORD 'readwritepwd' VALID UNTIL 'infinity';
GRANT "app_read_write_role" TO "app_read_write";

CREATE ROLE "app_write" LOGIN PASSWORD 'writepwd' VALID UNTIL 'infinity';
GRANT "app_write_role" TO "app_write";
