
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
