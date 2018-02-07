--Creación de tablas


CREATE TABLE usuario (UserID int NOT NULL, Poliza int NOT NULL, Vehiculo VARCHAR(18) NOT NULL, Nombre varchar(20) NOT NULL, Apellido VARCHAR(20) NOT NULL, Direccion VARCHAR(40) NOT NULL, Telefono int NOT NULL, SYS_START TIMESTAMP(12) GENERATED ALWAYS AS ROW BEGIN NOT NULL, SYS_END TIMESTAMP(12) GENERATED ALWAYS AS ROW END NOT NULL, TRANS_START TIMESTAMP(12) GENERATED ALWAYS AS TRANSACTION START ID IMPLICITLY HIDDEN, period SYSTEM_TIME(SYS_START, SYS_END), PRIMARY KEY (UserID), FOREIGN KEY pol (Poliza) REFERENCES poliza, FOREIGN KEY veh (Vehiculo) REFERENCES vehiculo)

CREATE TABLE usuario_history LIKE usuario
ALTER TABLE usuario  ADD versioning use HISTORY TABLE usuario_history

CREATE TABLE poliza (PolizaID int NOT NULL, Costo decimal(7,2) NOT NULL, Cobertura int NOT NULL, finicio date NOT NULL, ffinal date NOT NULL, period business_time(finicio, ffinal), PRIMARY KEY (PolizaID))


CREATE TABLE vehiculo (NIV VARCHAR(18) NOT NULL, Year int NOT NULL,Modelo VARCHAR(10) NOT NULL, Marca VARCHAR(10) NOT NULL, Precio decimal(8,2) NOT NULL, Motor VARCHAR(20) NOT NULL, PRIMARY KEY (NIV))



--Llenado de tablas

INSERT INTO vehiculo VALUES ('123ABC', 2012, 'Sentra', 'Nissan', 100000, 'ABC123')
INSERT INTO vehiculo VALUES ('234ABC', 2008, 'Versa', 'Nissan', 80000, 'AEWFERGW')
INSERT INTO vehiculo VALUES ('345ABE', 2010, 'Vento', 'Starbucks', 300000, 'WKLDWKMWE')

INSERT INTO poliza VALUES (1, 10000, 4, '2012-01-01', '2013-01-01')
INSERT INTO poliza VALUES (2, 80000, 1, '2010-01-01', '2012-01-01')
INSERT INTO poliza VALUES (3, 30000, 2, '2012-01-01', '2013-01-01')

INSERT INTO usuario (UserID, Poliza, Vehiculo, Nombre, Apellido, Direccion, Telefono) VALUES (1, 1, '123ABC', 'Miguel', 'Cerroguero', 'Las Montañas 197', 52155)

INSERT INTO usuario  (UserID, Poliza, Vehiculo, Nombre, Apellido, Direccion, Telefono)  VALUES (2, 2, '345ABE', 'Omar', 'Sanseviero', 'Las Llamas 791', 55555555)

INSERT INTO usuario  (UserID, Poliza, Vehiculo, Nombre, Apellido, Direccion, Telefono) VALUES (3, 3, '234ABC', 'Victor', 'Covadonga', 'Los Venados Cosmicos 42', 55123321)


--Trigger
--Sólo permite que la cobertura de la poliza se expanda (vaya de un número más alto, como 4, a un número más bjao, como 1).


CREATE TRIGGER just_extend
BEFORE UPDATE OF cobertura ON poliza
REFERENCING new AS new_values old AS old_values 
FOR EACH ROW MODE DB2SQL 
WHEN (new_values.cobertura > old_values.cobertura) 
BEGIN  ATOMIC  
	SIGNAL SQLSTATE '75000' SET MESSAGE_TEXT='Error - sólo se puede ampliar poliza'; 
END


CREATE TRIGGER update_price AFTER UPDATE OF ffinal ON poliza REFERENCING new AS new_values old AS old_values  FOR EACH ROW MODE DB2SQL  BEGIN ATOMIC   UPDATE poliza SET costo= (days(new_values.ffinal)-days(new_values.finicio))*old_values.costo/ (days(old_values.ffinal)-days(old_values.finicio)) WHERE polizaId = new_values.polizaId; END
