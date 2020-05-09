-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-05-09 08:55:00.868

-- tables
-- Table: blast_result
CREATE TABLE blast_result (
    id int NOT NULL AUTO_INCREMENT,
    eiwit_code varchar(32) NOT NULL,
    org_code varchar(32) NOT NULL,
    evalue double(16,3) NOT NULL,
    tot_score decimal(5,1) NOT NULL,
    max_score decimal(5,1) NOT NULL,
    identity decimal(5,2) NOT NULL,
    CONSTRAINT blast_result_pk PRIMARY KEY (id)
);

-- Table: eiwit
CREATE TABLE eiwit (
    acc_code varchar(32) NOT NULL,
    naam varchar(1024) NOT NULL,
    functie varchar(1024) NULL,
    CONSTRAINT eiwit_pk PRIMARY KEY (acc_code)
);

-- Table: lineage
CREATE TABLE lineage (
    id int NOT NULL AUTO_INCREMENT,
    naam varchar(100) NOT NULL,
    rank varchar(25) NOT NULL,
    parent int NULL,
    CONSTRAINT lineage_pk PRIMARY KEY (id)
);

-- Table: organisme
CREATE TABLE organisme (
    acc_code varchar(32) NOT NULL,
    naam varchar(512) NOT NULL,
    lineage_id int NOT NULL,
    CONSTRAINT organisme_pk PRIMARY KEY (acc_code)
);

-- Table: read
CREATE TABLE `read` (
    id int NOT NULL AUTO_INCREMENT,
    sequence_id int NOT NULL,
    `read` varchar(512) NOT NULL,
    score varchar(512) NOT NULL,
    is_forward bool NOT NULL,
    CONSTRAINT read_pk PRIMARY KEY (id)
);

-- Table: read_blast
CREATE TABLE read_blast (
    id int NOT NULL AUTO_INCREMENT,
    read_id int NOT NULL,
    blast_id int NOT NULL,
    CONSTRAINT read_blast_pk PRIMARY KEY (id)
);

-- Table: sequentie
CREATE TABLE sequentie (
    id int NOT NULL AUTO_INCREMENT,
    naam varchar(256) NOT NULL,
    CONSTRAINT sequentie_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: eiwit_entry_Eiwit (table: blast_result)
ALTER TABLE blast_result ADD CONSTRAINT eiwit_entry_Eiwit FOREIGN KEY eiwit_entry_Eiwit (eiwit_code)
    REFERENCES eiwit (acc_code);

-- Reference: eiwit_entry_organisme (table: blast_result)
ALTER TABLE blast_result ADD CONSTRAINT eiwit_entry_organisme FOREIGN KEY eiwit_entry_organisme (org_code)
    REFERENCES organisme (acc_code);

-- Reference: lineage_lineage (table: lineage)
ALTER TABLE lineage ADD CONSTRAINT lineage_lineage FOREIGN KEY lineage_lineage (parent)
    REFERENCES lineage (id);

-- Reference: organisme_lineage (table: organisme)
ALTER TABLE organisme ADD CONSTRAINT organisme_lineage FOREIGN KEY organisme_lineage (lineage_id)
    REFERENCES lineage (id);

-- Reference: read_sequence (table: read)
ALTER TABLE `read` ADD CONSTRAINT read_sequence FOREIGN KEY read_sequence (sequence_id)
    REFERENCES sequentie (id);

-- Reference: sequence_eiwit_eiwit_entry (table: read_blast)
ALTER TABLE read_blast ADD CONSTRAINT sequence_eiwit_eiwit_entry FOREIGN KEY sequence_eiwit_eiwit_entry (blast_id)
    REFERENCES blast_result (id);

-- Reference: sequence_eiwit_read (table: read_blast)
ALTER TABLE read_blast ADD CONSTRAINT sequence_eiwit_read FOREIGN KEY sequence_eiwit_read (read_id)
    REFERENCES `read` (id);

-- End of file.

