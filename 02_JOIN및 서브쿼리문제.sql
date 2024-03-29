--1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회 -- 완벽하지않음 (년생 확인 못함)
SELECT EMP_NAME AS "이름", EMP_NO AS "주민번호", DEPT_CODE AS "부서",
       JOB_CODE AS "직급"
FROM EMPLOYEE

JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE SUBSTR (EMP_NO,1,2) >= 70 AND SUBSTR (EMP_NO,1,2) <= 80
      AND SUBSTR(EMP_NO,8,1) = 2
      AND EMP_NAME LIKE '전%';
      
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SUBSTR(EMP_NO, 1, 2) >= 70 AND SUBSTR(EMP_NO, 1, 2) < 80
      AND SUBSTR(EMP_NO, 8, 1) = 2
      AND EMP_NAME LIKE '전%';

--WHERE (SUBSTR(EMP_NO,8,1) = '2' OR SUBSTR(EMP_NO,8,1) = '4')
--        AND EMP_NAME LIKE '전%';

--2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회 -- 날짜 계산 아예못함
--SELECT TO_DATE(SUBSTR(EMP_NO,1,2), 'YY') 년생만 출력
--FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME,
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))) + 1 AS "나이",
       DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')))=
      (SELECT MIN(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR'))))
         FROM EMPLOYEE);

-- *MONTHS_BETWEEN : 두 날짜 사이의 개월 수
-- 사원들의 사원명, 입사일, 근무일수, 근무계월수를 조회
SELECT EMP_NAME, HIRE_DATE, FLOOR (SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

--3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%형%';

--4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
SELECT EMP_NAME AS "사원 명", JOB_NAME AS "직급 명", DEPT_CODE AS "부서코드", DEPT_TITLE AS "부서 명"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE DEPT_ID IN ('D5','D6'); --선생님
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6'; -- 내꺼

--5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
-- 보너스를 받는사원
SELECT EMP_NAME,BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- 사원들의 부서명
SELECT EMP_NAME AS "사원 명", DEPT_TITLE AS "부서 명"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--결과
SELECT EMP_NAME AS "사원 명", DEPT_TITLE AS "부서 명", LOCAL_NAME AS "지역 명"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--6. 사원 명, 직급 명, 부서 명, 지역 명 조회
SELECT EMP_NAME AS "사원 명", JOB_NAME AS "직급 명", DEPT_TITLE AS "부서 명", LOCAL_NAME AS "지역 명"
FROM EMPLOYEE
JOIN JOB USING( JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

--7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
-- 부서 명
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 지역 명
SELECT EMP_NAME, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
-- 국가 명
SELECT EMP_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);

--결과
SELECT EMP_NAME AS "사원 명",DEPT_TITLE AS "부서 명", LOCAL_NAME AS "지역 명", NATIONAL_NAME AS "국가 명"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
--WHERE NATIONAL_NAME = '한국' OR NATIONAL_NAME = '일본'; -- 나
WHERE NATIONAL_NAME IN ('한국','일본'); -- 선생님

--8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회 (자체조인 활용) // 잘못 알아들음

SELECT E.EMP_NAME , E.DEPT_CODE, D.EMP_NAME 
FROM EMPLOYEE E
JOIN EMPLOYEE D ON (E.DEPT_CODE = D.DEPT_CODE)
WHERE E.EMP_NAME != D.EMP_NAME
ORDER BY E.EMP_NAME;

---- 한명의 사원 조회
--SELECT EMP_NAME
--FROM EMPLOYEE
--WHERE EMP_NAME LIKE '하이유';
--
---- 한명의 사원 조회 후 부서 조회
--SELECT EMP_NAME, DEPT_CODE
--FROM EMPLOYEE
--WHERE EMP_NAME = '하이유';
--
---- 한명의 사원 조회 그리고 부서조회 후 같은 부서에일하는 사원의 이름
--SELECT EMP_NAME, DEPT_CODE
--FROM EMPLOYEE
--WHERE DEPT_CODE = (SELECT DEPT_CODE
--                    FROM EMPLOYEE
--                    WHERE EMP_NAME = '하이유');


--9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE BONUS IS NULL AND JOB_CODE IN ('J4','J3');
--WHERE NVL(BONUS,0) = 0 AND JOB_CODE IN ('J4','J3'); (NVL 사용시)

--10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위( ROW 혹은 RANK) 조회 -- ROW RANK 복습해야댐
--RANK 로 풀기
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, 순위
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,
             RANK() OVER(ORDER BY ((SALARY + (SALARY * NVL(BONUS,0))) * 12) DESC) AS "순위"
             FROM EMPLOYEE
             JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
             JOIN JOB USING (JOB_CODE))
WHERE 순위 <= 5;

-- ROW 로 풀기

--11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회 // 아예 모르겠음 복습해야댐
--(전체급여합의 20% (서브쿼리 이용))
--11-1. JOIN과 HAVING 사용
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
                        FROM EMPLOYEE);
;

--11-2. 인라인 뷰 사용
SELECT DEPT_TITLE, SSAL
FROM (SELECT DEPT_TITLE, SUM(SALARY) AS "SSAL"
        FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        GROUP BY DEPT_TITLE)
WHERE SSAL > (SELECT SUM(SALARY) * 0.2
              FROM EMPLOYEE);

--11-3. WITH 사용
WITH TOTAL_SAL AS (SELECT DEPT_TITLE, SUM(SALARY) AS "SSAL"
                    FROM EMPLOYEE
                    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                    GROUP BY DEPT_TITLE)
                    
SELECT DEPT_TITLE, SSAL
FROM TOTAL_SAL
WHERE SSAL > (SELECT SUM(SALARY) * 0.2
              FROM EMPLOYEE);

--12. 부서 명과 부서 별 급여 합계 조회 -- 복습필요
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

--13. WITH를 이용하여 급여 합과 급여 평균 조회 --복습 필요
WITH SUN_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT * FROM SUN_SAL
UNION
SELECT * FROM AVG_SAL;

-- 한열로 출력
WITH SUN_SAL AS (SELECT SUM(SALARY) FROM EMPLOYEE),
     AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
SELECT * 
FROM SUN_SAL,AVG_SAL;



