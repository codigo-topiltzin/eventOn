START TRANSACTION;
CREATE TABLE IF NOT EXISTS tableA(
        GENERATED ALWAYS AS (),
        CONSTRAINT pk_tableA PRIMARY KEY(id)
        )ENGINE=InnoDb
        DEFAULT CHARSET = utf8mb4;
        /* CONSTRAINT fk_tableA_tableB FOREIGN KEY(field) REFERENCES tableB(field)
        ON DELETE SET ON UPDATE NO ACTION
        ATTACH DATABASE '' AS ;
        MyISAM*/
