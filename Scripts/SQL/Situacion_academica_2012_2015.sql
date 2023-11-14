CREATE OR REPLACE TABLE `04_gender_career_choices.Situacion_academica_2012_2020`
options () as
WITH 
SITUA_2012 AS (
SELECT * FROM (
      SELECT
      COD_INST,
      COD_COL,
      right(COD_GRAD, 2) COD_GRAD,
      COD_NIVE,
      (IFNULL(APROB_H, 0) + IFNULL(REPROB_H, 0) + IFNULL(TRANS_H, 0)) AS TOT_MALE,
      (IFNULL(APROB_M, 0) + IFNULL(REPROB_M, 0) + IFNULL(TRANS_M, 0)) AS TOT_FEMALE,
      PERIOD_OF_REFERENCE,
      CASE
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '01' THEN 'Preschool'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '02' THEN 'Primary School'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '03' THEN 'Basic-Secondary School'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '04' THEN 'Secondary School'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '05' THEN 'Academic Secondary School'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '10' THEN 'Technical Secondary School'
        ELSE NULL
      END AS COD_NIVE_NAME,
      CASE
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '01' THEN 'Preescolar'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '02' THEN 'Básica primaria'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '03' THEN 'Básica secundaria'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '04' THEN 'Media'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '05' THEN 'Media académica'
        WHEN REGEXP_EXTRACT(COD_NIVE, r'^(\d{2})') = '10' THEN 'Media técnica'
        ELSE NULL
      END AS COD_NIVE_NOMBRE,
      APROB_H,
      APROB_M,
      REPROB_H,
      REPROB_M,
      DESER_H,
      DESER_M,
      TRANS_H,
      TRANS_M,
       

    FROM
      `ph-jabri.C600.situacion_academica_tradicional_2012`

 ) WHERE  COD_NIVE  NOT IN ('01', 'Ciclos Lectivos Integrados') AND COD_GRAD !='99'
),


