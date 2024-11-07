## -----------------------------------------------------------------
-- Tema     : Gestión de datos desde Cero
-- Curso    : Base de Datos 1
-- SGBD     : MySQL 5x
-- Profesor : Jesús Canales G.
-- ----------------------------------------------------------------- ##

## CREACIÓN DE BASE DE DATOS PRO
CREATE DATABASE IF NOT EXISTS dbConsultas_Carreras
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;
USE dbConsultas_Carreras;
###

## CREACIÓN DE TABLAS PRO
-- Eliminar tablas si existen para evitar errores al recrearlas
DROP TABLE IF EXISTS consultation;
DROP TABLE IF EXISTS adviser;
DROP TABLE IF EXISTS career;
DROP TABLE IF EXISTS applicant;

-- Creación de tabla solicitante
CREATE TABLE IF NOT EXISTS applicant (
	id int auto_increment not null, -- esta columna llena automáticamente el número de id
    registration_date timestamp DEFAULT current_timestamp, -- esta columna será llenada por mysql
    name varchar(60) not null,
    lastname varchar(100) not null,
    sex char(1) not null,
    identification_document char(3) not null,
    document_number char(20) not null,
    email varchar(120),
    cellphone char(9) not null,
    birthdate date,
    state char(1) DEFAULT 'A', -- esta columna la va a llenar mysql con la letra A (ACTIVO)
    CONSTRAINT pk_applicant PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Creación de tabla consulta
CREATE TABLE IF NOT EXISTS consultation (
	id int auto_increment not null,
    consultation_date timestamp DEFAULT current_timestamp,
    applicant int not null,
    career char(3) not null,
    consultation varchar(500) not null,
    adviser int,
    answer varchar(500),
    state char(1) DEFAULT 'A',
    CONSTRAINT pk_consultation PRIMARY KEY(id)
)ENGINE=InnoDB;

-- Creación de tabla carrera
CREATE TABLE IF NOT EXISTS career (
	id char(3) not null,
    name varchar(100) not null,
    description varchar(500) not null,
    state char(1) DEFAULT 'A',
    CONSTRAINT pk_career PRIMARY KEY (id)
)ENGINE=InnoDB;

-- Creación de tabla asesor
CREATE TABLE IF NOT EXISTS adviser (
	id int auto_increment not null,
    registration_date timestamp DEFAULT current_timestamp,
    name varchar(60) not null,
    lastname varchar(100) not null,
    identification_document char(3) not null,
    document_number char(20) not null,
    email varchar(60) not null,
    cellphone char(9) not null,
    marital_status char(1),
    state char(1) DEFAULT 'A',
    CONSTRAINT pk_adviser PRIMARY KEY (id)
) ENGINE=InnoDB;
##

## CREACIÓN DE RELACIONES PRO
-- Estableciendo la relación entre applicant y consultation
ALTER TABLE consultation
ADD CONSTRAINT fk_applicant_consultation
FOREIGN KEY (applicant) REFERENCES applicant(id);

-- Estableciendo la relación entre career y consultation
ALTER TABLE consultation
ADD CONSTRAINT fk_career_consultation
FOREIGN KEY (career) REFERENCES career(id);

-- Estableciendo la relación entre applicant y consultation
ALTER TABLE consultation
ADD CONSTRAINT fk_adviser_consultation
FOREIGN KEY (adviser) REFERENCES adviser(id);
##

## Ponemos en uso la base de datos dbConsultas_Carreras
USE dbConsultas_Carreras;

/* Sentencias DML (Data Manipulation Language / Lenguaje de Manipulación de Datos)*/
/*
Sentencias básicas para la gestión de datos que están basadas en operaciones con datos: CRUD
Create -> crear o insertar (ok)
Read -> leer o listar (ok)
Update -> actualizar o modificar (ok)
Delete -> eliminar o borrar (ok)
*/

## INSERCIÓN DE REGISTROS
-- INSERT INTO
/*
-- sintaxis:
INSERT INTO nombre_tabla
	(campo1, campo2, campo3, ...)
VALUES
	(dato1, dato2, dato3, ...);
*/
-- <> Insertar registros en tabla applicant
-- Ver estructura de la tabla applicant
DESCRIBE applicant;
-- Insertar un applicant
INSERT INTO applicant
	(name, lastname, sex, identification_document, document_number, email, cellphone, birthdate)
VALUES
	('Oscar Alberto', 'Ávila Reyes', 'M', 'DNI', '14853697', 'oscar@yahoo.com', '974512369', str_to_date('01/03/2008', '%d/%m/%Y')),
    ('María Luis', 'Barrios Campos', 'F', 'DNI', '77412589', 'maria.barrios@gmail.com', '984512368', str_to_date('01/05/2006', '%d/%m/%Y'));
    
## LISTAR REGISTROS
/* 
sintaxis:
SELECT nombre_columnas FROM nombre_tabla;
*/
-- Listar registros de applicants
SELECT * FROM applicant;
SELECT 
	name, 
    lastname, 
    birthdate 
FROM applicant;

## MODIFICAR O ACTUALIZAR REGISTROS
/*
sintaxis:
UPDATE nombre_tabla
SET
	campo = nuevo_dato,
    campo = nuevo_dato
WHERE
	campo = valor
*/
-- Describir tabla
DESCRIBE applicant;
-- Modificar datos
UPDATE applicant
SET identification_document = 'CNE', 
	document_number = '32659814785236995132'
WHERE id = 2;

UPDATE applicant
SET 
	name = 'María Luisa',
    email = 'maria.barrios@outlook.com'
WHERE id = 2;

-- Listar registros de applicants
SELECT * FROM applicant;

## Eliminar registros con DELETE
/*
	sintaxis:
    DELETE FROM nombre_tabla; // elimina físicamente todos los registros de una tabla
    DELETE FROM nombre_table
    WHERE campo = dato;
*/
-- Elimina un registro específico
DELETE FROM applicant
WHERE id = 1;

-- Elimina físicamente todos los registros
-- peeeero no reinicia el autoincrementable
DELETE FROM applicant;

-- Eliminar registros y reiniciar el autoincrementable
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE applicant;
SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM applicant;

DROP DATABASE dbConsultas_Carreras;



