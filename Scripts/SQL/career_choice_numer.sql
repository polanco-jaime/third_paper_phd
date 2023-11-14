CREATE OR REPLACE TABLE `ph-jabri.04_gender_career_choices.career_choice_numer`
OPTIONS () AS 
WITH 
Years AS (
  SELECT '2012' AS Year
  UNION ALL SELECT '2013'
  UNION ALL  SELECT '2014'
  UNION ALL  SELECT '2015'
  UNION ALL  SELECT '2016'
  UNION ALL  SELECT '2017'
  UNION ALL  SELECT '2018'
  UNION ALL  SELECT '2019'
  UNION ALL  SELECT '2020'
),
Sexos AS (
  SELECT 'F' AS Sexo
  UNION ALL
  SELECT 'M'
),
UNIQUE_SCHOOLS AS (
  SELECT DISTINCT 
codigo_dane_sede   
 FROM `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
),
UNIQUE_SCHOOLS_SEX_YEAR AS ( 
SELECT * FROM UNIQUE_SCHOOLS
INNER JOIN Years ON 1=1
INNER JOIN Sexos  ON  1=1
),
ENROLLED_IN_ENG_ARCHITECTURE_URBAN_ AS (
SELECT codigo_dane_sede   ID_1_2012,

YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, SEXO_BIOLOGICO,  
IFNULL(SUM(case when AREA_CONOCIMIENTO = 'ENGINEERING, ARCHITECTURE, URBAN PLANNING, AND RELATED FIELDS'  
then 1 else 0 end), 0) ENROLLED_IN_ENG_ARCHITECTURE_URBAN
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
WHERE LEVEL = 'University Program'  AND AREA_CONOCIMIENTO = 'ENGINEERING, ARCHITECTURE, URBAN PLANNING, AND RELATED FIELDS'  
GROUP BY 1,2 ,3
) ,
ENROLLED_IN_EDUCATION_SCIENCES_ AS (
SELECT codigo_dane_sede   ID_1_2012,
YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, SEXO_BIOLOGICO,  
IFNULL(SUM(case when AREA_CONOCIMIENTO = 'EDUCATION SCIENCES'  
then 1 else 0 end), 0) ENROLLED_IN_EDUCATION_SCIENCES
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
WHERE LEVEL = 'University Program'  AND AREA_CONOCIMIENTO = 'EDUCATION SCIENCES'  
GROUP BY 1,2 ,3
) ,
ENROLLED_IN_AGRO_ AS (
SELECT codigo_dane_sede   ID_1_2012,
YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, SEXO_BIOLOGICO,  
IFNULL(SUM(case when AREA_CONOCIMIENTO = 'AGRONOMY, VETERINARY MEDICINE, AND RELATED FIELDS'  
then 1 else 0 end), 0) ENROLLED_IN_AGRO
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
WHERE LEVEL = 'University Program'  AND AREA_CONOCIMIENTO = 'AGRONOMY, VETERINARY MEDICINE, AND RELATED FIELDS'  
GROUP BY 1,2 ,3
) ,
ENROLLED_IN_SOCIAL_SCIENCE_ AS (
SELECT codigo_dane_sede   ID_1_2012,
YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, SEXO_BIOLOGICO,  
IFNULL(SUM(case when AREA_CONOCIMIENTO = 'SOCIAL SCIENCES AND HUMANITIES'  
then 1 else 0 end), 0) ENROLLED_IN_SOCIAL_SCIENCE
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
WHERE LEVEL = 'University Program'  AND AREA_CONOCIMIENTO = 'SOCIAL SCIENCES AND HUMANITIES'  
GROUP BY 1,2 ,3
) ,
ENROLLED_FINE_ARTS_ AS (
SELECT codigo_dane_sede   ID_1_2012,
YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, SEXO_BIOLOGICO,  
IFNULL(SUM(case when AREA_CONOCIMIENTO = 'FINE ARTS'  
then 1 else 0 end), 0) ENROLLED_FINE_ARTS
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
WHERE LEVEL = 'University Program'  AND AREA_CONOCIMIENTO = 'FINE ARTS'  
GROUP BY 1,2 ,3
)  ,
ENROLLED_ECONOMICS_BUSINESS_ AS (
SELECT codigo_dane_sede   ID_1_2012,
YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, SEXO_BIOLOGICO,  
IFNULL(SUM(case when AREA_CONOCIMIENTO  LIKE  '%ECONOMICS, BUSINESS%'  
then 1 else 0 end), 0) ENROLLED_ECONOMICS_BUSINESS
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
WHERE LEVEL = 'University Program'  AND AREA_CONOCIMIENTO LIKE  '%ECONOMICS, BUSINESS%'  
GROUP BY 1,2 ,3
) ,
ENROLLED_HEALTH_SCIENCES_ AS (
SELECT codigo_dane_sede   ID_1_2012,
YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, SEXO_BIOLOGICO,  
IFNULL(SUM(case when AREA_CONOCIMIENTO  LIKE  '%HEALTH%'  
then 1 else 0 end), 0) ENROLLED_HEALTH_SCIENCES
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
WHERE LEVEL = 'University Program'  AND AREA_CONOCIMIENTO LIKE  '%HEALTH%'  
GROUP BY 1,2 ,3
) ,
NO_ENROLLED_ AS (
 
SELECT codigo_dane_sede   ID_1_2012,
YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, genero SEXO_BIOLOGICO,  
SUM(CASE WHEN  IDS IS NULL THEN 1 ELSE 0 END ) NO_ENROLLED
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
-- WHERE LEVEL = 'University Program'   
GROUP BY 1,2 ,3
) ,
TOT_STUDENTS_ AS (
SELECT codigo_dane_sede   ID_TOT,
YEAR_INFO YEAR_SCHOOLING_LAST_GRADE, genero SEXO_BIOLOGICO,  
COUNT(DISTINCT nro_documento) TOT_STUDENTS
FROM  `ph-jabri.SIMAT_SNIES.SIMAT_SNIES` 
-- WHERE LEVEL = 'University Program'   
GROUP BY 1,2 ,3
) ,
JOINING_1 AS (
 SELECT UNIQUE_SCHOOLS_SEX_YEAR.*,
 IFNULL(TOT_STUDENTS, 0) TOT_STUDENTS
  FROM UNIQUE_SCHOOLS_SEX_YEAR 
 LEFT JOIN TOT_STUDENTS_
 ON codigo_dane_sede   =  ID_TOT
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
),
JOINING_2 AS (

 SELECT JOINING_1.*,
 IFNULL(NO_ENROLLED, 0) NO_ENROLLED
  FROM JOINING_1 
 LEFT JOIN NO_ENROLLED_
 ON codigo_dane_sede   =  ID_1_2012
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
),
JOINING_3 AS (
 SELECT JOINING_2.*,
 IFNULL(ENROLLED_HEALTH_SCIENCES, 0) ENROLLED_HEALTH_SCIENCES
  FROM JOINING_2
 LEFT JOIN ENROLLED_HEALTH_SCIENCES_
 ON codigo_dane_sede   =  ID_1_2012
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
),
JOINING_4 AS (
 SELECT JOINING_3.*,
 IFNULL(ENROLLED_ECONOMICS_BUSINESS, 0) ENROLLED_ECONOMICS_BUSINESS
  FROM JOINING_3
 LEFT JOIN ENROLLED_ECONOMICS_BUSINESS_
 ON codigo_dane_sede   =  ID_1_2012
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
),
JOINING_5 AS (
 SELECT JOINING_4.*,
 IFNULL(ENROLLED_FINE_ARTS, 0) ENROLLED_FINE_ARTS
  FROM JOINING_4
 LEFT JOIN ENROLLED_FINE_ARTS_
 ON codigo_dane_sede   =  ID_1_2012
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
),
JOINING_6 AS (
 SELECT JOINING_5.*,
 IFNULL(ENROLLED_IN_SOCIAL_SCIENCE, 0) ENROLLED_IN_SOCIAL_SCIENCE
  FROM JOINING_5
 LEFT JOIN ENROLLED_IN_SOCIAL_SCIENCE_
 ON codigo_dane_sede   =  ID_1_2012
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
),
JOINING_7 AS (
 SELECT JOINING_6.*,
 IFNULL(ENROLLED_IN_AGRO, 0) ENROLLED_IN_AGRO
  FROM JOINING_6
 LEFT JOIN ENROLLED_IN_AGRO_
 ON codigo_dane_sede   =  ID_1_2012
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
),
JOINING_8 AS (
 SELECT JOINING_7.*,
 IFNULL(ENROLLED_IN_EDUCATION_SCIENCES, 0) ENROLLED_IN_EDUCATION_SCIENCES
  FROM JOINING_7
 LEFT JOIN ENROLLED_IN_EDUCATION_SCIENCES_
 ON codigo_dane_sede   =  ID_1_2012
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
),
JOINING_9 AS (
 SELECT JOINING_8.*,
 IFNULL(ENROLLED_IN_ENG_ARCHITECTURE_URBAN, 0) ENROLLED_IN_ENG_ARCHITECTURE_URBAN
  FROM JOINING_8
 LEFT JOIN ENROLLED_IN_ENG_ARCHITECTURE_URBAN_
 ON codigo_dane_sede   =  ID_1_2012
 AND  Year = YEAR_SCHOOLING_LAST_GRADE 
AND  SEXO = SEXO_BIOLOGICO
), 
JOINING_10_M AS (
  SELECT 
codigo_dane_sede,
Year,
TOT_STUDENTS TOT_STUDENTS_M,
TOT_STUDENTS - NO_ENROLLED AS ENROLLED_IN_ANY_PROGRAM_M, 
NO_ENROLLED NO_ENROLLED_M,
ENROLLED_HEALTH_SCIENCES ENROLLED_HEALTH_SCIENCES_M,
ENROLLED_ECONOMICS_BUSINESS ENROLLED_ECONOMICS_BUSINESS_M,
ENROLLED_FINE_ARTS ENROLLED_FINE_ARTS_M,
ENROLLED_IN_SOCIAL_SCIENCE ENROLLED_IN_SOCIAL_SCIENCE_M,
ENROLLED_IN_AGRO ENROLLED_IN_AGRO_M, 
ENROLLED_IN_EDUCATION_SCIENCES ENROLLED_IN_EDUCATION_SCIENCES_M,
ENROLLED_IN_ENG_ARCHITECTURE_URBAN ENROLLED_IN_ENG_ARCHITECTURE_URBAN_M,

 FROM JOINING_9 WHERE  SEXO  = 'M'
),
JOINING_10_F AS(
  SELECT 
codigo_dane_sede codigo_dane_sede_F,
Year YEAR_F,
TOT_STUDENTS TOT_STUDENTS_F,
TOT_STUDENTS - NO_ENROLLED AS ENROLLED_IN_ANY_PROGRAM_F, 
NO_ENROLLED NO_ENROLLED_F,
ENROLLED_HEALTH_SCIENCES ENROLLED_HEALTH_SCIENCES_F,
ENROLLED_ECONOMICS_BUSINESS ENROLLED_ECONOMICS_BUSINESS_F,
ENROLLED_FINE_ARTS ENROLLED_FINE_ARTS_F,
ENROLLED_IN_SOCIAL_SCIENCE ENROLLED_IN_SOCIAL_SCIENCE_F,
ENROLLED_IN_AGRO ENROLLED_IN_AGRO_F, 
ENROLLED_IN_EDUCATION_SCIENCES ENROLLED_IN_EDUCATION_SCIENCES_F,
ENROLLED_IN_ENG_ARCHITECTURE_URBAN ENROLLED_IN_ENG_ARCHITECTURE_URBAN_F,

 FROM JOINING_9 WHERE  SEXO  = 'F'
)
SELECT YEAR,* EXCEPT(Year, Year_F) FROM JOINING_10_F
INNER JOIN JOINING_10_M
ON  codigo_dane_sede = codigo_dane_sede_F 
AND Year = Year_F

--  
--  ORDER BY TOT_STUDENTS







-- (TOT_STUDENTS - NO_ENROLLED) /  CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END  AS FRAC_ENROLLED_IN_ANY_PROGRAM, 
-- NO_ENROLLED / CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END AS FRAC_NO_ENROLLED, 
-- ENROLLED_HEALTH_SCIENCES /  CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END FRAC_ENROLLED_HEALTH_SCIENCES,
-- ENROLLED_ECONOMICS_BUSINESS /  CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END FRAC_ENROLLED_ECONOMICS_BUSINESS,
-- ENROLLED_FINE_ARTS /  CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END FRAC_ENROLLED_FINE_ARTS,
-- ENROLLED_IN_SOCIAL_SCIENCE /  CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END FRAC_ENROLLED_IN_SOCIAL_SCIENCE,
-- ENROLLED_IN_AGRO /  CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END FRAC_ENROLLED_IN_AGRO,
-- ENROLLED_IN_EDUCATION_SCIENCES /  CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END FRAC_ENROLLED_IN_EDUCATION_SCIENCES,
-- ENROLLED_IN_ENG_ARCHITECTURE_URBAN /  CASE WHEN TOT_STUDENTS= 0 THEN NULL ELSE TOT_STUDENTS END FRAC_ENROLLED_IN_ENG_ARCHITECTURE_URBAN,