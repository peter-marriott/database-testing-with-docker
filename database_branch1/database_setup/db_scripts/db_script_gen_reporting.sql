DO LANGUAGE plpgsql $$
    BEGIN
        IF (select current_database()) not like '%prod%' THEN
          drop schema if exists reporting cascade;
          create schema reporting AUTHORIZATION "app_owner";
        ELSE
          RAISE EXCEPTION 'Wrong database';
        END IF;
    END;
$$;

SET search_path = reporting;

DROP TABLE IF EXISTS customer;

CREATE TABLE customer (
  customerid serial not null primary key,
  customerreference varchar(15) not null,
  createdat timestamp not null default current_timestamp,
  surname varchar(50) null,
  initials varchar(50) null,
  firstname varchar(50) null,
  title varchar(10) null,
  postcode1 varchar(4) null,
  postcode2 varchar(3) null,
  dob timestamp null,
  sex varchar(1) null,
  email varchar(50) null,
  passwd varchar(50) null)
;

SET search_path = reporting;

GRANT ALL ON SCHEMA reporting TO app_read_write;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA reporting TO app_read_write;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA reporting TO app_read_write;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA reporting TO app_read_write;
ALTER DEFAULT PRIVILEGES IN SCHEMA reporting GRANT ALL ON TABLES TO app_read_write;
ALTER DEFAULT PRIVILEGES IN SCHEMA reporting GRANT ALL ON SEQUENCES TO app_read_write;
ALTER DEFAULT PRIVILEGES IN SCHEMA reporting GRANT ALL ON FUNCTIONS TO app_read_write;

GRANT USAGE ON SCHEMA reporting TO app_read;
GRANT SELECT ON ALL TABLES IN SCHEMA reporting TO app_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA reporting GRANT SELECT ON TABLES TO app_read;

GRANT USAGE ON SCHEMA reporting TO app_write;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA reporting TO app_write;
ALTER DEFAULT PRIVILEGES IN SCHEMA reporting GRANT INSERT, UPDATE, DELETE ON TABLES TO app_write;

