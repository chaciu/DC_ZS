CREATE DATABASE test
	WITH ENCODING 'WIN1250'
		TEMPLATE=template0;
		
CREATE SCHEMA training;

CREATE TABLE test_tbl (
	id integer
);

CREATE TABLE training.test_tbl (
	id integer,
	description text
);

