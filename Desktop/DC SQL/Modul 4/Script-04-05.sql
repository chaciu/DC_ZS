--- SUPERUSER STEPS
CREATE ROLE accountant WITH LOGIN PASSWORD ''acc$1Passw0r4'';

GRANT ALL PRIVILEGES ON DATABASE postgres TO accountant;

DROP ROLE accountant;

REASSIGN OWNED BY accountant TO postgres;
DROP OWNED BY accountant;
DROP ROLE accountant;

CREATE ROLE accountant WITH LOGIN PASSWORD ''acc$1Passw0r4'';
REVOKE ALL PRIVILEGES ON SCHEMA public FROM PUBLIC;

CREATE ROLE readonly_accountants;
GRANT CONNECT ON DATABASE postgres TO readonly_accountants;

CREATE SCHEMA accountants;
CREATE TABLE accountants.test
(
    id INTEGER
);

GRANT USAGE ON SCHEMA accountants TO readonly_accountants;
GRANT SELECT ON TABLE accountants.test TO readonly_accountants;

GRANT readonly_accountants TO accountant;


-- ACCOUNTANT STEPS
CREATE TABLE test_accountant
(
    id INTEGER
);
CREATE SCHEMA accountant;

SELECT *
FROM accountants.test t;
