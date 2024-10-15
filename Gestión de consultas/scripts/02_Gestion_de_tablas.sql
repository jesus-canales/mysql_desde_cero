## -----------------------------------------------------------------
-- Tema     : Gestión de Tablas desde Cero
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

## Motor de almacenamiento
-- 1. Es responsable de cómo se almacenan, recuperan y gestionan los datos en MySQL.
-- 2. MySQL ofrece varios motores de almacenamiento: InnoDB, MyISAM, MEMORY, CSV, ARCHIVE, y FEDERATED.
-- 3. MySQL permite seleccionar el motor de almacenamiento para cada tabla de forma independiente.
-- 4. Cada motor te permite diseñar bases de datos más eficientes y adecuadas para tus aplicaciones.
-- 5. InnoDB: Soporta transacciones, integridad referencial y bloqueo a nivel de fila.
-- 6. MyISAM: Optimizado para lecturas rápidas y con un enfoque de solo lectura.
-- 7. Para listar los motores disponibles: SHOW ENGINES;

## GESTION DE TABLAS
-- 1. Es la estructura fundamental de una BD relacional.
-- 2. Las tablas están organizadas en filas(registros) y columnas(atributos).
-- 3. Permiten organizar, almacenar y acceder a los datos.
-- 4. Las tablas son la base sobre las que se ejecutan consultas SQL
-- 5. Su diseño y organización son cruciales para garantizar la eficiencia e integridad de datos.

#  CREAR TABLAS
-- Sintaxis: 
-- CREATE TABLE nombre_tabla (
--    columna1 tipo_datos [opciones],
--    columna2 tipo_datos [opciones],
--    columna3 tipo_datos [opciones],
--    ...
-- ) [Engine=tipo_motor];
-- Ejemplo:

-- Creación de tabla solicitante
CREATE TABLE applicant (
	id int auto_increment not null,
    registration_date timestamp DEFAULT current_timestamp,
    name varchar(60) not null,
    lastname varchar(100) not null,
    sex char(1) not null, 
    identification_document char(3) not null, 
    document_number char(15) not null, 
    email varchar(120),
    cellphone char(9) not null,
    state char(1) DEFAULT 'A',
    CONSTRAINT pk_applicant PRIMARY KEY (id)
) ENGINE=MyISAM;

-- Creación de tabla consulta
CREATE TABLE consultation (
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
)ENGINE=MyISAM;

-- Creación de tabla asesor
CREATE TABLE IF NOT EXISTS adviser (
	id int auto_increment not null,
    registration_date timestamp DEFAULT current_timestamp,
    name varchar(60) not null,
    lastname varchar(100) not null,
    identification_document char(3) not null,
    document_number char(15) not null,
    email varchar(60) not null,
    cellphone char(9) not null,
    state char(1) DEFAULT 'A',
    CONSTRAINT pk_adviser PRIMARY KEY (id)
) ENGINE=MyISAM;

## LISTAR TABLAS 
-- Sintaxis: SHOW TABLES;
-- Ejemplo:
SHOW TABLES;

## VER ESTRUCTURA DE TABLA
-- Sintaxis: DESCRIBE nombre_tabla;
-- Ejemplo:
DESCRIBE applicant;

#  AGREGAR COLUMNA A TABLA
-- Sintaxis: 
-- ALTER TABLE nombre_tabla (
-- ADD COLUMN columna1 tipo_datos [opciones];
-- Ejemplo 01: Agregar columna fecha de nacimiento en la tabla applicant
ALTER TABLE applicant
ADD COLUMN birthdate date;
DESCRIBE applicant;

-- Ejemplo 02: Agregar columna estado civil en tabla asesor
ALTER TABLE adviser
ADD COLUMN marital_status char(1);
DESCRIBE adviser;

#  MODIFICAR COLUMNA DE TABLA
-- Sintaxis: 
-- ALTER TABLE nombre_tabla (
-- MODIFY COLUMN nuevo_nombre_columna nuevo_tipo_datos [nuevas_opciones];
-- Ejemplo: Modificar a 20 caracteres el campo número de documento en tabla solicitante
ALTER TABLE applicant
MODIFY COLUMN document_number char(20);
DESCRIBE applicant;

#  ELIMINAR COLUMNA DE TABLA
-- Sintaxis: 
-- ALTER TABLE nombre_tabla (
-- DROP COLUMN nombre_columna;
-- Ejemplo: Eliminar la columna estado civil en tabla asesor
ALTER TABLE adviser
DROP COLUMN marital_status;
DESCRIBE adviser;

#  ELIMINAR TABLA
-- Sintaxis: 
-- DROP TABLE nombre_tabla;
-- Ejemplo: Eliminar la tabla carrera
DROP TABLE career;
SHOW TABLES;

-- Elimina una tabla siempre y cuando exista
DROP TABLE IF EXISTS career;