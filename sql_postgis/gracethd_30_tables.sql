/*GraceTHD-MCD v2.0.2-rc1*/
/*Creation des tables*/
/* gracethd_30_tables.sql */
/*PostGIS*/

/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 21/01/2019 */

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
	
DROP TABLE IF EXISTS t_cheminement CASCADE;	
DROP TABLE IF EXISTS t_conduite CASCADE;	
DROP TABLE IF EXISTS t_cond_chem CASCADE;	
DROP TABLE IF EXISTS t_cable CASCADE;	
DROP TABLE IF EXISTS t_cableline CASCADE;	
DROP TABLE IF EXISTS t_cab_cond CASCADE;	
DROP TABLE IF EXISTS t_fibre CASCADE;	
DROP TABLE IF EXISTS t_cassette CASCADE;	
DROP TABLE IF EXISTS t_position CASCADE;	
DROP TABLE IF EXISTS t_ropt CASCADE;	
DROP TABLE IF EXISTS t_noeud CASCADE;	
DROP TABLE IF EXISTS t_ptech CASCADE;	
DROP TABLE IF EXISTS t_masque CASCADE;	
DROP TABLE IF EXISTS t_love CASCADE;	
DROP TABLE IF EXISTS t_ebp CASCADE;	
DROP TABLE IF EXISTS t_sitetech CASCADE;	
DROP TABLE IF EXISTS t_ltech CASCADE;	
DROP TABLE IF EXISTS t_baie CASCADE;	
DROP TABLE IF EXISTS t_tiroir CASCADE;	
DROP TABLE IF EXISTS t_equipement CASCADE;	
DROP TABLE IF EXISTS t_reference CASCADE;	
DROP TABLE IF EXISTS t_suf CASCADE;	
DROP TABLE IF EXISTS t_adresse CASCADE;	
DROP TABLE IF EXISTS t_siteemission CASCADE;	
DROP TABLE IF EXISTS t_organisme CASCADE;	
DROP TABLE IF EXISTS t_znro CASCADE;	
DROP TABLE IF EXISTS t_zsro CASCADE;	
DROP TABLE IF EXISTS t_zpbo CASCADE;	
DROP TABLE IF EXISTS t_zdep CASCADE;	
DROP TABLE IF EXISTS t_zcoax CASCADE;	
DROP TABLE IF EXISTS t_document CASCADE;	
DROP TABLE IF EXISTS t_docobj CASCADE;	
DROP TABLE IF EXISTS t_empreinte CASCADE;	
	
CREATE TABLE t_adresse(	ad_code VARCHAR (254) NOT NULL  ,
	ad_ban_id VARCHAR (24)   ,
	ad_nomvoie VARCHAR (254)   ,
	ad_fantoir VARCHAR (10)   ,
	ad_numero INTEGER   ,
	ad_rep VARCHAR (20)   ,
	ad_insee VARCHAR(6)   ,
	ad_postal VARCHAR(20)   ,
	ad_alias VARCHAR(254)   ,
	ad_nom_ld VARCHAR(254)   ,
	ad_x_ban NUMERIC   ,
	ad_y_ban NUMERIC   ,
	ad_commune VARCHAR (254)   ,
	ad_section VARCHAR (5)   ,
	ad_idpar VARCHAR (20)   ,
	ad_x_parc NUMERIC   ,
	ad_y_parc NUMERIC   ,
	ad_nat BOOLEAN   ,
	ad_nblhab INTEGER   ,
	ad_nblpro INTEGER   ,
	ad_nbprhab INTEGER   ,
	ad_nbprpro INTEGER   ,
	ad_rivoli VARCHAR (254)   ,
	ad_hexacle VARCHAR (254)   ,
	ad_hexaclv VARCHAR (254)   ,
	ad_distinf NUMERIC   ,
	ad_isole BOOLEAN   ,
	ad_prio BOOLEAN   ,
	ad_racc VARCHAR(2)   REFERENCES l_implantation_type(code),
	ad_batcode VARCHAR(100)   ,
	ad_nombat VARCHAR(254)   ,
	ad_ietat VARCHAR(2)   REFERENCES l_adresse_etat(code),
	ad_itypeim VARCHAR (1)   REFERENCES l_immeuble_type(code),
	ad_imneuf BOOLEAN   ,
	ad_idatimn DATE   ,
	ad_prop VARCHAR (254)   ,
	ad_gest VARCHAR (20)   ,
	ad_idatsgn DATE   ,
	ad_iaccgst BOOLEAN   ,
	ad_idatcab DATE   ,
	ad_idatcom DATE   ,
	ad_typzone VARCHAR (1)   REFERENCES l_zone_densite(code),
	ad_comment VARCHAR(254)   ,
	ad_geolqlt NUMERIC(6,2)   ,
	ad_geolmod VARCHAR(4)   REFERENCES l_geoloc_mode(code),
	ad_geolsrc VARCHAR(254)   ,
	ad_creadat TIMESTAMP   ,
	ad_majdate TIMESTAMP   ,
	ad_majsrc VARCHAR(254)   ,
	ad_abddate DATE   ,
	ad_abdsrc VARCHAR(254)   ,
	geom Geometry(Point,2154) NOT NULL  ,
CONSTRAINT "t_adresse_pk" PRIMARY KEY (ad_code));	
	
