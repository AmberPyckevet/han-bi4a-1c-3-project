-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-05-09 08:55:00.868

-- foreign keys
ALTER TABLE blast_result
    DROP FOREIGN KEY eiwit_entry_Eiwit;

ALTER TABLE blast_result
    DROP FOREIGN KEY eiwit_entry_organisme;

ALTER TABLE lineage
    DROP FOREIGN KEY lineage_lineage;

ALTER TABLE organisme
    DROP FOREIGN KEY organisme_lineage;

ALTER TABLE `read`
    DROP FOREIGN KEY read_sequence;

ALTER TABLE read_blast
    DROP FOREIGN KEY sequence_eiwit_eiwit_entry;

ALTER TABLE read_blast
    DROP FOREIGN KEY sequence_eiwit_read;

-- tables
DROP TABLE blast_result;

DROP TABLE eiwit;

DROP TABLE lineage;

DROP TABLE organisme;

DROP TABLE `read`;

DROP TABLE read_blast;

DROP TABLE sequentie;

-- End of file.

