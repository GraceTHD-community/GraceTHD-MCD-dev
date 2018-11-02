/* Exemple de script de création d'une base GraceTHD et du schéma gracethd */
/* GraceTHD utilise gracethd_pg_create_db.bat, ce script SQL n'est pas utilisé par le batch */

--CREATE DATABASE gracethd20ct;

CREATE EXTENSION postgis; 

CREATE SCHEMA IF NOT EXISTS gracethd
--AUTHORIZATION postgres
;

