-- 1

DROP TABLE IF EXISTS expense_tracker.bank_account_owner CASCADE;

CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_owner (
    id_ba_own serial PRIMARY KEY,
    owner_name varchar(50) NOT NULL,
    owner_desc varchar(250),
    user_login integer NOT NULL,
    active boolean DEFAULT TRUE NOT NULL,
    insert_date timestamp DEFAULT current_timestamp,
    update_date timestamp DEFAULT current_timestamp
);


---------------
DROP TABLE IF EXISTS expense_tracker.bank_account_types CASCADE;

CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_types (
    id_ba_type serial PRIMARY KEY,
    ba_type varchar(50) NOT NULL,
    ba_desc varchar(250),
    active boolean DEFAULT TRUE NOT NULL,
    is_common_account boolean DEFAULT FALSE NOT NULL,
    id_ba_own integer REFERENCES expense_tracker.bank_account_owner (id_ba_own),
    insert_date timestamp DEFAULT current_timestamp,
    update_date timestamp DEFAULT current_timestamp
);


---------------
DROP TABLE IF EXISTS expense_tracker.transaction_bank_accounts CASCADE;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_bank_accounts (
    id_trans_ba serial PRIMARY KEY,
    id_ba_own integer REFERENCES expense_tracker.bank_account_owner (id_ba_own),
    id_ba_type integer REFERENCES expense_tracker.bank_account_types (id_ba_type),
    bank_account_name varchar(50) NOT NULL,
    bank_account_desc varchar(250),
    active boolean DEFAULT TRUE NOT NULL,
    insert_date timestamp DEFAULT current_timestamp,
    update_date timestamp DEFAULT current_timestamp
);


---------------
DROP TABLE IF EXISTS expense_tracker.transaction_category CASCADE;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_category (
    id_trans_cat serial PRIMARY KEY,
    category_name varchar(50) NOT NULL,
    category_description varchar(250),
    active boolean DEFAULT TRUE NOT NULL,
    insert_date timestamp DEFAULT current_timestamp,
    update_date timestamp DEFAULT current_timestamp
);


---------------
DROP TABLE IF EXISTS expense_tracker.transaction_subcategory CASCADE;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_subcategory (
    id_trans_subcat serial PRIMARY KEY,
    id_trans_cat integer REFERENCES expense_tracker.transaction_category (id_trans_cat),
    subcategory_name varchar(50) NOT NULL,
    subcategory_description varchar(250),
    active boolean DEFAULT TRUE NOT NULL,
    insert_date timestamp DEFAULT current_timestamp,
    update_date timestamp DEFAULT current_timestamp
);


---------------
DROP TABLE IF EXISTS expense_tracker.transaction_type CASCADE;

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_type (
    id_trans_type serial PRIMARY KEY,
    transaction_type_name varchar(50) NOT NULL,
    transaction_type_desc varchar(250),
    active boolean DEFAULT TRUE NOT NULL,
    insert_date timestamp DEFAULT current_timestamp,
    update_date timestamp DEFAULT current_timestamp
);


---------------
DROP TABLE IF EXISTS expense_tracker.users CASCADE;

CREATE TABLE IF NOT EXISTS expense_tracker.users (
    id_user serial PRIMARY KEY,
    user_login varchar(25) NOT NULL,
    user_name varchar(50) NOT NULL,
    user_password varchar(100) NOT NULL,
    password_salt varchar(100) NOT NULL,
    active boolean DEFAULT TRUE NOT NULL,
    insert_date timestamp DEFAULT current_timestamp,
    update_date timestamp DEFAULT current_timestamp
);


---------------
DROP TABLE IF EXISTS expense_tracker.transactions CASCADE;

CREATE TABLE IF NOT EXISTS expense_tracker.transactions (
    id_transaction serial PRIMARY KEY,
    id_trans_ba integer REFERENCES expense_tracker.transaction_bank_accounts (id_trans_ba),
    id_trans_cat integer REFERENCES expense_tracker.transaction_category (id_trans_cat),
    id_trans_subcat integer REFERENCES expense_tracker.transaction_subcategory (id_trans_subcat),
    id_trans_type integer REFERENCES expense_tracker.transaction_type (id_trans_type),
    id_user integer REFERENCES expense_tracker.users (id_user),
    transaction_value numeric(9, 2),
    transaction_description text,
    insert_date timestamp DEFAULT current_timestamp,
    update_date timestamp DEFAULT current_timestamp
);

-- 2
INSERT INTO expense_tracker.users (user_login, user_name, user_password, password_salt, active)
    VALUES ('miccha', 'michal', 'moje_haslo', '*******', TRUE);

INSERT INTO expense_tracker.transaction_type (transaction_type_name, transaction_type_desc, active)
    VALUES ('recurring_trans', 'recurring transaction', TRUE);

INSERT INTO expense_tracker.transaction_category (category_name, category_description, active)
    VALUES ('Learning', 'Expenses for self-improvement', TRUE);

INSERT INTO expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
    VALUES (1, 'Online Courses', 'Courses on the Internet', TRUE);

INSERT INTO expense_tracker.bank_account_owner (owner_name, owner_desc, user_login, active)
    VALUES ('Michal', 'Account Owner', 666000, TRUE);

INSERT INTO expense_tracker.bank_account_types (ba_type, ba_desc, active, is_common_account, id_ba_own)
    VALUES ('Current', 'Current Account', TRUE, FALSE, 1);

INSERT INTO expense_tracker.transaction_bank_accounts (id_ba_own, id_ba_type, bank_account_name, bank_account_desc, active)
    VALUES (1, 1, 'Standard', 'Standard Current Account', TRUE);

INSERT INTO expense_tracker.transactions (id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_value, transaction_description)
    VALUES (1, 1, 1, 1, 1, 397, 'Przelew za kurs Zrozum SQL');


SELECT t.transaction_value,
       t.transaction_description,
       c.category_name,
       sc.subcategory_name,
       tt.transaction_type_desc,
       u.user_name,
       tba.bank_account_name,
       bat.ba_desc
from expense_tracker.transactions t
join expense_tracker.transaction_category c
on t.id_trans_cat = c.id_trans_cat
join expense_tracker.transaction_subcategory sc
on t.id_trans_subcat = sc.id_trans_subcat
join expense_tracker.transaction_type tt
on t.id_trans_type = tt.id_trans_type
join expense_tracker.users u
on t.id_user = u.id_user
join expense_tracker.transaction_bank_accounts tba
on t.id_trans_ba = tba.id_trans_ba
left join expense_tracker.bank_account_types bat
on tba.id_ba_type = bat.id_ba_type;

-- 3

-- ./pg_dump --username postgres\
--         --host localhost\
--         --port 5432\
--         --format plain\
--         --file "/Users/chaciu/Desktop/db_postgres_dump.sql"\
--         --database postgres\
--         postgres

-- psql -U postgres -p 5432 -h localhost -d postgres -f "/Users/chaciu/Desktop/db_postgres_dump.sql"