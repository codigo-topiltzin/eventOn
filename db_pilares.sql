
/* 
CREATE DATABASE db_codigo_topiltzin CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'account'@%
GRANT ALL PRIVILEGES
ON `db\_session`.* 
TO 'ErickDeLaRosa'@'%' INDENTIFIED BY 'password' WITH GRANT OPTION;
*/
USE db_codigo_topiltzin;

START TRANSACTION;
CREATE TABLE IF NOT EXISTS usuario(
        id INT UNSIGNED AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL,
        apellidos VARCHAR(100) NOT NULL,
        full_name GENERATED ALWAYS AS (),
        CONSTRAINT pk_tableA PRIMARY KEY(id)
        )ENGINE=InnoDb
        DEFAULT CHARSET = utf8mb4;
        /* CONSTRAINT fk_tableA_tableB FOREIGN KEY(field) REFERENCES tableB(field)
        ON DELETE SET ON UPDATE NO ACTION
        ATTACH DATABASE '' AS ;
        MyISAM*/
