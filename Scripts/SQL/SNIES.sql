CREATE OR REPLACE TABLE   `ph-jabri.ICFES.SNIES_07_2O`
OPTIONS () AS 
WITH 
SNIES_200 AS (
SELECT 
'200'||_TABLE_SUFFIX  SUFIX, 
CAST( ANNIO AS STRING )  ANNIO,
SEMESTRE,
ID_IES,
REPLACE(`ph-jabri.udfs.homg_sintildes`(IES_NOMBRE), ',','')  IES_NOMBRE,
CASE WHEN LENGTH(CAST(ID_MUNICIPIO_IES AS STRING))<5 THEN '0'||CAST(ID_MUNICIPIO_IES AS STRING)
ELSE CAST(ID_MUNICIPIO_IES AS STRING) END ID_MUNICIPIO_IES,
REPLACE(`ph-jabri.udfs.homg_sintildes`(MUNICIPIO_IES), ',','') MUNICIPIO_IES,
ORIG_CODE,
ORIGEN,
TIPO_DOCUMENTO,
REPLACE(  REPLACE( REPLACE(NUM_DOCUMENTO, ' ', '') , ',', ''), '.', '')  NUM_DOCUMENTO,
PRIMER_NOMBRE,
SEGUNDO_NOMBRE,
PRIMER_APELLIDO,
SEGUNDO_APELLIDO,
 
CASE WHEN SEXO_BIOLOGICO LIKE 'M%' THEN 'M'
    WHEN SEXO_BIOLOGICO LIKE 'F%' THEN 'F' 
    ELSE NULL END SEXO_BIOLOGICO,
PARSE_DATE('%d/%m/%Y', CASE WHEN LENGTH(FECHA_NACIMIENTO) <= 4 THEN NULL ELSE FECHA_NACIMIENTO END ) FECHA_NACIMIENTO,
NOMBRE_PROGRAMA,
SAFE_CAST(ID_AREA_CONOCIMIENTO AS STRING) ID_AREA_CONOCIMIENTO,
REPLACE(`ph-jabri.udfs.homg_sintildes`(AREA_CONOCIMIENTO), ',','')AREA_CONOCIMIENTO,
ID_NBC,
REPLACE(`ph-jabri.udfs.homg_sintildes`(NBC), ',','') NBC,
CASE WHEN LENGTH(CAST(ID_MUN_PROGRAMA AS STRING))<5 THEN '0'||CAST(ID_MUN_PROGRAMA AS STRING)
ELSE CAST(ID_MUN_PROGRAMA AS STRING) END  ID_MUN_PROGRAMA,
REPLACE(`ph-jabri.udfs.homg_sintildes`(MUN_PROGRAMA), ',','') MUN_PROGRAMA
FROM `ph-jabri.SNIES.SNIES_200*` --WHERE SEMESTRE= 3
WHERE UPPER(NIVEL_PROGRAMA) != 'POSGRADO'
-- LIMIT 10
),
SNIES_201 AS (
SELECT 
'201'||_TABLE_SUFFIX  SUFIX, 
CAST( ANNIO AS STRING )  ANNIO,
SEMESTRE,
ID_IES,
REPLACE(`ph-jabri.udfs.homg_sintildes`(IES_NOMBRE), ',','')  IES_NOMBRE,
CASE WHEN LENGTH(CAST(ID_MUNICIPIO_IES AS STRING))<5 THEN '0'||CAST(ID_MUNICIPIO_IES AS STRING)
ELSE CAST(ID_MUNICIPIO_IES AS STRING) END ID_MUNICIPIO_IES,
REPLACE(`ph-jabri.udfs.homg_sintildes`(MUNICIPIO_IES), ',','') MUNICIPIO_IES,
ORIG_CODE,
REPLACE(`ph-jabri.udfs.homg_sintildes`(ORIGEN), ',','') ORIGEN,
REPLACE(`ph-jabri.udfs.homg_sintildes`(TIPO_DOCUMENTO), ',','') TIPO_DOCUMENTO,
REPLACE(  REPLACE( REPLACE(NUM_DOCUMENTO, ' ', '') , ',', ''), '.', '')  NUM_DOCUMENTO,
PRIMER_NOMBRE,
CASE WHEN LENGTH(SEGUNDO_NOMBRE)<=1 THEN '' ELSE SEGUNDO_NOMBRE END SEGUNDO_NOMBRE,
PRIMER_APELLIDO,
CASE WHEN LENGTH(SEGUNDO_APELLIDO)<=1 THEN '' ELSE SEGUNDO_APELLIDO END SEGUNDO_APELLIDO,
 
CASE WHEN SEXO_BIOLOGICO LIKE 'M%' THEN 'M'
    WHEN SEXO_BIOLOGICO LIKE 'F%' THEN 'F' 
    ELSE NULL END SEXO_BIOLOGICO,
PARSE_DATE('%d/%m/%Y', CASE WHEN LENGTH(FECHA_NACIMIENTO) <= 4 THEN NULL ELSE FECHA_NACIMIENTO END ) FECHA_NACIMIENTO,
NOMBRE_PROGRAMA,
SAFE_CAST(ID_AREA_CONOCIMIENTO AS STRING)  ID_AREA_CONOCIMIENTO,
REPLACE(`ph-jabri.udfs.homg_sintildes`(AREA_CONOCIMIENTO), ',','')AREA_CONOCIMIENTO,
ID_NBC,
REPLACE(`ph-jabri.udfs.homg_sintildes`(NBC), ',','') NBC,
CASE WHEN LENGTH(CAST(ID_MUN_PROGRAMA AS STRING))<5 THEN '0'||CAST(ID_MUN_PROGRAMA AS STRING)
ELSE CAST(ID_MUN_PROGRAMA AS STRING) END  ID_MUN_PROGRAMA,
REPLACE(`ph-jabri.udfs.homg_sintildes`(MUN_PROGRAMA), ',','') MUN_PROGRAMA
FROM `ph-jabri.SNIES.SNIES_201*`
WHERE _TABLE_SUFFIX <= '9'
AND UPPER(NIVEL_PROGRAMA) != 'POSGRADO'
-- LIMIT 10

),

