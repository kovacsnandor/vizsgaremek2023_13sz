SELECT * from hallgato;
SELECT * from jelentkezes;
SELECT * from vizsga;

DELETE FROM jelentkezes;
DELETE FROM hallgato;
DELETE FROM vizsga;

# hallgatók
INSERT INTO hallgato (id, nev) VALUES
(1, 'józsi'), (1, 'józsi')
;

# vizsgák
INSERT INTO vizsga (id, datum, targy) VALUES
  (1, 'éalksjdf', 'fizika');

# jelenkezések
INSERT INTO jelentkezes (hallgatoid, vizsgaid, jeldatum, ledatum, igazolt, jegy) VALUES
  (2, 23, 'élkjélkj', 'élkjélkj', NULL, 1);

SELECT * FROM hallgato;
SELECT * FROM jelentkezes;
SELECT * FROM vizsga;