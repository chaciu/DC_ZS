--- SUPERUSER STEPS
CREATE SCHEMA accountants;
CREATE TABLE accountants.test (id INTEGER);

CREATE ROLE accountant WITH LOGIN PASSWORD 'acc$1Passw0r4';

CREATE ROLE accountants_role;
GRANT CONNECT ON DATABASE postgres TO accountants_role;
GRANT USAGE, CREATE ON SCHEMA accountants TO accountants_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA accountants TO accountants_role;
GRANT accountants_role TO accountant;

REVOKE CREATE ON SCHEMA accountants FROM accountants_role;
REVOKE INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA accountants FROM accountants_role;

-- ROLE PERSPECTIVE
CREATE TABLE accountants.test2 (id integer);

CREATE TABLE accountants.test3 (id integer);

SELECT * FROM accountants.test2 t ;