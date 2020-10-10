CREATE TABLE sales (
	id integer NOT NULL,
	sales NUMERIC CHECK (sales > 1000)
);

ALTER TABLE sales ALTER COLUMN id DROP NOT NULL;


CREATE TABLE sales2 (
	id integer,
	sales NUMERIC CONSTRAINT sales_not_null CHECK (sales IS NOT NULL)
);