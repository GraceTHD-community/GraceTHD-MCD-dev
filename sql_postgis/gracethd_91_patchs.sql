/*GraceTHD-MCD v2.0.2-beta1*/
/*Patch : des tables optionnnelles comblant des lacunes de GraceTHD-MCD v2.0.0. Les attributs de ces tables intégreront très probablement les tables de la v2.1.0. */
/* gracethd_91_patchs.sql */
/*Postgis*/

/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 25/10/2018 */

/* ********************************************************************
    This file is part of GraceTHD.

    GraceTHD is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GraceTHD is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GraceTHD.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************** */

SET search_path TO gracethd, public;

/*###################### PATCHS 2.0.2 - DROP ##################################*/

DROP TABLE IF EXISTS t_adresse_patch202 CASCADE;
DROP TABLE IF EXISTS t_znro_patch202 CASCADE;
DROP TABLE IF EXISTS t_zsro_patch202 CASCADE;
DROP TABLE IF EXISTS t_zpbo_patch201 CASCADE;
DROP TABLE IF EXISTS t_sitetech_patch202 CASCADE;
DROP TABLE IF EXISTS t_ltech_patch201 CASCADE;
DROP TABLE IF EXISTS t_ltech_patch202 CASCADE;
DROP TABLE IF EXISTS t_equipement_patch202 CASCADE;
DROP TABLE IF EXISTS t_ptech_patch202 CASCADE;
DROP TABLE IF EXISTS t_cassette_patch201 CASCADE;
DROP TABLE IF EXISTS t_cable_patch201 CASCADE;
DROP TABLE IF EXISTS t_position_patch202 CASCADE;
DROP TABLE IF EXISTS t_siteemission_patch202 CASCADE;

/*###################### PATCHS 2.0.2 - CREATE ##################################*/

CREATE TABLE t_adresse_patch202(	ad_code VARCHAR(254) NOT NULL  REFERENCES t_adresse(ad_code),
	ad_nblpub INTEGER   ,
	ad_nbltec INTEGER   ,
	ad_nblope INTEGER   ,
	ad_nbprtte INTEGER   ,
	ad_nbprgfu INTEGER   ,
	ad_nbprtto INTEGER   ,
	ad_nbprfon INTEGER   ,
	ad_sracdem VARCHAR(1)   REFERENCES l_bool (code),
	ad_dta VARCHAR(1)   REFERENCES l_bool (code),
CONSTRAINT "t_adresse_patch202_pk" PRIMARY KEY (ad_code));	
	
CREATE TABLE t_znro_patch202(	zn_code VARCHAR(254) NOT NULL  REFERENCES t_znro(zn_code),
	zn_lt_code VARCHAR(254)   REFERENCES t_ltech(lt_code),
CONSTRAINT "t_znro_patch202_pk" PRIMARY KEY (zn_code));	
	
CREATE TABLE t_zsro_patch202(	zs_code VARCHAR(254) NOT NULL  REFERENCES t_zsro(zs_code),
	zs_lt_code VARCHAR(254)   REFERENCES t_ltech(lt_code),
	zs_lgmaxln NUMERIC(5,2)   ,
CONSTRAINT "t_zsro_patch202_pk" PRIMARY KEY (zs_code));	
	
CREATE TABLE t_zpbo_patch201(	zp_code VARCHAR(254) NOT NULL  REFERENCES t_zpbo(zp_code),
	zp_bp_code VARCHAR(254)   REFERENCES t_ebp(bp_code),
CONSTRAINT "t_zpbo_patch201_pk" PRIMARY KEY (zp_code));	
	
CREATE TABLE t_sitetech_patch202(	st_code VARCHAR(254) NOT NULL  REFERENCES t_sitetech(st_code),
	st_rf_code VARCHAR(254)   REFERENCES t_reference(rf_code),
	st_ban_id VARCHAR (24)   ,
	st_nomvoie VARCHAR (254)   ,
	st_numero INTEGER   ,
	st_rep VARCHAR (20)   ,
	st_postal VARCHAR(20)   ,
	st_insee VARCHAR(20)   ,
	st_commune VARCHAR (254)   ,
	st_section VARCHAR(5)   ,
	st_idpar VARCHAR (20)   ,
CONSTRAINT "t_sitetech_patch202_pk" PRIMARY KEY (st_code));	
	
CREATE TABLE t_ltech_patch201(	lt_code VARCHAR(254) NOT NULL  REFERENCES t_ltech(lt_code),
	lt_bat VARCHAR(100)   ,
	lt_escal VARCHAR(20)   ,
	lt_etage VARCHAR(20)   ,
CONSTRAINT "t_ltech_patch201_pk" PRIMARY KEY (lt_code));	
	
CREATE TABLE t_ltech_patch202(	lt_code VARCHAR(254) NOT NULL  REFERENCES t_ltech(lt_code),
	lt_nom VARCHAR(100)   ,
	lt_typephy VARCHAR(2)   REFERENCES l_ltech_typephy(code),
CONSTRAINT "t_ltech_patch202_pk" PRIMARY KEY (lt_code));	
	
