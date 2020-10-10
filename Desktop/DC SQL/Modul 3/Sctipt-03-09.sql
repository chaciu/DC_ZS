CREATE TABLE products (
	id integer,
	PRIMARY KEY (id)
);


CREATE TABLE sales (
	id integer PRIMARY KEY
);

CREATE TABLE customers (
	id integer,
	name TEXT
);

INSERT INTO customers VALUES 
(NULL, 'Customer 1'),
(1, 'Customer 2');

SELECT * FROM customers;

ALTER TABLE customers ADD CONSTRAINT pk_customers PRIMARY KEY (id);
ALTER TABLE ADD PRIMARY KEY (id);

ALTER TABLE customers DROP CONSTRAINT pk_customers;