-- 1. Korzystając ze składni CREATE ROLE, stwórz nowego użytkownika o nazwie
-- expense_tracker_user z możliwością zalogowania się do bazy danych i hasłem silnym :) (coś
-- wymyśl)

CREATE ROLE expense_tracker_user WITH LOGIN PASSWORD 'bardzosilnehaslo';


-- 2. Korzystając ze składni REVOKE, odbierz uprawnienia tworzenia obiektów w schemacie
-- public roli PUBLIC

REVOKE ALL PRIVILEGES ON SCHEMA public FROM expense_tracker_user;


-- 3. Jeżeli w Twoim środowisku istnieje już schemat expense_tracker (z obiektami tabel) usuń
-- go korzystając z polecenie DROP CASCADE.

DROP SCHEMA expense_tracker CASCADE;


-- 4. Utwórz nową rolę expense_tracker_group.

CREATE ROLE expense_tracker_group;


-- 5. Utwórz schemat expense_tracker, korzystając z atrybutu AUTHORIZATION, ustalając
-- własnośćna rolę expense_tracker_group.

CREATE SCHEMA expense_tracker AUTHORIZATION expense_tracker_group;


-- 6. Dla roli expense_tracker_group, dodaj następujące przywileje:
--  Dodaj przywilej łączenia do bazy danych postgres (lub innej, jeżeli korzystasz z
-- innej nazwy)
--  Dodaj wszystkie przywileje do schematu expense_tracker

GRANT CONNECT ON DATABASE postgres TO expense_tracker_group;
GRANT ALL PRIVILEGES ON SCHEMA expense_tracker TO expense_tracker_group;


-- 7. Dodaj rolę expense_tracker_group użytkownikowi expense_tracker_user

GRANT expense_tracker_group TO expense_tracker_user;