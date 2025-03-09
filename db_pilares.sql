/* 
CREATE DATABASE db_codigo_topiltzin CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'account'@%
GRANT ALL PRIVILEGES
ON `db\_session`.* 
TO 'ErickDeLaRosa'@'%' INDENTIFIED BY 'password' WITH GRANT OPTION;
*/
CREATE DATABASE db_codigo_topiltzin CHARACTER SET utf8mb4;

CREATE USER IF NOT EXISTS 'erick14911'@%;

GRANT ALL 
ON 'db_codigo_topiltzin'.* 
TO 'erick14911'@% INDENTIFIED BY 'password';

USE db_codigo_topiltzin;

START TRANSACTION;
CREATE TABLE IF NOT EXISTS users(
        id INT UNSIGNED AUTO_INCREMENT,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        full_name GENERATED ALWAYS AS (CONCAT(first_name, " ", last_name)),
        folio VARCHAR(12) NOT NULL,
        folio_bf VARCHAR(12),
        figure VARCHAR(50),
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
CREATE TABLE IF NOT EXISTS assistants(
        id INT UNSIGNED AUTO_INCREMENT,
        role VARCHAR(100) NOT NULL,
        user_pilares INT UNSIGNED,
        event INT UNSIGNED,
        CONSTRAINT pk_assistants PRIMARY KEY(id),
        CONSTRAINT fk_assistants_users FOREIGN KEY(user_pilares) REFERENCES users(id)
        ON DELETE NO ACTION ON UPDATE CASCADE,
        CONSTRAINT fk_assistants_event FOREIGN KEY(event) REFERENCES events(id)
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
INSERT OR REMPLACE INTO users(
        first_name, last_name, folio, age, sex,  phone, email, folio_bf, figure
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
INSERT OR REMPLACE INTO assistants(
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

UPDATE assistants
SET
rol = ""
WHERE user_pilares = "";

CREATE VIEW IF NOT EXISTS v_ages AS
SELECT DISTINCT age AS Edad
FROM users;

CREATE VIEW IF NOT EXISTS v_childrens AS
SELECT full_name AS Nombre,
       age AS Edad, 
       folio AS Folio
FROM users
WHERE age<=12
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_teenagers AS
SELECT full_name AS Nombre,
       age AS Edad,
       folio AS Folio,
       email AS Email, 
       phone AS Telefono
FROM users
WHERE age>12 && age<18
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_young_adults AS
SELECT full_name AS Nombre,
       age AS Edad,
       folio AS Folio,
       email AS Email,
       phone AS Telefono
FROM users
WHERE age>18 && age<30
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_older_adults AS
SELECT full_name AS Nombre,
       age AS Edad,
       folio As Folio,
       email As Email,
       phone As Telefono
FROM users
WHERE age>60
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_adults AS
SELECT full_name AS Nombre,
       age AS Edad,
       folio As Folio,
       email As Email,
       phone As Telefono
FROM users
WHERE age>=30 && age<60
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_events AS
SELECT name AS Nombre, 
       date_e AS Fecha,
       start_e AS "Hora de inicio",
       finish_e AS "Hora de termino",
       DATEDIFF(mi, start_e, finish_e)/60 AS Duracion
FROM events
ORDER BY date_e DESC;
/*
WHERE MATCH(fields) AGAINST('-content' IN BOOLEAN MODE);
ORDER BY * /ASC/DESC/NULLS LAST;
LIMIT /OFFSET
*/

CREATE VIEW IF NOT EXISTS v_assistants AS
SELECT users.full_name AS Nombre, 
       users.folio AS Folio,
       assistants.role AS Participacion,
       users.email AS Email,
       users.phone AS Telefono
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
WHERE events.name=""
ORDER BY users.full_name ASC
;

CREATE VIEW IF NOT EXISTS v_number_assistant AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Numero de asistentes"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name
HAVING events.name=""
ORDER BY users.full_name ASC
;

CREATE VIEW IF NOT EXISTS v_childrens_number_event AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Infancias <=12"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name
HAVING events.name="" && users.age<=12
ORDER BY users.full_name ASC
;

CREATE VIEW IF NOT EXISTS v_youngs_number_event AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Adolecentes <=12<18"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name
HAVING events.name="" && users.age>12 && users.age<18 
ORDER BY users.full_name ASC
;

CREATE VIEW IF NOT EXISTS v_adults_number_event AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Adultos >=30<60"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name 
HAVING events.name="" && users.age>=30 && users.age<60 
ORDER BY users.full_name ASC
;

CREATE VIEW IF NOT EXISTS v_old_adults_number_event AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Adulto mayor >60"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name 
HAVING events.name="" && users.age>60
ORDER BY users.full_name ASC
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
