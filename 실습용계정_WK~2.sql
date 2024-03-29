--1
SELECT DEPARTMENT_NAME AS "학과명" , CATEGORY AS "계영"
FROM tb_department;

--2
SELECT DEPARTMENT_NAME || '의 정원은 '|| CAPACITY || '명 입니다.'
FROM TB_DEPARTMENT; 

--3
SELECT STUDENT_NAME,STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_SSN,8,1) = '2' OR SUBSTR(STUDENT_SSN,8,1) = '4';

SELECT STUDENT_NAME, DEPARTMENT_NAME, STUDENT_SSN
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE (SUBSTR(STUDENT_SSN,8,1) = '2' OR SUBSTR(STUDENT_SSN,8,1) = '4')
        AND DEPARTMENT_NAME LIKE '%국문%';
        
SELECT STUDENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE (SUBSTR(STUDENT_SSN,8,1) = '2' OR SUBSTR(STUDENT_SSN,8,1) = '4')
        AND DEPARTMENT_NAME LIKE '%국문%';

--4
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME DESC;

-- 5
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7
SELECT DEPARTMENT_NO
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8
SELECT DISTINCT  CLASS_NO
FROM TB_GRADE
JOIN TB_CLASS USING( CLASS_NO)
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

--10
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN, ENTRANCE_DATE
FROM TB_STUDENT
WHERE SUBSTR(ENTRANCE_DATE,1,2 )='02';





--SELECT -함수
--1
SELECT DISTINCT STUDENT_NO AS "학번", STUDENT_NAME AS "이름", TO_CHAR(ENTRANCE_DATE,'YYYY-MM-DD') AS "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY  ENTRANCE_DATE;

--2
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE NOT PROFESSOR_NAME LIKE '___%';

-- 3

SELECT PROFESSOR_NAME AS "교수이름", EXTRACT(YEAR FROM SYSDATE) - (19 || SUBSTR(PROFESSOR_SSN, 1, 2)) AS "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
ORDER BY 교수이름;

--4
SELECT SUBSTR(PROFESSOR_NAME,2,2) AS "이름"
FROM TB_PROFESSOR;

--5
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT( YEAR FROM SYSDATE ) - 
     ( 19 || SUBSTR (STUDENT_SSN, 1, 2) ) > 19;

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - 
      EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) > 19;
-- 입학년도 - 주민번호에서 출생 = (출생나이부터 입학년도까지 나이 ) >(보다 작다) 19;
SELECT STUDENT_NO, STUDENT_NAME,EXTRACT (YEAR FROM ENTRANCE_DATE)
FROM TB_STUDENT; --입학년도 출력

SELECT STUDENT_NO, STUDENT_NAME, EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6)))
FROM TB_STUDENT; -- 주민번호에서 출생 출력

-- 6
SELECT TO_CHAR(TO_DATE('20201225'), 'DAY')
FROM DUAL;

-- 7
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYY'), 
       TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYY'),
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYY'), 
       TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYY')
FROM DUAL;

--8 
SELECT STUDENT_NO, STUDENT_NAME,TO_CHAR(TO_DATE(ENTRANCE_DATE, 'RR/MM/DD'), 'YYYY')
FROM TB_STUDENT
WHERE TO_CHAR(TO_DATE(ENTRANCE_DATE, 'RR/MM/DD'), 'YYYY') < 2000;

-- 9
SELECT ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10
SELECT DEPARTMENT_NO AS "학과번호", COUNT(*) AS "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1 ;

--11
SELECT COUNT (*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12
SELECT TO_CHAR(ENTRANCE_DATE,'YYYY') AS "년도" , POINT
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE STUDENT_NO = 'A112113';

SELECT SUBSTR(TERM_NO, 1, 4) 년도, ROUND(AVG(POINT), 1) "년도 별 학점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

-- 13
SELECT DEPARTMENT_NO AS "학과코드", COUNT(DECODE(ABSENCE_YN, 'Y', 1) ) AS "휴학생수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--14
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 1;


SELECT SUBSTR(TERM_NO, 1, 4) AS "년도", SUBSTR(TERM_NO, 5, 2) 학기, ROUND(AVG(POINT), 1) AS "평점"
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE STUDENT_NO = 'A112113'
group by SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2)
ORDER BY 1;



-- 1
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

--2
SELECT STUDENT_NAME AS "학생 이름",STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;






