REPRO_ AS (
SELECT 
SEDE_CODIGO COD_INST,
SEDE_CODIGO COD_COL,
GRADO_CODIGO COD_GRAD,
      CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%'  THEN '01'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN '02'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria'  THEN '03'
        WHEN NIVELENSE_NOMBRE LIKE  'Media'THEN '04'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN '05'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN '10'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Ciclos Lectivos Integrados'
        ELSE NULL
      END         COD_NIVE,
 NULL TOT_MALE,

 NULL TOT_FEMALE,

  PERIOD_OF_REFERENCE, 
CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%' THEN 'Preschool'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN 'Elementary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria' THEN 'Basic-Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media' THEN 'Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN 'Academic Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN   'Technical Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Integrated academic cycles'
        ELSE NULL
      END COD_NIVE_NAME,
      CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%'  THEN 'Preescolar'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN 'Básica Primaria'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria'  THEN 'Básica Secundaria'
        WHEN NIVELENSE_NOMBRE LIKE  'Media'THEN 'Media'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN 'Media académica'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN 'Media Técnica'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Ciclos Lectivos Integrados'
        ELSE NULL
      END  COD_NIVE_NOMBRE,
 
JORNSITU_CANTIDAD_HOMBRE REPROB_H,
JORNSITU_CANTIDAD_MUJER REPROB_M,
 


FROM   
     ( SELECT SEDE_CODIGO,   GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2013' PERIOD_OF_REFERENCE
            FROM  `ph-jabri.C600.situacion_academica_tradicional_2013`
     UNION ALL 
     SELECT SEDE_CODIGO,   GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2014' PERIOD_OF_REFERENCE
       FROM  `ph-jabri.C600.situacion_academica_tradicional_2014`
     UNION ALL 
     SELECT SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2015' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2015`
           UNION ALL 
     SELECT SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2017' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2017`
      UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2018' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2018`
     UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2019' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2019`
     UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2020' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2020`      
      )
WHERE SITUACADE_NOMBRE = 'Reprobados'
AND NIVELENSE_NOMBRE  NOT LIKE  '%Preescolar%'  AND NIVELENSE_NOMBRE NOT LIKE '%CLEI%' 

),
APRO AS (
SELECT 
SEDE_CODIGO COD_INST,
SEDE_CODIGO COD_COL,
GRADO_CODIGO COD_GRAD,
      CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%'  THEN '01'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN '02'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria'  THEN '03'
        WHEN NIVELENSE_NOMBRE LIKE  'Media'THEN '04'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN '05'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN '10'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Ciclos Lectivos Integrados'
        ELSE NULL
      END         COD_NIVE,
 

  PERIOD_OF_REFERENCE, 
CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%' THEN 'Preschool'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN 'Elementary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria' THEN 'Basic-Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media' THEN 'Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN 'Academic Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN   'Technical Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Integrated academic cycles'
        ELSE NULL
      END COD_NIVE_NAME,
      CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%'  THEN 'Preescolar'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN 'Básica Primaria'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria'  THEN 'Básica Secundaria'
        WHEN NIVELENSE_NOMBRE LIKE  'Media'THEN 'Media'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN 'Media académica'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN 'Media Técnica'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Ciclos Lectivos Integrados'
        ELSE NULL
      END  COD_NIVE_NOMBRE,
 
JORNSITU_CANTIDAD_HOMBRE APROB_H,
JORNSITU_CANTIDAD_MUJER APROB_M,
 

FROM   
  ( SELECT SEDE_CODIGO,   GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2013' PERIOD_OF_REFERENCE
            FROM  `ph-jabri.C600.situacion_academica_tradicional_2013`
     UNION ALL 
     SELECT SEDE_CODIGO,   GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2014' PERIOD_OF_REFERENCE
       FROM  `ph-jabri.C600.situacion_academica_tradicional_2014`
     UNION ALL 
     SELECT SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2015' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2015`
           UNION ALL 
     SELECT SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2017' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2017`
      UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2018' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2018`
     UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2019' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2019`
     UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2020' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2020`      
      )
WHERE SITUACADE_NOMBRE = 'Aprobados'
AND NIVELENSE_NOMBRE  NOT LIKE  '%Preescolar%'  AND NIVELENSE_NOMBRE NOT LIKE '%CLEI%' 
),
DES AS (
SELECT 
SEDE_CODIGO COD_INST,
SEDE_CODIGO COD_COL,
GRADO_CODIGO COD_GRAD,
      CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%'  THEN '01'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN '02'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria'  THEN '03'
        WHEN NIVELENSE_NOMBRE LIKE  'Media'THEN '04'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN '05'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN '10'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Ciclos Lectivos Integrados'
        ELSE NULL
      END         COD_NIVE,
 

  PERIOD_OF_REFERENCE, 
CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%' THEN 'Preschool'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN 'Elementary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria' THEN 'Basic-Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media' THEN 'Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN 'Academic Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN   'Technical Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Integrated academic cycles'
        ELSE NULL
      END COD_NIVE_NAME,
      CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%'  THEN 'Preescolar'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN 'Básica Primaria'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria'  THEN 'Básica Secundaria'
        WHEN NIVELENSE_NOMBRE LIKE  'Media'THEN 'Media'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN 'Media académica'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN 'Media Técnica'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Ciclos Lectivos Integrados'
        ELSE NULL
      END  COD_NIVE_NOMBRE,
 
JORNSITU_CANTIDAD_HOMBRE DESER_H,
JORNSITU_CANTIDAD_MUJER DESER_M,
 

FROM   
  ( SELECT SEDE_CODIGO,   GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2013' PERIOD_OF_REFERENCE
            FROM  `ph-jabri.C600.situacion_academica_tradicional_2013`
     UNION ALL 
     SELECT SEDE_CODIGO,   GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2014' PERIOD_OF_REFERENCE
       FROM  `ph-jabri.C600.situacion_academica_tradicional_2014`
     UNION ALL 
     SELECT SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2015' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2015`
           UNION ALL 
     SELECT SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2017' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2017`
      UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2018' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2018`
     UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2019' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2019`
     UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2020' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2020`      
      )
WHERE SITUACADE_NOMBRE = 'Desertores'
AND NIVELENSE_NOMBRE  NOT LIKE  '%Preescolar%'  AND NIVELENSE_NOMBRE NOT LIKE '%CLEI%' 
),

TRANS AS (
SELECT 
SEDE_CODIGO COD_INST,
SEDE_CODIGO COD_COL,
GRADO_CODIGO COD_GRAD,
      CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%'  THEN '01'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN '02'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria'  THEN '03'
        WHEN NIVELENSE_NOMBRE LIKE  'Media'THEN '04'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN '05'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN '10'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Ciclos Lectivos Integrados'
        ELSE NULL
      END     
          COD_NIVE,
 
  PERIOD_OF_REFERENCE, 
CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%' THEN 'Preschool'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN 'Elementary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria' THEN 'Basic-Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media' THEN 'Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN 'Academic Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN   'Technical Secondary School'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Integrated academic cycles'
        ELSE NULL
      END COD_NIVE_NAME,
      CASE
        WHEN NIVELENSE_NOMBRE LIKE '%Preescolar%'  THEN 'Preescolar'
        WHEN NIVELENSE_NOMBRE LIKE '%primaria%' THEN 'Básica Primaria'
        WHEN NIVELENSE_NOMBRE LIKE  'Básica secundaria'  THEN 'Básica Secundaria'
        WHEN NIVELENSE_NOMBRE LIKE  'Media'THEN 'Media'
        WHEN NIVELENSE_NOMBRE LIKE  'Media académica' THEN 'Media académica'
        WHEN NIVELENSE_NOMBRE LIKE  'Media técnica' THEN 'Media Técnica'
        WHEN NIVELENSE_NOMBRE LIKE '%CLEI%' THEN 'Ciclos Lectivos Integrados'
        ELSE NULL
      END  COD_NIVE_NOMBRE,
 
JORNSITU_CANTIDAD_HOMBRE TRANS_H,
JORNSITU_CANTIDAD_MUJER TRANS_M,
 


FROM   
  ( SELECT SEDE_CODIGO,   GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2013' PERIOD_OF_REFERENCE
            FROM  `ph-jabri.C600.situacion_academica_tradicional_2013`
     UNION ALL 
     SELECT SEDE_CODIGO,   GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2014' PERIOD_OF_REFERENCE
       FROM  `ph-jabri.C600.situacion_academica_tradicional_2014`
     UNION ALL 
     SELECT SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2015' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2015`
           UNION ALL 
     SELECT SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2017' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2017`
      UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2018' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2018`
     UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2019' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2019`
     UNION ALL 
     SELECT CAST(SEDE_CODIGO AS STRING) SEDE_CODIGO,  GRADO_CODIGO , NIVELENSE_NOMBRE , JORNSITU_CANTIDAD_HOMBRE, JORNSITU_CANTIDAD_MUJER ,SITUACADE_NOMBRE , '2020' PERIOD_OF_REFERENCE
      FROM  `ph-jabri.C600.situacion_academica_tradicional_2020`      
      )
WHERE SITUACADE_NOMBRE LIKE '%ransferidos%'
AND NIVELENSE_NOMBRE  NOT LIKE  '%Preescolar%'  AND NIVELENSE_NOMBRE NOT LIKE '%CLEI%' 
),

