/* 
@author:erick14911
Base de datos db_codigo_topiltzin para el registro de usuarios y eventos
*/
/*Create data base db_codigo_topiltzin*/
CREATE DATABASE db_codigo_topiltzin CHARACTER SET utf8mb4;
/*Create user admin*/
CREATE USER IF NOT EXISTS 'erick14911'@%;
/*Grand permit*/
GRANT ALL 
ON 'db_codigo_topiltzin'.* 
TO 'erick14911'@% INDENTIFIED BY 'password';
/*edit data base*/
USE db_codigo_topiltzin;

START TRANSACTION;
/*Create users table*/
CREATE TABLE IF NOT EXISTS users(
        id INT UNSIGNED AUTO_INCREMENT,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        full_name GENERATED ALWAYS AS (CONCAT(first_name, " ", last_name)),
        birthdate DATE NOT NULL,
        gander VARCHAR(20) NOT NULL,
        reference_number VARCHAR(12) NOT NULL,
        reference_number_bf VARCHAR(12),
        role VARCHAR(50),
        phone VARCHAR(12),
        mobile VARCHAR(12),
        email VARCHAR(50),
        CONSTRAINT pk_users PRIMARY KEY(id)
)ENGINE=InnoDb;
/*Table events*/
CREATE TABLE IF NOT EXISTS events(
        id INT UNSIGNED AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL,
        start_date DATE NOT NULL,
        start_time TIME NOT NULL,
        end_time TIME NOT NULL,
        CONSTRAINT pk_events PRIMARY KEY(id)
)ENGINE=InnoDb;
/*Table assistants*/
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
/*Table editors*/
CREATE TABLE IF NOT EXISTS editors(
        id INT UNSIGNED AUTO_INCREMENT,
        date_change DATETIME DEFAULT CURDATE(),
        change VARCHAR(100) NOT NULL,
        user_editor VARCHAR(100) DEFAULT USER(),
        idUser VARCHAR(12) NOT NULL, 
        updateUser VARCHAR(500) DEFAULT " ",
        CONSTRAINT pk_editors PRIMARY KEY(id)
        )ENGINE=InnoDb;
commit;
/*Insert a new user*/
START TRANSACTION;
CREATE PROCEDURE pc_insert_user(
        fn VARCHAR(100), lan VARCHAR(100), b DATE, g VARCHAR(20), f VARCHAR(12), fb VARCHAR(12) DEFAULT " ", r VARCHAR(50) DEFAULT " ", p VARCHAR(12) DEFAULT " ", m VARCHAR(12) DEFAULT " ", e VARCHAR(50) DEFAULT " " 
)
INSERT OR REMPLACE INTO users(
        first_name, last_name, birthdate, gander, reference_number, reference_number_bf, role, phone, mobile, email
)
VALUES
(fn, lan, b, g, f, fb, r, p, m, e)
;
/*Insert a new event*/
CREATE PROCEDURE pc_insert_event(
      n VARCHAR(100), d DATE, st TIME, et TIME 
)
INSERT OR REMPLACE INTO events(
        name, start_date, start_time, end_time
)
VALUES
(n, d, st, et)
;
/*Insert a new assistand*/
CREATE PROCEDURE pc_insert_assistand(
        r VARCHAR(100), u INT UNSIGNED, e INT UNSIGNED
)
INSERT OR REMPLACE INTO assistants(
        role, user_pilares, event 
)
VALUES
(r, u, e)
;
commit;
/*Update user*/
START TRANSACTION;
CREATE PROCEDURE pc_update_user(
        fn VARCHAR(100), lan VARCHAR(100), b DATE, g VARCHAR(20), f VARCHAR(12), fb VARCHAR(12) DEFAULT " ", r VARCHAR(50) DEFAULT " ", p VARCHAR(12) DEFAULT " ", m VARCHAR(12) DEFAULT " ", e VARCHAR(50) DEFAULT " " 
)
UPDATE users
SET
first_name = fn,
last_name = lan,
birthdate = b,
gander = g,
reference_number = fb,
role = r,
phone = p,
mobile = m,
email = e
WHERE reference_number = f;
/*Update event*/
CREATE PROCEDURE pc_update_event(
        n VARCHAR(100), sd DATE, st TIME, et TIME
)
UPDATE event
SET
name = n,
start_date = sd,
start_time = st,
end_time = et
WHERE name LIKE n AND start_date LIKE sd;
/*Update assistants*/
CREATE PROCEDURE pc_update_assistants(
        u INT UNSIGNED, r DATE
)
UPDATE assistants
SET
role = r
WHERE user_pilares = u;
commit;

/*Delete a user*/
START TRANSACTION;

CREATE PROCEDURE pc_delete_user(
        f VARCHAR(12)
)
DELETE 
FROM users 
WHERE reference_number = f;
/*Delete a event*/
CREATE PROCEDURE pc_delete_event(
        n VARCHAR(100), sd DATE
)
DELETE 
FROM events 
WHERE name LIKE n AND start_date LIKE sd
/*Delete assistant*/
CREATE PROCEDURE pc_delete_assistant(
        f VARCHAR(12)
)
DELETE 
FROM assistants 
LEFT JOIN users ON users.id = assistants.user_pilares
WHERE users.reference_number = f;
commit;
/*
DROP TABLE IF EXISTS tableA;
TRUNCATE FROM tableA;
*/

