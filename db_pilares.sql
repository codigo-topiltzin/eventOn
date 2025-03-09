/* 
CREATE DATABASE db_codigo_topiltzin CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'account'@%
GRANT ALL PRIVILEGES
ON `db\_session`.* 
TO 'ErickDeLaRosa'@'%' INDENTIFIED BY 'password' WITH GRANT OPTION;
*/
USE db_codigo_topiltzin;

START TRANSACTION;
CREATE TABLE IF NOT EXISTS users(
        id INT UNSIGNED AUTO_INCREMENT,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        full_name GENERATED ALWAYS AS (CONCAT(first_name, " ", last_name)),
        folio VARCHAR(12) NOT NULL,
        age INT UNSIGNED,
        sex VARCHAR(20),
        phone VARCHAR(12),
        email VARCHAR(50),
        CONSTRAINT pk_users PRIMARY KEY(id)
)ENGINE=InnoDb;
CREATE TABLE IF NOT EXISTS events(
        id INT UNSIGNED AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL,
        date_e DATE NOT NULL,
        start_e TIME NOT NULL,
        finish_e TIME NOT NULL,
        CONSTRAINT pk_events PRIMARY KEY(id)
)ENGINE=InnoDb;
CREATE TABLE IF NOT EXISTS assistant(
        id INT UNSIGNED AUTO_INCREMENT,
        rol VARCHAR(100) NOT NULL,
        user_pilares INT UNSIGNED,
        event INT UNSIGNED,
        CONSTRAINT pk_assistant PRIMARY KEY(id),
        CONSTRAINT fk_assistant_users FOREIGN KEY(user_pilares) REFERENCES users(id)
        ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT fk_assistant_event FOREIGN KEY(event) REFERENCES events(id)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE=InnoDb;
        /* CONSTRAINT fk_tableA_tableB FOREIGN KEY(field) REFERENCES tableB(field)
        ON DELETE SET ON UPDATE NO ACTION
        ATTACH DATABASE '' AS ;
        MyISAM*/
commit;
START TRANSACTION;
INSERT OR REMPLACE INTO users(
        first_name, last_name, folio, age, sex,  phone, email
)
VALUES
()
;
INSERT OR REMPLACE INTO events(
        name, date_e, time_e, start_e, finish_e
)
VALUES
()
;
INSERT OR REMPLACE INTO assistant(
        rol, user_pilares, event 
)
VALUES
()
;
START TRANSACTION;
UPDATE users
SET
age =
WHERE folio = "";

UPDATE event
SET
start_e = ""
WHERE id = "";

UPDATE assistant
SET
rol = ""
WHERE user_pilares = "";

CREATE VIEW IF NOT EXISTS v_ages AS
SELECT DISTINCT age
FROM users;

CREATE VIEW IF NOT EXISTS v_childrens AS
SELECT full_name, age, folio
FROM users
WHERE age<=12
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_teenagers AS
SELECT full_name, age, folio, email, phone
FROM users
WHERE age>12 && age<18
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_young_adults AS
SELECT full_name, age, folio, email, phone
FROM users
WHERE age>18 && age<30
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_older_adults AS
SELECT full_name, age, folio, email, phone
FROM users
WHERE age>60
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_adults AS
SELECT full_name, age, folio, email, phone
FROM users
WHERE age>=30 && age<60
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_events AS
SELECT name, date_e, start_e, finish_e, DATEDIFF(mi, start_e, finish_e)/60 
FROM events
ORDER BY date_e DESC;
/*
WHERE MATCH(fields) AGAINST('-content' IN BOOLEAN MODE);
ORDER BY * /ASC/DESC/NULLS LAST;
LIMIT /OFFSET
*/

CREATE VIEW IF NOT EXISTS nameView AS
SELECT tableA.field1, tableB.field2
FROM tableA
CROSS JOIN tableB ON tableA.fieldPK = tableB.fielFK
;
/*
FULL OUTER JOIN
WHERE tableA.id IS NULL OR tableB.id IS NULL;
GROUP BY field HAVING ;
*/
CREATE VIEW IF NOT EXISTS nameView AS
SELECT field_1
FROM
UNION
SELECT field
FROM
 /*
 UNION ALL
 EXCEPT
 INTERSECT
 WHERE field = (
);
*/
START TRANSACTION;
DELETE FROM tableA
WHERE field = ;
/*
DROP TABLE IF EXISTS tableA;
TRUNCATE FROM tableA;
*/
