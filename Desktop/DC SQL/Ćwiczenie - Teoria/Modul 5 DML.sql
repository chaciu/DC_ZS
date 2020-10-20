-- 1. Utwórz nowy schemat dml_exercises

CREATE SCHEMA IF NOT EXISTS dml_exercises;


-- 2. Utwórz nową tabelę sales w schemacie dml_exercises według opisu:
-- Tabela: sales;
-- Kolumny:
--  id - typ SERIAL, klucz główny,
--  sales_date - typ data i czas (data + część godziny, minuty, sekundy), to pole ma nie
-- zawierać wartości nieokreślonych NULL,
--  sales_amount - typ zmiennoprzecinkowy (NUMERIC 38 znaków, do 2 znaków po
-- przecinku)
--  sales_qty - typ zmiennoprzecinkowy (NUMERIC 10 znaków, do 2 znaków po przecinku)
--  added_by - typ tekstowy (nielimitowana ilość znaków), z wartością domyślną 'admin'
--  korzystając z definiowania przy tworzeniu tabeli, po definicji kolumn, dodaje
-- ograniczenie o nazwie sales_less_1k na polu sales_amount typu CHECK takie, że
-- wartości w polu sales_amount muszą być mniejsze lub równe 1000

DROP TABLE IF EXISTS dml_exercises.sales;

CREATE TABLE dml_exercises.sales (
    id serial PRIMARY KEY,
    sales_date timestamp NOT NULL,
    sales_amount numeric(32, 2),
    sales_qty numeric (10, 2),
    added_by text DEFAULT 'admin',
    CONSTRAINT sales_less_1k CHECK ( sales_amount <= 1000 )
);


-- 3. Dodaj to tabeli kilka wierszy korzystając ze składni INSERT INTO
-- 3.1 Tak, aby id było generowane przez sekwencję
-- 3.2 Tak by pod pole added_by wpisać wartość nieokreśloną NULL
-- 3.3 Tak, aby sprawdzić zachowanie ograniczenia sales_less_1k, gdy wpiszemy wartości większe
-- od 1000

INSERT INTO dml_exercises.sales (sales_date, sales_amount, sales_qty, added_by)
    VALUES ('2020-04-10 10:11:00', 300, 4, NULL);

INSERT INTO dml_exercises.sales (sales_date, sales_amount, sales_qty, added_by)
    VALUES ('2020-04-10 10:12:00', 4000, 2, NULL);

INSERT INTO dml_exercises.sales (sales_date, sales_amount, sales_qty)
    VALUES ('2020-04-10 10:13:00', 300, 4);


-- 4. Co zostanie wstawione, jako format godzina (HH), minuta (MM), sekunda (SS), w polu
-- sales_date, jak wstawimy do tabeli następujący rekord.
-- INSERT INTO dml_exercises.sales (sales_date, sales_amount,sales_qty, added_by)
--  VALUES ('20/11/2019', 101, 50, NULL);

INSERT INTO dml_exercises.sales (sales_date, sales_amount,sales_qty, added_by)
 VALUES ('20/11/2019', 101, 50, NULL);

-- ODP:
-- [22008] ERROR: date/time field value out of range: "20/11/2019"
-- Wskazówka: Perhaps you need a different "datestyle" setting.
-- Ja korzystam z innego datestyle, ale jak dodajemy datę w formacie date
-- do timestamt, to jest to początek dnia np. (2020-11-20 00:00:00) :)


-- 5. Jaka będzie wartość w atrybucie sales_date, po wstawieniu wiersza jak poniżej. Jak
-- zintepretujesz miesiąc i dzień, żeby mieć pewność, o jaki konkretnie chodzi.

INSERT INTO dml_exercises.sales (sales_date, sales_amount,sales_qty, added_by)
 VALUES ('04/04/2020', 101, 50, NULL);

SHOW DATESTYLE;
--ISO, MDY

-- 6. Dodaj do tabeli sales wstaw wiersze korzystając z poniższego polecenia
INSERT INTO dml_exercises.sales (sales_date, sales_amount, sales_qty,added_by)
 SELECT NOW() + (random() * (interval '90 days')) + '30 days',
 random() * 500 + 1,
 random() * 100 + 1,
 NULL
 FROM generate_series(1, 20000) s(i);


-- 7. Korzystając ze składni UPDATE, zaktualizuj atrybut added_by, wpisując mu wartość
-- 'sales_over_200', gdy wartość sprzedaży (sales_amount jest większa lub równa 200)

UPDATE dml_exercises.sales SET added_by = 'sales_over_200'
    WHERE sales_amount >= 200;


-- 8. Korzystając ze składni DELETE, usuń te wiersze z tabeli sales, dla których wartość w polu
-- added_by jest wartością nieokreśloną NULL. Sprawdź różnicę między zapisemm added_by =
-- NULL, a added_by IS NULL

DELETE FROM dml_exercises.sales
    WHERE added_by = NULL;

DELETE FROM dml_exercises.sales
    WHERE added_by IS NULL;

-- Drugie polecenie zadziałało

-- 9. Wyczyść wszystkie dane z tabeli sales i zrestartuj sekwencje

TRUNCATE TABLE dml_exercises.sales RESTART IDENTITY;


-- 10. DODATKOWE ponownie wstaw do tabeli sales wiersze jak w zadaniu 4.
-- Utwórz kopię zapasową tabeli do pliku. Następnie usuń tabelę ze schematu dml_exercises i
-- odtwórz ją z kopii zapasowej.

-- INFO: korzystam z Mac OS, dlatego komendy różnią się trochę od przykładów :)

-- ./pg_dump --username postgres\
--         --host localhost\
--         --port 5432\
--         --format d\
--         --file "/Users/chaciu/Desktop/db_postgres_dump"\
--         --table dml_exercises.sales\
--         postgres

SELECT count(*)
FROM dml_exercises.sales;

-- ./pg_restore --username postgres\
--         --host localhost\
--         --port 5432\
--         --dbname postgres\
--         --clean\
--         "/Users/chaciu/Desktop/db_postgres_dump"

SELECT count(*)
FROM dml_exercises.sales;