/*Crear views*/
START TRANSACTION;
CREATE VIEW IF NOT EXISTS v_users AS
SELECT full_name,
       DATEDIFF(year,CURDATE(),birthdate) AS age,
       gander, 
       reference_number,
       reference_number_bf,
       role,
       phone,
       mobile,
       email
FROM users;

CREATE VIEW IF NOT EXISTS v_ages AS
SELECT DISTINCT age AS Edad
FROM v_users;

CREATE VIEW IF NOT EXISTS v_childrens AS
SELECT full_name AS Nombre,
       age AS Edad, 
       reference_number AS Folio
FROM v_users
WHERE age<=12
ORDER BY full_name ASC;
/*SELECT * FROM v_childrens;*/
CREATE VIEW IF NOT EXISTS v_teenagers AS
SELECT full_name AS Nombre,
       age AS Edad,
       reference_number AS Folio,
       email AS Email, 
       phone AS Telefono,
       mobile AS Celular
FROM v_users
WHERE age>12 && age<18
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_young_adults AS
SELECT full_name AS Nombre,
       age AS Edad,
       reference_number AS Folio,
       email AS "Correo Electronico",
       phone AS Telefono,
       mobile AS Celular
FROM v_users
WHERE age>18 && age<30
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_older_adults AS
SELECT full_name AS Nombre,
       age AS Edad,
       reference_number As Folio,
       email As 'Correo electronico',
       phone As Telefono,
       mobile AS Celular
FROM v_users
WHERE age>60
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_adults AS
SELECT full_name AS Nombre,
       age AS Edad,
       reference_number As Folio,
       email As 'Correo electronico',
       phone As Telefono,
       mobile AS Celular
FROM v_users
WHERE age>=30 && age<60
ORDER BY full_name ASC;

CREATE VIEW IF NOT EXISTS v_events AS
SELECT name AS Nombre, 
       start_date AS Fecha,
       start_time AS "Hora de inicio",
       end_time AS "Hora de termino",
       DATEDIFF(mi, start_e, finish_e)/60 AS Duracion
FROM events
ORDER BY date_e DESC;
/*
WHERE MATCH(fields) AGAINST('-content' IN BOOLEAN MODE);
ORDER BY * /ASC/DESC/NULLS LAST;
LIMIT /OFFSET
*/
DELIMITER $$

CREATE PROCEDURE pc_assistants(e VARCHAR(100))

BEGIN
        SELECT * FROM v_assistants;
END;
$$

DELIMITER ;

CREATE VIEW IF NOT EXISTS v_assistants AS
SELECT users.full_name AS Nombre, 
       users.reference_number AS Folio,
       assistants.role AS Participacion,
       users.email AS 'Correo electronico',
       users.mobile AS Celular,
       users.phone AS Telefono
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
WHERE events.name LIKE e
ORDER BY users.full_name ASC
;

DELIMITER $$

CREATE PROCEDURE pc_number_assistants(e VARCHAR(100))

BEGIN
        SELECT * FROM v_assistants;
END;
$$

DELIMITER ;

CREATE VIEW IF NOT EXISTS v_number_assistant AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Numero de asistentes"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name
HAVING events.name LIKE e
ORDER BY users.full_name ASC
;

DELIMITER $$

CREATE PROCEDURE pc_childrens_number_event(e VARCHAR(100))

BEGIN
        SELECT * FROM v_childrens_number_event;
END;
$$

DELIMITER ;

CREATE VIEW IF NOT EXISTS v_childrens_number_event AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Infancias <=12"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name
HAVING events.name LIKE e && users.age<=12
ORDER BY users.full_name ASC
;

DELIMITER $$

CREATE PROCEDURE pc_youngs_number_event(e VARCHAR(100))

BEGIN
        SELECT * FROM v_youngs_number_event;
END;
$$

DELIMITER ;

CREATE VIEW IF NOT EXISTS v_youngs_number_event AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Adolecentes <=12<18"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name
HAVING events.name LIKE e && users.age>12 && users.age<18 
ORDER BY users.full_name ASC
;

DELIMITER $$

CREATE PROCEDURE pc_adults_number_event(e VARCHAR(100))

BEGIN
        SELECT * FROM v_adults_number_event;
END;
$$

DELIMITER ;

CREATE VIEW IF NOT EXISTS v_adults_number_event AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Adultos >=30<60"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name 
HAVING events.name LIKE e && users.age>=30 && users.age<60 
ORDER BY users.full_name ASC
;

DELIMITER $$

CREATE PROCEDURE pc_old_adults_number_event(e VARCHAR(100))

BEGIN
        SELECT * FROM v_old_adults_number_event;
END;
$$

DELIMITER ;

CREATE VIEW IF NOT EXISTS v_old_adults_number_event AS
SELECT events.name AS Evento,
       COUNT(users.id) AS "Adulto mayor >60"
FROM assistants
LEFT JOIN users ON users.id = assistants.user_pilares
LEFT JOIN event ON events.id = assistants.event
GROUP BY events.name 
HAVING events.name LIKE e && users.age>60
ORDER BY users.full_name ASC
;
commit;
/*
FULL OUTER JOIN
WHERE tableA.id IS NULL OR tableB.id IS NULL;
GROUP BY field HAVING ;
*/
