CREATE TABLE sales (
	id integer NOT NULL,
	description TEXT unique
);


INSERT INTO sales VALUES (1,'abc');
INSERT INTO sales VALUES (2,NULL);
INSERT INTO sales VALUES (3,NULL);
INSERT INTO sales VALUES (4,'abc');

CREATE TABLE products (
	id integer NOT NULL,
	product_short_code varchar(10),
	product_no varchar(5),
	UNIQUE(product_short_code, product_no)
);