## -----------------------------------------------------------------
-- Tema     : Relación entre Tablas desde Cero
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
-- Creación de tabla solicitante
CREATE TABLE IF NOT EXISTS applicant (
	id int auto_increment not null,
    registration_date timestamp DEFAULT current_timestamp,
    name varchar(60) not null,
    lastname varchar(100) not null,
    sex char(1) not null,
    identification_document char(3) not null,
    document_number char(20) not null,
    email varchar(120),
    cellphone char(9) not null,
    birthdate date,
    state char(1) DEFAULT 'A',
    CONSTRAINT pk_applicant PRIMARY KEY (id)
) ENGINE=MyISAM;

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
    marital_status char(1),
    state char(1) DEFAULT 'A',
    CONSTRAINT pk_adviser PRIMARY KEY (id)
) ENGINE=MyISAM;

## RELACIONES ENTRE TABLAS
-- 1. Las tablas puedes estar relaciondas de: Uno a Uno, Uno a Varios y Varios a Varios
-- 2. La cardinalidad más utilizada es la de Uno a Varios.
-- 3. Ayudan a estructurar y organizar los datos de manera lógica, evitando la redundancia.
-- 4. Permiten implementar restricciones de integridad referencial, asegurando que las referencias entre tablas sean válidas.
-- 5. Permiten realizar consultas más complejas que combinan datos de diferentes tablas

## RELACIÓN DE UNO A VARIOS
-- Refleja con precisión la mayoría las estructuras de datos del mundo real.
-- Las tablas a relacionar deben estar basadas en el motor de almacenamiento InnoDB.
-- Se requiere dos tablas, una tabla con la clave principal (PK) y otra tabla con la clave foránea(FK)
-- Los campos (PK y FK) deben tener el mismo tipo de dato y tamaño.

## RELACIONAR TABLAS: applicant con consultation
-- Verificamos el motor de almacenamiento de las tablas:
-- Tabla applicant
SHOW TABLE STATUS LIKE 'applicant';
-- Tabla consultations
SHOW TABLE STATUS LIKE 'consultation';

-- Cambiamos motor de almacenamiento de tabla applicant
ALTER TABLE applicant ENGINE=InnoDB;

-- Estableciendo la relación entre applicant y consultation
ALTER TABLE consultation
ADD CONSTRAINT fk_applicant_consultation
FOREIGN KEY (applicant) REFERENCES applicant(id);

## RELACIONAR TABLAS: career con consultation
-- Verificamos el motor de almacenamiento de las tablas:
-- Tabla career
SHOW TABLE STATUS LIKE 'career';
-- Tabla consultations
SHOW TABLE STATUS LIKE 'consultation';

-- Cambiamos motor de almacenamiento de tabla career
ALTER TABLE career ENGINE=InnoDB;

-- Estableciendo la relación entre career y consultation
ALTER TABLE consultation
ADD CONSTRAINT fk_career_consultation
FOREIGN KEY (career) REFERENCES career(id);

## RELACIONAR TABLAS: adviser con consultation
-- Verificamos el motor de almacenamiento de las tablas:
-- Tabla adviser
SHOW TABLE STATUS LIKE 'adviser';
-- Tabla consultations
SHOW TABLE STATUS LIKE 'consultation';

-- Cambiamos motor de almacenamiento de tabla applicant
ALTER TABLE adviser ENGINE=InnoDB;

-- Estableciendo la relación entre applicant y consultation
ALTER TABLE consultation
ADD CONSTRAINT fk_adviser_consultation
FOREIGN KEY (adviser) REFERENCES adviser(id);

## LISTANDO RELACIONES DE LA BD
-- Nos permite verificar las relaciones creadas en dbConsultas_Carreras
SELECT 
    kcu.CONSTRAINT_NAME AS 'Nombre de Relación',
    kcu.REFERENCED_TABLE_NAME AS 'Tabla Padre',
    kcu.REFERENCED_COLUMN_NAME AS 'Primary Key',
    kcu.TABLE_NAME AS 'Tabla Hija',
    kcu.COLUMN_NAME AS 'Foreign Key'
FROM 
    information_schema.KEY_COLUMN_USAGE AS kcu
WHERE 
    kcu.TABLE_SCHEMA = 'dbConsultas_Carreras' 
    AND kcu.REFERENCED_TABLE_NAME IS NOT NULL;