SNIES_2020 AS (
SELECT 
'2020'  SUFIX, 
'2020'   ANNIO,
SEMESTRE,
ID_IES,
REPLACE(`ph-jabri.udfs.homg_sintildes`(IES_NOMBRE), ',','')  IES_NOMBRE,
CASE WHEN LENGTH(CAST(CODIGO_MUNICIPIO_IES AS STRING))<5 THEN '0'||CAST(CODIGO_MUNICIPIO_IES AS STRING)
ELSE CAST(CODIGO_MUNICIPIO_IES AS STRING) END ID_MUNICIPIO_IES,
REPLACE(`ph-jabri.udfs.homg_sintildes`(MUNICIPIO_IES), ',','') MUNICIPIO_IES,
ID_ORIGEN_IES ORIG_CODE,
REPLACE(`ph-jabri.udfs.homg_sintildes`(ORIGEN_IES), ',','') ORIGEN,
REPLACE(`ph-jabri.udfs.homg_sintildes`(DOCUMENTO_IDENTIFICACION), ',','') TIPO_DOCUMENTO,
REPLACE(  REPLACE( REPLACE(NUMERO_IDENTIFICACION, ' ', '') , ',', ''), '.', '')   NUM_DOCUMENTO,
PRIMER_NOMBRE,
CASE WHEN LENGTH(SEGUNDO_NOMBRE)<=1 THEN '' ELSE SEGUNDO_NOMBRE END SEGUNDO_NOMBRE,
PRIMER_APELLIDO,
CASE WHEN LENGTH(SEGUNDO_APELLIDO)<=1 THEN '' ELSE SEGUNDO_APELLIDO END SEGUNDO_APELLIDO,
 
CASE WHEN SEXO_BIOLOGICO LIKE 'H%' THEN 'M'
    WHEN SEXO_BIOLOGICO LIKE 'M%' THEN 'F' 
    ELSE NULL END SEXO_BIOLOGICO,
FECHA_NACIMIENTO FECHA_NACIMIENTO,
PROGRAMA NOMBRE_PROGRAMA,
SAFE_CAST(ID_AREA_CONOCIMINETO AS STRING) ID_AREA_CONOCIMIENTO,
REPLACE(`ph-jabri.udfs.homg_sintildes`(AREA_CONOCIMINETO), ',','')AREA_CONOCIMIENTO,
ID_NBC,
REPLACE(`ph-jabri.udfs.homg_sintildes`(NBC), ',','') NBC,
CASE WHEN LENGTH(CAST(CODIGO_MUNICIPIO_PROGRAMA AS STRING))<5 THEN '0'||CAST(CODIGO_MUNICIPIO_PROGRAMA AS STRING)
ELSE CAST(CODIGO_MUNICIPIO_PROGRAMA AS STRING) END  ID_MUN_PROGRAMA,
REPLACE(`ph-jabri.udfs.homg_sintildes`(MUNICIPIO_PROGRAMA), ',','') MUN_PROGRAMA
FROM `ph-jabri.SNIES.SNIES_2020`
 
WHERE NIVEL_PROGRAMA != 'POSGRADO'
--  
-- 
-- LIMIT 10

),
SNIES_2021 AS (
SELECT 
'2021'  SUFIX, 
'2021'   ANNIO,
SEMESTRE,
ID_IES,
REPLACE(`ph-jabri.udfs.homg_sintildes`(IES_NOMBRE), ',','')  IES_NOMBRE,
CASE WHEN LENGTH(CAST(CODIGO_MUNICIPIO_IES AS STRING))<5 THEN '0'||CAST(CODIGO_MUNICIPIO_IES AS STRING)
ELSE CAST(CODIGO_MUNICIPIO_IES AS STRING) END ID_MUNICIPIO_IES,
REPLACE(`ph-jabri.udfs.homg_sintildes`(MUNICIPIO_IES), ',','') MUNICIPIO_IES,
ID_ORIGEN_IES ORIG_CODE,
REPLACE(`ph-jabri.udfs.homg_sintildes`(ORIGEN_IES), ',','') ORIGEN,
REPLACE(`ph-jabri.udfs.homg_sintildes`(DOCUMENTO_IDENTIFICACION), ',','') TIPO_DOCUMENTO,
NUMERO_IDENTIFICACION NUM_DOCUMENTO,
PRIMER_NOMBRE,
CASE WHEN LENGTH(SEGUNDO_NOMBRE)<=1 THEN '' ELSE SEGUNDO_NOMBRE END SEGUNDO_NOMBRE,
PRIMER_APELLIDO,
CASE WHEN LENGTH(SEGUNDO_APELLIDO)<=1 THEN '' ELSE SEGUNDO_APELLIDO END SEGUNDO_APELLIDO,
 
CASE WHEN SEXO_BIOLOGICO LIKE 'H%' THEN 'M'
    WHEN SEXO_BIOLOGICO LIKE 'M%' THEN 'F' 
    ELSE NULL END SEXO_BIOLOGICO,
FECHA_NACIMIENTO FECHA_NACIMIENTO,
PROGRAMA NOMBRE_PROGRAMA,
SAFE_CAST(ID_AREA_CONOCIMINETO AS STRING) ID_AREA_CONOCIMIENTO,
REPLACE(`ph-jabri.udfs.homg_sintildes`(AREA_CONOCIMINETO), ',','')AREA_CONOCIMIENTO,
ID_NBC,
REPLACE(`ph-jabri.udfs.homg_sintildes`(NBC), ',','') NBC,
CASE WHEN LENGTH(CAST(CODIGO_MUNICIPIO_PROGRAMA AS STRING))<5 THEN '0'||CAST(CODIGO_MUNICIPIO_PROGRAMA AS STRING)
ELSE CAST(CODIGO_MUNICIPIO_PROGRAMA AS STRING) END  ID_MUN_PROGRAMA,
REPLACE(`ph-jabri.udfs.homg_sintildes`(MUNICIPIO_PROGRAMA), ',','') MUN_PROGRAMA
FROM `ph-jabri.SNIES.SNIES_2021`
 
WHERE NIVEL_PROGRAMA != 'POSGRADO'
 
-- LIMIT 10

),
SNIES AS (
    SELECT * FROM SNIES_200
        UNION ALL
    SELECT * FROM SNIES_201
        UNION ALL 
    SELECT * FROM SNIES_2021
            UNION ALL 
    SELECT * FROM SNIES_2020

)

SELECT   DISTINCT
*
FROM SNIES