CREATE TABLE t_equipement_patch202(	eq_code VARCHAR(254) NOT NULL  REFERENCES t_equipement(eq_code),
	eq_nom VARCHAR(100)   ,
	eq_desc VARCHAR(254)   ,
	eq_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	eq_taille NUMERIC   ,
	eq_placemt NUMERIC   ,
	eq_localis VARCHAR(254)   ,
CONSTRAINT "t_equipement_patch202_pk" PRIMARY KEY (eq_code));	
	
CREATE TABLE t_ptech_patch202(	pt_code VARCHAR(254) NOT NULL  REFERENCES t_ptech(pt_code),
	pt_codepro VARCHAR(254)   ,
	pt_codegst VARCHAR(254)   ,
	pt_nomvoie VARCHAR (254)   ,
	pt_numero INTEGER   ,
	pt_rep VARCHAR (20)   ,
	pt_local VARCHAR(254)   ,
	pt_postal VARCHAR(20)   ,
	pt_insee VARCHAR(20)   ,
	pt_commune VARCHAR (254)   ,
	pt_section VARCHAR(5)   ,
	pt_idpar VARCHAR (20)   ,
CONSTRAINT "t_ptech_patch202_pk" PRIMARY KEY (pt_code));	
	
CREATE TABLE t_cassette_patch201(	cs_code VARCHAR(254) NOT NULL  REFERENCES t_cassette(cs_code),
	cs_ti_code VARCHAR(254)   REFERENCES t_tiroir(ti_code),
CONSTRAINT "t_cassette_patch201_pk" PRIMARY KEY (cs_code));	
	
CREATE TABLE t_cable_patch201(	cb_code VARCHAR(254) NOT NULL  REFERENCES t_cable(cb_code),
	cb_bp1 VARCHAR(254)   REFERENCES t_ebp(bp_code),
	cb_ba1 VARCHAR(254)   REFERENCES t_baie(ba_code),
	cb_bp2 VARCHAR(254)   REFERENCES t_ebp(bp_code),
	cb_ba2 VARCHAR(254)   REFERENCES t_baie(ba_code),
CONSTRAINT "t_cable_patch201_pk" PRIMARY KEY (cb_code));	
	
CREATE TABLE t_position_patch202(	ps_code VARCHAR(254) NOT NULL  REFERENCES t_position(ps_code),
	ps_nom VARCHAR(100)   ,
	ps_lin INTEGER   ,
	ps_col INTEGER   ,
	ps_usetype VARCHAR(2)   REFERENCES l_position_usetype(code),
CONSTRAINT "t_position_patch202_pk" PRIMARY KEY (ps_code));	
	
CREATE TABLE t_siteemission_patch202(	se_code VARCHAR(254) NOT NULL  REFERENCES t_sitetech(st_code),
	se_ban_id VARCHAR (24)   ,
	se_nomvoie VARCHAR (254)   ,
	se_numero INTEGER   ,
	se_rep VARCHAR (20)   ,
	se_local VARCHAR(254)   ,
	se_postal VARCHAR(20)   ,
	se_insee VARCHAR(20)   ,
	se_commune VARCHAR (254)   ,
	se_section VARCHAR(5)   ,
	se_idpar VARCHAR (20)   ,
CONSTRAINT "t_siteemission_patch202_pk" PRIMARY KEY (se_code));	



/*###################### PATCHS 2.0.2 - INDEX ##################################*/
DROP INDEX IF EXISTS zn_lt_code_idx; CREATE INDEX  zn_lt_code_idx ON t_znro_patch202(zn_lt_code);



DROP INDEX IF EXISTS zs_lt_code_idx; CREATE INDEX  zs_lt_code_idx ON t_znro_patch202(zs_lt_code);




DROP INDEX IF EXISTS zp_bp_code_idx; CREATE INDEX  zp_bp_code_idx ON t_znro_patch202(zp_bp_code);



DROP INDEX IF EXISTS st_rf_code_idx; CREATE INDEX  st_rf_code_idx ON t_znro_patch202(st_rf_code);




















DROP INDEX IF EXISTS lt_typephy_idx; CREATE INDEX  lt_typephy_idx ON t_znro_patch202(lt_typephy);





DROP INDEX IF EXISTS eq_etat_idx; CREATE INDEX  eq_etat_idx ON t_znro_patch202(eq_etat);
























DROP INDEX IF EXISTS cb_bp1_idx; CREATE INDEX  cb_bp1_idx ON t_znro_patch202(cb_bp1);
DROP INDEX IF EXISTS cb_ba1_idx; CREATE INDEX  cb_ba1_idx ON t_znro_patch202(cb_ba1);
DROP INDEX IF EXISTS cb_bp2_idx; CREATE INDEX  cb_bp2_idx ON t_znro_patch202(cb_bp2);
DROP INDEX IF EXISTS cb_ba2_idx; CREATE INDEX  cb_ba2_idx ON t_znro_patch202(cb_ba2);






DROP INDEX IF EXISTS ps_usetype_idx; CREATE INDEX  ps_usetype_idx ON t_znro_patch202(ps_usetype);



