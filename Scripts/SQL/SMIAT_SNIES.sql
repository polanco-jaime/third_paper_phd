CREATE OR REPLACE TABLE  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES`
OPTIONS () AS
WITH
SIMAT AS (
        SELECT * FROM   `ph-jabri.ICFES.SIMAT`  --WHERE YEAR_INFO = '2012'
),
SIMAT_SNIES_ID1 AS (
SELECT * FROM SIMAT 
LEFT JOIN `ph-jabri.ICFES.SNIES_07_2O_IDS` 
ON ID1 = nro_documento

),
SIMAT_SNIES_ID2 AS (
SELECT * FROM SIMAT 
LEFT JOIN `ph-jabri.ICFES.SNIES_07_2O_IDS` 
ON  ID2 = nro_documento
),
SIMAT_SNIES AS (
SELECT 
codigo_dane,
codigo_dane_sede,
cons_sede,
nro_documento,
apellido1,
apellido2,
nombre1,
nombre2,
grupo,
genero,
anno_inf,
YEAR_INFO,
FECHA_NACIMIENTO_SIMAT,
EDAD,
'X' START_SNIES,
SUFIX,
ANNIO,
ID_IES,
IES_NOMBRE,
ID_MUNICIPIO_IES,
MUNICIPIO_IES,
ORIG_CODE,
ORIGEN,
IDS,
STRING_AGG( DISTINCT PRIMER_NOMBRE) PRIMER_NOMBRE,
STRING_AGG( DISTINCT SEGUNDO_NOMBRE ) SEGUNDO_NOMBRE,
STRING_AGG( DISTINCT PRIMER_APELLIDO ) PRIMER_APELLIDO,
STRING_AGG( DISTINCT SEGUNDO_APELLIDO ) SEGUNDO_APELLIDO,
STRING_AGG( DISTINCT SEXO_BIOLOGICO) SEXO_BIOLOGICO,
 FECHA_NACIMIENTO,
NOMBRE_PROGRAMA,
ID_AREA_CONOCIMIENTO,
ID_NBC,
NBC,
ID_MUN_PROGRAMA,
MUN_PROGRAMA,
AREA_CONOCIMIENTO,
LEVEL,

-- RN,
 (   CASE WHEN LEFT(REPLACE(PRIMER_NOMBRE,' ', ''), 2)  IS NOT NULL 
        THEN LEFT(REPLACE(nombre1,' ', ''), 2) = 
                LEFT(REPLACE(PRIMER_NOMBRE,' ', ''), 2) 
        ELSE NULL END ) SAME_NAME,
STRING_AGG( DISTINCT IFNULL(ID1, ID2) ) ID_SNIES ,
-- 
FROM(
        SELECT * FROM  SIMAT_SNIES_ID1
        UNION ALL 
        SELECT * FROM  SIMAT_SNIES_ID2
)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22 ,23,24, 30,31,32,33,34,35,36,37,38,39
)

SELECT * FROM (
  SELECT * ,
ROW_NUMBER() OVER (PARTITION BY nro_documento, YEAR_INFO ORDER BY ID_SNIES NULLS LAST, ID_NBC nulls last ) AS RN

FROM SIMAT_SNIES

)
 WHERE RN=      1
-- where nro_documento = '1000018473'