DES_JOIN AS (
SELECT 
 
    A.COD_COL|| ' - '||A.COD_GRAD ID1,
 

DES.*

 FROM  (SELECT    distinct    COD_COL, COD_GRAD,   FROM SITUA_2012) A
LEFT JOIN  DES
ON  
   A.COD_COL = DES.COD_COL AND
   A.COD_GRAD = DES.COD_GRAD  
 ),
REPRO_DES AS (
SELECT     A.COD_COL|| ' - '||A.COD_GRAD ID2,
          A.COD_INST,
          A.COD_COL,
          A.COD_GRAD,
          A.COD_NIVE,
          A.PERIOD_OF_REFERENCE,
          A.COD_NIVE_NAME,
          A.COD_NIVE_NOMBRE,
          A.DESER_H,
          A.DESER_M,      
          REPROB_H,
          REPROB_M,
 FROM DES_JOIN A
LEFT JOIN  REPRO_ DES
ON  
   A.COD_COL = DES.COD_COL AND
   A.COD_GRAD = DES.COD_GRAD  AND
   A.PERIOD_OF_REFERENCE = DES.PERIOD_OF_REFERENCE
   ) ,
REPRO_DES_APRO AS (
  SELECT A.COD_COL|| ' - '||A.COD_GRAD ID2,
          A.COD_INST,
          A.COD_COL,
          A.COD_GRAD,
          A.COD_NIVE,
          A.PERIOD_OF_REFERENCE,
          A.COD_NIVE_NAME,
          A.COD_NIVE_NOMBRE,
          A.DESER_H,
          A.DESER_M,      
          A.REPROB_H,
          A.REPROB_M,
          APROB_H,
          APROB_M,
            FROM REPRO_DES A
LEFT JOIN  APRO DES
ON  
   A.COD_COL = DES.COD_COL AND
   A.COD_GRAD = DES.COD_GRAD  AND
   A.PERIOD_OF_REFERENCE = DES.PERIOD_OF_REFERENCE
) ,
TABLA_AFTER_2013 AS (
  SELECT DISTINCT A.COD_COL|| ' - '||A.COD_GRAD ID2,
          A.COD_INST,
          A.COD_COL,
          A.COD_GRAD,
          A.COD_NIVE,
          A.PERIOD_OF_REFERENCE,
          A.COD_NIVE_NAME,
          A.COD_NIVE_NOMBRE,
          A.DESER_H,
          A.DESER_M,      
          A.REPROB_H,
          A.REPROB_M,
          A.APROB_H,
          A.APROB_M,
          TRANS_H,
          TRANS_M, FROM REPRO_DES_APRO A
LEFT JOIN  TRANS DES
ON  
   A.COD_COL = DES.COD_COL AND
   A.COD_GRAD = DES.COD_GRAD  AND
   A.PERIOD_OF_REFERENCE = DES.PERIOD_OF_REFERENCE
),
situacion_academica as (
  SELECT
COD_INST,
COD_COL,
COD_GRAD,
COD_NIVE,
APROB_H +REPROB_H+DESER_H+TRANS_H TOT_MALE,
APROB_M +REPROB_M+DESER_M+TRANS_M TOT_FEMALE,
PERIOD_OF_REFERENCE,
COD_NIVE_NAME,
COD_NIVE_NOMBRE,
APROB_H,
APROB_M,
REPROB_H,
REPROB_M,
DESER_H,
DESER_M,
TRANS_H,
TRANS_M, 

 FROM TABLA_AFTER_2013

 UNION ALL 
 SELECT * FROM SITUA_2012
)
select * from situacion_academica