CREATE TABLE t_organisme(	or_code VARCHAR (20) NOT NULL  ,
	or_siren VARCHAR(9)   ,
	or_nom VARCHAR(254) NOT NULL  ,
	or_type VARCHAR(254)   ,
	or_activ VARCHAR(254)   ,
	or_l331 VARCHAR(254)   ,
	or_siret VARCHAR(14)   ,
	or_nometab VARCHAR(254)   ,
	or_ad_code VARCHAR(254)   REFERENCES t_adresse(ad_code),
	or_nomvoie VARCHAR (254)   ,
	or_numero INTEGER   ,
	or_rep VARCHAR (20)   ,
	or_local VARCHAR(254)   ,
	or_postal VARCHAR(20)   ,
	or_commune VARCHAR (254)   ,
	or_telfixe VARCHAR(20)   ,
	or_mail VARCHAR(254)   ,
	or_comment VARCHAR(254)   ,
	or_creadat TIMESTAMP   ,
	or_majdate TIMESTAMP   ,
	or_majsrc VARCHAR(254)   ,
	or_abddate DATE   ,
	or_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_organisme_pk" PRIMARY KEY (or_code));	
	
CREATE TABLE t_reference(	rf_code VARCHAR(254) NOT NULL  ,
	rf_type VARCHAR(2)   REFERENCES l_reference_type (code),
	rf_fabric VARCHAR(20)   REFERENCES t_organisme (or_code),
	rf_design VARCHAR(254)   ,
	rf_etat VARCHAR(1)   REFERENCES l_reference_etat (code),
	rf_comment VARCHAR(254)   ,
	rf_creadat TIMESTAMP   ,
	rf_majdate TIMESTAMP   ,
	rf_majsrc VARCHAR(254)   ,
	rf_abddate DATE   ,
	rf_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_reference_pk" PRIMARY KEY (rf_code));	
	
CREATE TABLE t_noeud(	nd_code VARCHAR(254) NOT NULL  ,
	nd_codeext VARCHAR(254)   ,
	nd_nom VARCHAR(254)   ,
	nd_coderat VARCHAR(254)   ,
	nd_r1_code VARCHAR(100)   ,
	nd_r2_code VARCHAR(100)   ,
	nd_r3_code VARCHAR(100)   ,
	nd_r4_code VARCHAR(100)   ,
	nd_voie VARCHAR(254)   ,
	nd_type VARCHAR(2)   REFERENCES l_noeud_type (code),
	nd_type_ep VARCHAR (3)   REFERENCES l_technologie_type (code),
	nd_comment VARCHAR(254)   ,
	nd_dtclass VARCHAR(2)   REFERENCES l_geoloc_classe(code),
	nd_geolqlt NUMERIC(6,2)   ,
	nd_geolmod VARCHAR(4)   REFERENCES l_geoloc_mode(code),
	nd_geolsrc VARCHAR(254)   ,
	nd_creadat TIMESTAMP   ,
	nd_majdate TIMESTAMP   ,
	nd_majsrc VARCHAR(254)   ,
	nd_abddate DATE   ,
	nd_abdsrc VARCHAR(254)   ,
	geom Geometry(Point,2154) NOT NULL  ,
CONSTRAINT "t_noeud_pk" PRIMARY KEY (nd_code));	
	
CREATE TABLE t_znro(	zn_code VARCHAR(254) NOT NULL  ,
	zn_nd_code VARCHAR(254) NOT NULL  REFERENCES t_noeud (nd_code),
	zn_r1_code VARCHAR(100)   ,
	zn_r2_code VARCHAR(100)   ,
	zn_r3_code VARCHAR(100)   ,
	zn_r4_code VARCHAR(100)   ,
	zn_nroref VARCHAR(15)   ,
	zn_nrotype VARCHAR(7)   REFERENCES l_nro_type(code),
	zn_etat VARCHAR(2)   REFERENCES l_nro_etat(code),
	zn_etatlpm VARCHAR(2)   REFERENCES l_nro_etat(code),
	zn_datelpm DATE   ,
	zn_comment VARCHAR(254)   ,
	zn_geolsrc VARCHAR(254)   ,
	zn_creadat TIMESTAMP   ,
	zn_majdate TIMESTAMP   ,
	zn_majsrc VARCHAR(254)   ,
	zn_abddate DATE   ,
	zn_abdsrc VARCHAR(254)   ,
	geom geometry(MultiPolygon,2154)   ,
CONSTRAINT "t_znro_pk" PRIMARY KEY (zn_code));	
	
CREATE TABLE t_zsro(	zs_code VARCHAR(254) NOT NULL  ,
	zs_nd_code VARCHAR(254) NOT NULL  REFERENCES t_noeud (nd_code),
	zs_zn_code VARCHAR(254)   REFERENCES t_znro (zn_code),
	zs_r1_code VARCHAR(100)   ,
	zs_r2_code VARCHAR(100)   ,
	zs_r3_code VARCHAR(100)   ,
	zs_r4_code VARCHAR(100)   ,
	zs_refpm VARCHAR(20)   ,
	zs_etatpm VARCHAR(2)   REFERENCES l_sro_etat(code),
	zs_dateins DATE   ,
	zs_typeemp VARCHAR(3)   REFERENCES l_sro_emplacement(code),
	zs_capamax INTEGER   ,
	zs_ad_code VARCHAR(254)   REFERENCES t_adresse(ad_code),
	zs_typeing VARCHAR(254)   ,
	zs_nblogmt INTEGER   ,
	zs_nbcolmt INTEGER   ,
	zs_datcomr DATE   ,
	zs_actif BOOLEAN   ,
	zs_datemad DATE   ,
	zs_accgest BOOLEAN   ,
	zs_brassoi BOOLEAN   ,
	zs_comment VARCHAR(254)   ,
	zs_geolsrc VARCHAR(254)   ,
	zs_creadat TIMESTAMP   ,
	zs_majdate TIMESTAMP   ,
	zs_majsrc VARCHAR(254)   ,
	zs_abddate DATE   ,
	zs_abdsrc VARCHAR(254)   ,
	geom geometry(MultiPolygon,2154)   ,
CONSTRAINT "t_zsro_pk" PRIMARY KEY (zs_code));	
	
CREATE TABLE t_zpbo(	zp_code VARCHAR(254) NOT NULL  ,
	zp_nd_code VARCHAR(254) NOT NULL  REFERENCES t_noeud (nd_code),
	zp_zs_code VARCHAR(254)   REFERENCES t_zsro (zs_code),
	zp_r1_code VARCHAR(100)   ,
	zp_r2_code VARCHAR(100)   ,
	zp_r3_code VARCHAR(100)   ,
	zp_r4_code VARCHAR(100)   ,
	zp_capamax INTEGER   ,
	zp_comment VARCHAR(254)   ,
	zp_geolsrc VARCHAR(254)   ,
	zp_creadat TIMESTAMP   ,
	zp_majdate TIMESTAMP   ,
	zp_majsrc VARCHAR(254)   ,
	zp_abddate DATE   ,
	zp_abdsrc VARCHAR(254)   ,
	geom geometry(MultiPolygon,2154)   ,
CONSTRAINT "t_zpbo_pk" PRIMARY KEY (zp_code));	
	
CREATE TABLE t_zdep(	zd_code VARCHAR(254) NOT NULL  ,
	zd_nd_code VARCHAR(254)   REFERENCES t_noeud (nd_code),
	zd_zs_code VARCHAR(254)   REFERENCES t_zsro (zs_code),
	zd_r1_code VARCHAR(100)   ,
	zd_r2_code VARCHAR(100)   ,
	zd_r3_code VARCHAR(100)   ,
	zd_r4_code VARCHAR(100)   ,
	zd_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	zd_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	zd_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	zd_comment VARCHAR(254)   ,
	zd_geolsrc VARCHAR(254)   ,
	zd_creadat TIMESTAMP   ,
	zd_majdate TIMESTAMP   ,
	zd_majsrc VARCHAR(254)   ,
	zd_abddate DATE   ,
	zd_abdsrc VARCHAR(254)   ,
	geom geometry(MultiPolygon,2154)   ,
CONSTRAINT "t_zdep_pk" PRIMARY KEY (zd_code));	
	
CREATE TABLE t_zcoax(	zc_code VARCHAR(254) NOT NULL  ,
	zc_codeext VARCHAR(254)   ,
	zc_nd_code VARCHAR(254)   REFERENCES t_noeud (nd_code),
	zc_r1_code VARCHAR(100)   ,
	zc_r2_code VARCHAR(100)   ,
	zc_r3_code VARCHAR(100)   ,
	zc_r4_code VARCHAR(100)   ,
	zc_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	zc_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	zc_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	zc_comment VARCHAR(254)   ,
	zc_geolsrc VARCHAR(254)   ,
	zc_creadat TIMESTAMP   ,
	zc_majdate TIMESTAMP   ,
	zc_majsrc VARCHAR(254)   ,
	zc_abddate DATE   ,
	zc_abdsrc VARCHAR(254)   ,
	geom geometry(MultiPolygon,2154)   ,
CONSTRAINT "t_zcoax_pk" PRIMARY KEY (zc_code));	
	
CREATE TABLE t_sitetech(	st_code VARCHAR(254) NOT NULL  ,
	st_nd_code VARCHAR(254) NOT NULL  REFERENCES t_noeud (nd_code),
	st_codeext VARCHAR (254)   ,
	st_nom VARCHAR (254)   ,
	st_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	st_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	st_user VARCHAR(20)   REFERENCES t_organisme (or_code),
	st_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	st_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	st_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	st_dateins DATE   ,
	st_datemes DATE   ,
	st_avct VARCHAR(1)   REFERENCES l_avancement(code),
	st_typephy VARCHAR(3) NOT NULL  REFERENCES l_site_type_phy (code),
	st_typelog VARCHAR(10) NOT NULL  REFERENCES l_site_type_log (code),
	st_nblines INTEGER   ,
	st_ad_code VARCHAR(254)   REFERENCES t_adresse (ad_code),
	st_comment VARCHAR(254)   ,
	st_creadat TIMESTAMP   ,
	st_majdate TIMESTAMP   ,
	st_majsrc VARCHAR(254)   ,
	st_abddate DATE   ,
	st_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_sitetech_pk" PRIMARY KEY (st_code));	
	
CREATE TABLE t_ltech(	lt_code VARCHAR(254) NOT NULL  ,
	lt_codeext VARCHAR(254)   ,
	lt_etiquet VARCHAR(254)   ,
	lt_st_code VARCHAR(254) NOT NULL  REFERENCES t_sitetech (st_code),
	lt_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	lt_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	lt_user VARCHAR(20)   REFERENCES t_organisme (or_code),
	lt_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	lt_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	lt_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	lt_dateins DATE   ,
	lt_datemes DATE   ,
	lt_local VARCHAR (254)   ,
	lt_elec BOOLEAN   ,
	lt_clim VARCHAR(6)   REFERENCES l_clim_type (code),
	lt_occp VARCHAR(10)   REFERENCES l_occupation_type (code),
	lt_idmajic VARCHAR(254)   ,
	lt_comment VARCHAR(254)   ,
	lt_creadat TIMESTAMP   ,
	lt_majdate TIMESTAMP   ,
	lt_majsrc VARCHAR(254)   ,
	lt_abddate DATE   ,
	lt_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_ltech_pk" PRIMARY KEY (lt_code));	
	
CREATE TABLE t_baie(	ba_code VARCHAR(254) NOT NULL  ,
	ba_codeext VARCHAR(254)   ,
	ba_etiquet VARCHAR(254)   ,
	ba_lt_code VARCHAR(254) NOT NULL  REFERENCES t_ltech (lt_code),
	ba_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	ba_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	ba_user VARCHAR(20)   REFERENCES t_organisme (or_code),
	ba_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	ba_statut VARCHAR(3)   REFERENCES l_statut (code),
	ba_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	ba_rf_code VARCHAR(254)   REFERENCES t_reference (rf_code),
	ba_type VARCHAR(10)   REFERENCES l_baie_type (code),
	ba_nb_u NUMERIC   ,
	ba_haut NUMERIC   ,
	ba_larg NUMERIC   ,
	ba_prof NUMERIC   ,
	ba_comment VARCHAR(254)   ,
	ba_creadat TIMESTAMP   ,
	ba_majdate TIMESTAMP   ,
	ba_majsrc VARCHAR(254)   ,
	ba_abddate DATE   ,
	ba_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_baie_pk" PRIMARY KEY (ba_code));	
	
CREATE TABLE t_tiroir(	ti_code VARCHAR(254) NOT NULL  ,
	ti_codeext VARCHAR(254)   ,
	ti_etiquet VARCHAR(254)   ,
	ti_ba_code VARCHAR(254) NOT NULL  REFERENCES t_baie (ba_code),
	ti_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	ti_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	ti_type VARCHAR(10)   REFERENCES l_tiroir_type (code),
	ti_rf_code VARCHAR(254)   REFERENCES t_reference (rf_code),
	ti_taille NUMERIC   ,
	ti_placemt NUMERIC   ,
	ti_localis VARCHAR(254)   ,
	ti_comment VARCHAR(254)   ,
	ti_creadat TIMESTAMP   ,
	ti_majdate TIMESTAMP   ,
	ti_majsrc VARCHAR(254)   ,
	ti_abddate DATE   ,
	ti_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_tiroir_pk" PRIMARY KEY (ti_code));	
	
CREATE TABLE t_equipement(	eq_code VARCHAR(254) NOT NULL  ,
	eq_codeext VARCHAR(254)   ,
	eq_etiquet VARCHAR(254)   ,
	eq_ba_code VARCHAR(254) NOT NULL  REFERENCES t_baie (ba_code),
	eq_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	eq_rf_code VARCHAR(254)   REFERENCES t_reference (rf_code),
	eq_dateins DATE   ,
	eq_datemes DATE   ,
	eq_comment VARCHAR(254)   ,
	eq_creadat TIMESTAMP   ,
	eq_majdate TIMESTAMP   ,
	eq_majsrc VARCHAR(254)   ,
	eq_abddate DATE   ,
	eq_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_equipement_pk" PRIMARY KEY (eq_code));	
	
CREATE TABLE t_suf(	sf_code VARCHAR(254) NOT NULL  ,
	sf_nd_code VARCHAR(254)   REFERENCES t_noeud (nd_code),
	sf_ad_code VARCHAR(254)   REFERENCES t_adresse (ad_code),
	sf_zp_code VARCHAR(254)   REFERENCES t_zpbo (zp_code),
	sf_escal VARCHAR (20)   ,
	sf_etage VARCHAR (20)   ,
	sf_oper VARCHAR(20)   REFERENCES t_organisme (or_code),
	sf_type VARCHAR(1) NOT NULL  REFERENCES l_suf_type (code),
	sf_prop VARCHAR(254)   ,
	sf_resid VARCHAR(254)   ,
	sf_local VARCHAR (254)   ,
	sf_racco VARCHAR(2)   REFERENCES l_suf_racco(code),
	sf_comment VARCHAR(254)   ,
	sf_creadat TIMESTAMP   ,
	sf_majdate TIMESTAMP   ,
	sf_majsrc VARCHAR(254)   ,
	sf_abddate DATE   ,
	sf_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_suf_pk" PRIMARY KEY (sf_code));	
	
CREATE TABLE t_ptech(	pt_code VARCHAR(254) NOT NULL  ,
	pt_codeext Varchar(254)   ,
	pt_etiquet VARCHAR(254)   ,
	pt_nd_code VARCHAR(254) NOT NULL  REFERENCES t_noeud (nd_code),
	pt_ad_code VARCHAR(254)   REFERENCES t_adresse(ad_code),
	pt_gest_do VARCHAR(20)   REFERENCES t_organisme (or_code),
	pt_prop_do VARCHAR(20)   REFERENCES t_organisme (or_code),
	pt_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	pt_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	pt_user VARCHAR(20)   REFERENCES t_organisme (or_code),
	pt_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	pt_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	pt_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	pt_dateins DATE   ,
	pt_datemes Date   ,
	pt_avct VARCHAR(1)   REFERENCES l_avancement(code),
	pt_typephy VARCHAR(1) NOT NULL  REFERENCES l_ptech_type_phy (code),
	pt_typelog VARCHAR(1) NOT NULL  REFERENCES l_ptech_type_log (code),
	pt_rf_code VARCHAR(254)   REFERENCES t_reference (rf_code),
	pt_nature VARCHAR (20)   REFERENCES l_ptech_nature (code),
	pt_secu BOOLEAN   ,
	pt_occp VARCHAR(10)   REFERENCES l_occupation_type (code),
	pt_a_dan NUMERIC   ,
	pt_a_dtetu DATE   ,
	pt_a_struc VARCHAR(100)   ,
	pt_a_haut NUMERIC(5,2)   ,
	pt_a_passa BOOLEAN   ,
	pt_a_strat BOOLEAN   ,
	pt_rotatio NUMERIC(5,2)   ,
	pt_detec BOOLEAN   ,
	pt_comment VARCHAR(254)   ,
	pt_creadat TIMESTAMP   ,
	pt_majdate TIMESTAMP   ,
	pt_majsrc VARCHAR(254)   ,
	pt_abddate DATE   ,
	pt_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_ptech_pk" PRIMARY KEY (pt_code));	
	
CREATE TABLE t_ebp(	bp_code VARCHAR(254) NOT NULL  ,
	bp_etiquet VARCHAR(254)   ,
	bp_codeext VARCHAR(254)   ,
	bp_pt_code VARCHAR(254)   REFERENCES t_ptech(pt_code),
	bp_lt_code VARCHAR(254)   REFERENCES t_ltech(lt_code),
	bp_sf_code VARCHAR(254)   REFERENCES t_suf(sf_code),
	bp_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	bp_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	bp_user VARCHAR(20)   REFERENCES t_organisme (or_code),
	bp_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	bp_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	bp_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	bp_occp VARCHAR(10)   REFERENCES l_occupation_type (code),
	bp_datemes Date   ,
	bp_avct VARCHAR(1)   REFERENCES l_avancement(code),
	bp_typephy VARCHAR(5)   REFERENCES l_bp_type_phy (code),
	bp_typelog VARCHAR(3) NOT NULL  REFERENCES l_bp_type_log (code),
	bp_rf_code VARCHAR(254)   REFERENCES t_reference (rf_code),
	bp_entrees INTEGER   ,
	bp_ref_kit VARCHAR(30)   ,
	bp_ca_nb INTEGER   ,
	bp_nb_pas INTEGER   ,
	bp_linecod VARCHAR(30)   ,
	bp_oc_code VARCHAR(50)   ,
	bp_racco VARCHAR(6)   REFERENCES l_bp_racco(code),
	bp_comment VARCHAR(254)   ,
	bp_creadat TIMESTAMP   ,
	bp_majdate TIMESTAMP   ,
	bp_majsrc VARCHAR(254)   ,
	bp_abddate DATE   ,
	bp_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_ebp_pk" PRIMARY KEY (bp_code));	
	
CREATE TABLE t_cassette(	cs_code VARCHAR(254) NOT NULL  ,
	cs_nb_pas INTEGER   ,
	cs_bp_code VARCHAR(254) NOT NULL  REFERENCES t_ebp (bp_code),
	cs_num INTEGER   ,
	cs_type VARCHAR(1)   REFERENCES l_cassette_type (code),
	cs_face VARCHAR(20)   ,
	cs_rf_code VARCHAR(254)   REFERENCES t_reference (rf_code),
	cs_comment VARCHAR(254)   ,
	cs_creadat TIMESTAMP   ,
	cs_majdate TIMESTAMP   ,
	cs_majsrc VARCHAR(254)   ,
	cs_abddate DATE   ,
	cs_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_cassette_pk" PRIMARY KEY (cs_code));	
	
CREATE TABLE t_cheminement(	cm_code VARCHAR(254) NOT NULL  ,
	cm_codeext VARCHAR(254)   ,
	cm_ndcode1 VARCHAR(254)   REFERENCES t_noeud(nd_code),
	cm_ndcode2 VARCHAR(254)   REFERENCES t_noeud(nd_code),
	cm_cm1 VARCHAR(254)   ,
	cm_cm2 VARCHAR(254)   ,
	cm_r1_code VARCHAR(100)   ,
	cm_r2_code VARCHAR(100)   ,
	cm_r3_code VARCHAR(100)   ,
	cm_r4_code VARCHAR(100)   ,
	cm_voie VARCHAR(254)   ,
	cm_gest_do VARCHAR(20)   REFERENCES t_organisme (or_code),
	cm_prop_do VARCHAR(20)   REFERENCES t_organisme (or_code),
	cm_statut VARCHAR(3)   REFERENCES l_statut (code),
	cm_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	cm_datcons DATE   ,
	cm_datemes DATE   ,
	cm_avct VARCHAR(1)   REFERENCES l_avancement(code),
	cm_typelog VARCHAR(2)   REFERENCES l_infra_type_log (code),
	cm_typ_imp VARCHAR(2)   REFERENCES l_implantation_type (code),
	cm_nature VARCHAR(3)   REFERENCES l_infra_nature (code),
	cm_compo VARCHAR(254)   ,
	cm_cddispo INTEGER   ,
	cm_fo_util INTEGER   ,
	cm_mod_pos VARCHAR(20)   REFERENCES l_pose_type(code),
	cm_passage VARCHAR(10)   REFERENCES l_passage_type(code),
	cm_revet VARCHAR(254)   ,
	cm_remblai VARCHAR(254)   ,
	cm_charge NUMERIC(5,2)   ,
	cm_larg NUMERIC(4,2)   ,
	cm_fildtec BOOLEAN   ,
	cm_mut_org VARCHAR(20)   REFERENCES t_organisme (or_code),
	cm_long NUMERIC(8,2)   ,
	cm_lgreel NUMERIC(8,2)   ,
	cm_comment VARCHAR(254)   ,
	cm_dtclass VARCHAR(2)   REFERENCES l_geoloc_classe(code),
	cm_geolqlt NUMERIC(6,2)   ,
	cm_geolmod VARCHAR(4)   REFERENCES l_geoloc_mode(code),
	cm_geolsrc VARCHAR(254)   ,
	cm_creadat TIMESTAMP   ,
	cm_majdate TIMESTAMP   ,
	cm_majsrc VARCHAR(254)   ,
	cm_abddate DATE   ,
	cm_abdsrc VARCHAR(254)   ,
	geom Geometry(Linestring,2154) NOT NULL  ,
CONSTRAINT "t_cheminement_pk" PRIMARY KEY (cm_code));	
	
CREATE TABLE t_conduite(	cd_code VARCHAR(254) NOT NULL  ,
	cd_codeext Varchar(254)   ,
	cd_etiquet VARCHAR(254)   ,
	cd_cd_code VARCHAR(254)   ,
	cd_r1_code VARCHAR(100)   ,
	cd_r2_code VARCHAR(100)   ,
	cd_r3_code VARCHAR(100)   ,
	cd_r4_code VARCHAR(100)   ,
	cd_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	cd_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	cd_user VARCHAR(20)   REFERENCES t_organisme (or_code),
	cd_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	cd_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	cd_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	cd_dateaig DATE   ,
	cd_dateman DATE   ,
	cd_datemes Date   ,
	cd_avct VARCHAR(1)   REFERENCES l_avancement(code),
	cd_type VARCHAR(10) NOT NULL  REFERENCES l_conduite_type (code),
	cd_dia_int INTEGER   ,
	cd_dia_ext INTEGER   ,
	cd_color VARCHAR(254)   ,
	cd_long NUMERIC(8,2)   ,
	cd_nbcable INTEGER   ,
	cd_occup NUMERIC(3,0)   ,
	cd_comment VARCHAR(254)   ,
	cd_creadat TIMESTAMP   ,
	cd_majdate TIMESTAMP   ,
	cd_majsrc VARCHAR(254)   ,
	cd_abddate DATE   ,
	cd_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_conduite_pk" PRIMARY KEY (cd_code));	
	
CREATE TABLE t_cond_chem(	dm_cd_code VARCHAR(254) NOT NULL  REFERENCES t_conduite(cd_code),
	dm_cm_code VARCHAR(254) NOT NULL  REFERENCES t_cheminement(cm_code),
	dm_creadat TIMESTAMP   ,
	dm_majdate TIMESTAMP   ,
	dm_majsrc VARCHAR(254)   ,
	dm_abddate DATE   ,
	dm_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_cond_chem_pk" PRIMARY KEY (dm_cd_code, dm_cm_code));	
	
CREATE TABLE t_masque(	mq_id BIGINT NOT NULL  ,
	mq_nd_code VARCHAR(254) NOT NULL  REFERENCES t_noeud (nd_code),
	mq_face VARCHAR(1) NOT NULL  REFERENCES l_masque_face (code),
	mq_col INTEGER NOT NULL  ,
	mq_ligne INTEGER NOT NULL  ,
	mq_cd_code VARCHAR(254)   REFERENCES t_conduite (cd_code),
	mq_qualinf VARCHAR(3)   REFERENCES l_qualite_info(code),
	mq_comment VARCHAR(254)   ,
	mq_creadat TIMESTAMP   ,
	mq_majdate TIMESTAMP   ,
	mq_majsrc VARCHAR(254)   ,
	mq_abddate DATE   ,
	mq_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_masque_pk" PRIMARY KEY (mq_id));	
	
CREATE TABLE t_cable(	cb_code VARCHAR(254) NOT NULL  ,
	cb_codeext VARCHAR(254)   ,
	cb_etiquet VARCHAR(254)   ,
	cb_nd1 VARCHAR(254)   REFERENCES t_noeud(nd_code),
	cb_nd2 VARCHAR(254)   REFERENCES t_noeud(nd_code),
	cb_r1_code VARCHAR(100)   ,
	cb_r2_code VARCHAR(100)   ,
	cb_r3_code VARCHAR(100)   ,
	cb_r4_code VARCHAR(100)   ,
	cb_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	cb_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	cb_user VARCHAR(20)   REFERENCES t_organisme (or_code),
	cb_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	cb_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	cb_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	cb_dateins DATE   ,
	cb_datemes DATE   ,
	cb_avct VARCHAR(1)   REFERENCES l_avancement(code),
	cb_tech VARCHAR(3)   REFERENCES l_technologie_type (code),
	cb_typephy VARCHAR(1) NOT NULL  REFERENCES l_cable_type (code),
	cb_typelog VARCHAR(2)   REFERENCES l_infra_type_log (code),
	cb_rf_code VARCHAR(254)   REFERENCES t_reference (rf_code),
	cb_capafo INTEGER   ,
	cb_fo_disp INTEGER   ,
	cb_fo_util INTEGER   ,
	cb_modulo INTEGER   ,
	cb_diam NUMERIC   ,
	cb_color VARCHAR(254)   ,
	cb_lgreel NUMERIC   ,
	cb_localis VARCHAR(254)   ,
	cb_comment VARCHAR(254)   ,
	cb_creadat TIMESTAMP   ,
	cb_majdate TIMESTAMP   ,
	cb_majsrc VARCHAR(254)   ,
	cb_abddate DATE   ,
	cb_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_cable_pk" PRIMARY KEY (cb_code));	
	
CREATE TABLE t_cableline(	cl_code VARCHAR(254) NOT NULL  ,
	cl_cb_code VARCHAR (254) NOT NULL UNIQUE REFERENCES t_cable(cb_code),
	cl_long NUMERIC   ,
	cl_comment VARCHAR(254)   ,
	cl_dtclass VARCHAR(2)   REFERENCES l_geoloc_classe(code),
	cl_geolqlt NUMERIC(6,2)   ,
	cl_geolmod VARCHAR(4)   REFERENCES l_geoloc_mode(code),
	cl_geolsrc VARCHAR(254)   ,
	cl_creadat TIMESTAMP   ,
	cl_majdate TIMESTAMP   ,
	cl_majsrc VARCHAR(254)   ,
	cl_abddate DATE   ,
	cl_abdsrc VARCHAR(254)   ,
	geom Geometry(Linestring,2154) NOT NULL  ,
CONSTRAINT "t_cableline_pk" PRIMARY KEY (cl_code));	
	
CREATE TABLE t_cab_cond(	cc_cb_code VARCHAR(254) NOT NULL  REFERENCES t_cable(cb_code),
	cc_cd_code VARCHAR(254) NOT NULL  REFERENCES t_conduite(cd_code),
	cc_creadat TIMESTAMP   ,
	cc_majdate TIMESTAMP   ,
	cc_majsrc VARCHAR(254)   ,
	cc_abddate DATE   ,
	cc_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_cab_cond_pk" PRIMARY KEY (cc_cb_code, cc_cd_code));	
	
CREATE TABLE t_love(	lv_id BIGINT NOT NULL  ,
	lv_cb_code VARCHAR(254) NOT NULL  REFERENCES t_cable (cb_code),
	lv_nd_code VARCHAR(254) NOT NULL  REFERENCES t_noeud (nd_code),
	lv_long INTEGER   ,
	lv_creadat TIMESTAMP   ,
	lv_majdate TIMESTAMP   ,
	lv_majsrc VARCHAR(254)   ,
	lv_abddate DATE   ,
	lv_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_love_pk" PRIMARY KEY (lv_id));	
	
CREATE TABLE t_fibre(	fo_code VARCHAR(254) NOT NULL  ,
	fo_code_ext VARCHAR(254)   ,
	fo_cb_code VARCHAR(254) NOT NULL  REFERENCES t_cable (cb_code),
	fo_nincab INTEGER   ,
	fo_numtub INTEGER   ,
	fo_nintub INTEGER   ,
	fo_type VARCHAR(20)   REFERENCES l_fo_type (code),
	fo_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	fo_color VARCHAR(10)   REFERENCES l_fo_color(code),
	fo_reper VARCHAR(5)   REFERENCES l_tube (code),
	fo_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	fo_comment VARCHAR(254)   ,
	fo_creadat TIMESTAMP   ,
	fo_majdate TIMESTAMP   ,
	fo_majsrc VARCHAR(254)   ,
	fo_abddate DATE   ,
	fo_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_fibre_pk" PRIMARY KEY (fo_code));	
	
CREATE TABLE t_position(	ps_code VARCHAR(254) NOT NULL  ,
	ps_numero INTEGER   ,
	ps_1 VARCHAR (254)   REFERENCES t_fibre (fo_code),
	ps_2 VARCHAR (254)   REFERENCES t_fibre (fo_code),
	ps_cs_code VARCHAR(254)   REFERENCES t_cassette (cs_code),
	ps_ti_code VARCHAR(254)   REFERENCES t_tiroir (ti_code),
	ps_type VARCHAR(10)   REFERENCES l_position_type (code),
	ps_fonct VARCHAR(2)   REFERENCES l_position_fonction (code),
	ps_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	ps_preaff VARCHAR(50)   ,
	ps_comment VARCHAR(254)   ,
	ps_creadat TIMESTAMP   ,
	ps_majdate TIMESTAMP   ,
	ps_majsrc VARCHAR(254)   ,
	ps_abddate DATE   ,
	ps_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_position_pk" PRIMARY KEY (ps_code));	
	
CREATE TABLE t_ropt(	rt_id BIGINT NOT NULL  ,
	rt_code VARCHAR(254) NOT NULL  ,
	rt_code_ext VARCHAR(254)   ,
	rt_fo_code VARCHAR(254) NOT NULL  REFERENCES t_fibre (fo_code),
	rt_fo_ordr INTEGER   ,
	rt_comment VARCHAR(254)   ,
	rt_creadat TIMESTAMP   ,
	rt_majdate TIMESTAMP   ,
	rt_majsrc VARCHAR(254)   ,
	rt_abddate DATE   ,
	rt_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_ropt_pk" PRIMARY KEY (rt_id));	
	
CREATE TABLE t_siteemission(	se_code VARCHAR(254) NOT NULL  ,
	se_nd_code VARCHAR(254) NOT NULL UNIQUE REFERENCES t_noeud (nd_code),
	se_anfr VARCHAR(50)   ,
	se_prop VARCHAR(20)   REFERENCES t_organisme (or_code),
	se_gest VARCHAR(20)   REFERENCES t_organisme (or_code),
	se_user VARCHAR(20)   REFERENCES t_organisme (or_code),
	se_proptyp VARCHAR(3)   REFERENCES l_propriete_type (code),
	se_statut VARCHAR(3) NOT NULL  REFERENCES l_statut (code),
	se_etat VARCHAR(3)   REFERENCES l_etat_type (code),
	se_occp VARCHAR(10)   REFERENCES l_occupation_type (code),
	se_dateins DATE   ,
	se_datemes DATE   ,
	se_type VARCHAR(10) NOT NULL  REFERENCES l_site_emission_type (code),
	se_haut NUMERIC(5,2)   ,
	se_ad_code VARCHAR(254)   REFERENCES t_adresse(ad_code),
	se_comment VARCHAR(254)   ,
	se_creadat TIMESTAMP   ,
	se_majdate TIMESTAMP   ,
	se_majsrc VARCHAR(254)   ,
	se_abddate DATE   ,
	se_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_siteemission_pk" PRIMARY KEY (se_code));	
	
CREATE TABLE t_document(	do_code VARCHAR(254) NOT NULL  ,
	do_ref VARCHAR(254) NOT NULL UNIQUE ,
	do_reftier VARCHAR(254)   ,
	do_r1_code VARCHAR(100)   ,
	do_r2_code VARCHAR(100)   ,
	do_r3_code VARCHAR(100)   ,
	do_r4_code VARCHAR(100)   ,
	do_type VARCHAR(3)   REFERENCES l_doc_type (code),
	do_indice VARCHAR(3)   ,
	do_date DATE   ,
	do_classe VARCHAR(2)   ,
	do_url1 VARCHAR (254)   ,
	do_url2 VARCHAR (254)   ,
	do_comment VARCHAR(254)   ,
	do_creadat TIMESTAMP   ,
	do_majdate TIMESTAMP   ,
	do_majsrc VARCHAR(254)   ,
	do_abddate DATE   ,
	do_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_document_pk" PRIMARY KEY (do_code));	
	
CREATE TABLE t_docobj(	od_id BIGINT NOT NULL  ,
	od_do_code VARCHAR(254) NOT NULL  REFERENCES t_document (do_code),
	od_tbltype VARCHAR(2) NOT NULL  REFERENCES l_doc_tab (code),
	od_codeobj VARCHAR(254) NOT NULL  ,
	od_creadat TIMESTAMP   ,
	od_majdate TIMESTAMP   ,
	od_majsrc VARCHAR(254)   ,
	od_abddate DATE   ,
	od_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_docobj_pk" PRIMARY KEY (od_id));	
	
CREATE TABLE t_empreinte(	em_code VARCHAR(254) NOT NULL  ,
	em_do_code VARCHAR(254) NOT NULL  REFERENCES t_document (do_code),
	em_geolsrc VARCHAR(254)   ,
	em_creadat TIMESTAMP   ,
	em_majdate TIMESTAMP   ,
	em_majsrc VARCHAR(254)   ,
	em_abddate DATE   ,
	em_abdsrc VARCHAR(254)   ,
	geom geometry(MultiPolygon,2154)   ,
CONSTRAINT "t_empreinte_pk" PRIMARY KEY (em_code));	
