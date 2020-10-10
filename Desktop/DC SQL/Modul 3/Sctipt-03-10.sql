CREATE TABLE products (
    id INTEGER,
    PRIMARY KEY (id)
);

CREATE TABLE sales (
    id integer PRIMARY KEY,
    product_id integer REFERENCES products
);

CREATE TABLE sales_2019 (
    id integer PRIMARY KEY,
    product_id integer,
    FOREIGN KEY (product_id) REFERENCES products (id)
);

CREATE TABLE sales_2020 (
	id integer,
	product_id integer
);

ALTER TABLE sales_2020 ADD CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE sales_2020 ADD FOREIGN KEY (product_id) REFERENCES products (id);

ALTER TABLE sales_2020 DROP CONSTRAINT fk_products;

-- usuwanie rekordów

CREATE TABLE sales_2021 (
	id integer PRIMARY KEY,
	product_id integer REFERENCES products ON DELETE CASCADE
);

INSERT INTO sales_2020 VALUES (1, NULL);

INSERT INTO products VALUES (1),(2),(3);

INSERT INTO sales_2021 VALUES (1, 1);
INSERT INTO sales_2021 VALUES (2, 1);
