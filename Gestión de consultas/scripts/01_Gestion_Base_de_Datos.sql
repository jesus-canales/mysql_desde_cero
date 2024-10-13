## -----------------------------------------------------------------
-- Tema     : Creación de Base de Datos desde Cero
-- Curso    : Base de Datos 1
-- SGBD     : MySQL 5x
-- Profesor : Jesús Canales G.
-- ----------------------------------------------------------------- ##

## ## MySQL ¿POR QUÉ?
-- 1. Es uno de los SGBD más populares en el mundo.
-- 2. MySQL Community Edition (5.x) VS MySQL Enterprise Edition (8.x)
-- 3. Existe una gran comunidad y documentación disponible.
-- 4. Se integra facilmente con lenguajes de programación populares.
-- 5. Se adapta a una gran variedad de aplicaciones simples y complejas.

## ## GESTION DE BASE DE DATOS
-- Es el contenedor principal de todos los objetos de una base de datos.
-- Objetos: tablas, vistas, cursores, índices, procedimientos almacenados, etc.

#  CREAR BASE DE DATOS (Lenguaje SQL)
-- Sintaxis: CREATE DATABASE nombre_de_tu_base_de_datos;
-- Ejemplo:
CREATE DATABASE dbConsultas_Carreras;

#  ARCHIVOS FISICOS DE LA BD
-- Los archivos físicos tienen la extensión: opt, frm e ibd.
-- Sintaxis:
SHOW VARIABLES LIKE 'datadir';

#  PONER EN USO BASE DE DATOS
-- Sintaxis: USE nombre_de_tu_base_de_datos;
-- Ejemplo:
USE dbConsultas_Carreras;

#  INVENTARIO DE BASE DE DATOS
-- Sintaxis: SHOW DATABASES;
-- Ejemplo:
SHOW DATABASES;

#  ELIMINAR BASE DE DATOS
-- Antes de eliminar una base de datos, esta no debe estar en uso.
-- Para saber que base de datos está en uso utilice: SELECT DATABASE();
-- Poner otra base de datos en uso: USE sakila;
-- Para eliminar una base de datos utilice DROP DATABASE.
-- -- Sintaxis: DROP DATABASE nombre_de_tu_base_de_datos;
-- -- Ejemplo:
DROP DATABASE dbConsultas_Carreras;
-- Verificar si se ha eliminado haciendo un listado de base de datos.
-- Ejemplo: SHOW DATABASES;
-- Tener presente que el eliminado es una operación irreversible.

### CREACIÓN DE BASE DE DATOS PRO
CREATE DATABASE IF NOT EXISTS dbConsultas_Carreras 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_spanish_ci;
USE dbConsultas_Carreras;
###


