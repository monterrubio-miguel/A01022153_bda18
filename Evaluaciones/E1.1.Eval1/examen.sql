--Examen Miguel Monterrubio


--Inciso 1
CREATE TABLE LOG_FILM (Id int NOT NULL AUTO_INCREMENT, Tipo varchar(20) DEFAULT 'Update', Film_id int NOT NULL, Last_value int, New_value int, Time_Stamp timestamp DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (Id));

--Inciso 2
DELIMITER &&
CREATE PROCEDURE save(IN Fid int, IN Lvalue int, IN Nvalue int) BEGIN INSERT INTO LOG_FILM (Film_id, Last_value, New_value) VALUES (Fid, Lvalue, Nvalue);
END &&
DELIMITER ;

--Inciso 3
DELIMITER &&
CREATE TRIGGER film_update AFTER UPDATE ON film FOR EACH ROW BEGIN CALL save(film_id, OLD.original_language_id, NEW.original_language_id);
END &&
DELIMITER ;

--Inciso 4
DELIMITER &&
create procedure update_language()

BEGIN
DECLARE ids INT;
DECLARE done int DEFAULT false;
DECLARE cursor_lang CURSOR FOR SELECT film_id FROM film;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

open cursor_lang;
read_loop: loop
fetch cursor_lang into ids;
IF done THEN
LEAVE read_loop;
END IF;
IF (SELECT category_id FROM film_category WHERE film_id = ids) = 6 THEN UPDATE film SET original_language_id=2 WHERE film_id = ids;
ELSEIF (SELECT category_id FROM film_category WHERE film_id = ids) = 9 THEN UPDATE film SET original_language_id=3 WHERE film_id = ids;
ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = ids AND actor_id=31) = 1 THEN UPDATE film SET original_language_id=6 WHERE film_id = ids;
ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = ids AND actor_id=3) = 1 THEN UPDATE film SET original_language_id=4 WHERE film_id = ids;
ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = ids AND actor_id=34) = 1 THEN UPDATE film SET original_language_id=5 WHERE film_id = ids;
ELSE UPDATE film SET original_language_id=1 WHERE film_id = ids;
END IF;
end loop;
select ids;
close cursor_lang;
END &&
DELIMITER ;

--Inciso 5
CREATE TABLE GOMITAS (ID INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),NOMBRE VARCHAR(50) NOT NULL,PRECIO INT NOT NULL,CSTART DATE NOT NULL,CEND DATE NOT NULL,period BUSINESS_TIME(CSTART, CEND),PRIMARY KEY (ID))

INSERT INTO gomitas (NOMBRE, PRECIO, CSTART, CEND) VALUES ('verde', 5, '2018-1-1', '2019-1-1'), ('roja', 6, '2018-1-1', '2019-1-1'), ('rosa', 7, '2018-1-1', '2019-1-1'), ('amarilla', 8, '2018-1-1', '2019-1-1'), ('morada', 9, '2018-1-1', '2019-1-1'), ('azul', 10, '2018-1-1', '2019-1-1'), ('naranja', 11, '2018-1-1', '2019-1-1'), ('negra', 12, '2018-1-1', '2019-1-1'), ('blanca', 13, '2018-1-1', '2019-1-1'), ('bicolor', 14, '2018-1-1', '2019-1-1'), ('cafe', 15, '2018-1-1', '2019-1-1'), ('tricolor', 16, '2018-1-1', '2019-1-1')

UPDATE GOMITAS FOR PORTION OF BUSINESS_TIME FROM '2018-2-1' to '2019-1-1' SET PRECIO = PRECIO*1.45

UPDATE GOMITAS FOR PORTION OF BUSINESS_TIME FROM '2018-4-25' to '2019-1-1' SET PRECIO = PRECIO*1.45

UPDATE GOMITAS FOR PORTION OF BUSINESS_TIME FROM '2018-10-25' to '2019-1-1' SET PRECIO = PRECIO*1.45

UPDATE GOMITAS FOR PORTION OF BUSINESS_TIME FROM '2018-2-15' to '2019-1-1' SET PRECIO = (PRECIO/1.45)*1.1

UPDATE GOMITAS FOR PORTION OF BUSINESS_TIME FROM '2018-5-5' to '2019-1-1' SET PRECIO = (PRECIO/1.45)*1.1

UPDATE GOMITAS FOR PORTION OF BUSINESS_TIME FROM '2018-11-5' to '2019-1-1' SET PRECIO = (PRECIO/1.45)*1.1





SELECT * from GOMITAS WHERE NOMBRE='azul'

SELECT SUM(PRECIO)/COUNT(*) as AVG from GOMITAS WHERE NOMBRE='azul'

SELECT MAX(PRECIO) as MAX from GOMITAS WHERE NOMBRE='azul'

SELECT MIN(PRECIO) as MAX from GOMITAS WHERE NOMBRE='azul'