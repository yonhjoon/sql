/*
        <SELECT>
        SELECT 가지고오고 싶은 정보 FROM 테이블;
        SELECT (*) 또는 컬럼1, 컬럼2, 컬럼3... FROM 테이블;
*/

-- 모든 사원의 정보를 보여줘
SELECT * FROM EMPLOYEE;

-- 모든 사원의 이름, 주민등록번호, 핸드폰번호
SELECT EMP_NAME, EMP_NO,PHONE
FROM EMPLOYEE;

----------------------------------실습------------------------------
--JOB테이블의 직급명 컬럼만 조회
SELECT JOB_CODE 
FROM EMPLOYEE;

--DEPARTMENT 테이블의 모든 컬럼 조회
SELECT * 
FROM DEPARTMENT; 

--DEPARTMENT 테이블의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

--<컬럼값을 통한 산술연산>
--SELECT절 컬럼명 작성부분에 산술연산을 할 수 있다.

-- EMPLOYEE테이블의 사원명, 사원의 연봉(SALARY * 12)을 조회
SELECT EMP_NAME, SALARY * 12 AS "연봉"
FROM EMPLOYEE;

--  EMPLOYEE테이블의 사원명, 급여, 보너스, 연봉, 보너스포함연봉 조회(급여+(급여*보너스)) * 12
-- 산술연산 과정중에 NILL데이터가 포함되어 있다면 무조건 결과값은 NULL 이다.
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, (SALARY + (SALARY * BONUS)) * 12 
FROM EMPLOYEE;

-- 사원명, 입사일, 근무일수를 조회
-- 현제시간 - 입사일 = 근무한시간
-- DATE - DATE => 결과는 무조건 일로 표시가된다.
-- 코드실행시 날짜를 표시하는 상수 : SYSDATE [년/월/일/시/분/초]
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE 
FROM EMPLOYEE;

SELECT SYSDATE 
FROM DUAL;
-- DULA : 오라클에서 제공해주는 가상데이터 테이블이다.(현업에서는 더미데이터 라고 한다 임시 데이터라는 뜻)

/*
    <컬럼명에 별칭 지정하기>
    산술연산을 하게되면 컬럼명이 지저분해진다. 이때 컬럼명에 별칭을 부여해서 깔끔하게 가져올수 있다.
    [표현법]
    컬럼명 별칭 / 컬럼명 as 별칭 / 컬럼명 "별칭" / 컬럼명 as "별칭"
*/

SELECT EMP_NAME 사원명, SALARY AS 급여, BONUS "보너스" , (SALARY * 12) AS "연봉(원)",
       (SALARY + (SALARY * BONUS)) * 12 AS "총 소득"
FROM EMPLOYEE;

/*
    <리터럴> 그냥 특정한 값을 지정할때
    임의로 지정한 문자열('')
    조회된 결과(RESULT SET 리졀트 셋)의 모든 행에 반복적으로 출력
*/

-- EMPLOYEE 테이블의 사번, 사원명, 급여
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위" 
FROM EMPLOYEE;

/*
    <연결연산자 : ||>
    여러 컬럼값들을 마치 하나의 컬럼처럼 연결할수 있다.
*/

-- 사번, 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_ID || EMP_NAME || SALARY || '원'
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 모든 사원의 월급을 조회한다.
--다음과 같이 결과가 나오도록 출력해라
-- XX의 월급은 XX원입니다.

SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여"
FROM EMPLOYEE;

/*
    <DISTINCT>
     중복제게 - 컬럼에 포기된 값들을 한번씩만 조회할 때
*/

-- EMPLOYEE 직급코드조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

--EMPLOYEE 부서코드를 조회 (중복제거)
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE;
-- 위처럼 작성하면 에러가 발생한다. DISTINCT는 한번만 사용이 가능하다.
SELECT DISTINCT JOB_CODE, DEPT_CODE
-- D위처럼 사용시 (JOB_CODE, DEPT_CODE)를 쌍으로 묶어서 중복을 제가한 값을 보여준다.
FROM EMPLOYEE;

-----------------------------------------------------------------------------------------

/*
    <WHERE 절>
    조회하고자하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회할 떄 사용
    조건식에서도 다양한 연산자 사용이 가능
    [표현법]
    SELECT 컬럼,컬럼,컬럼 연산
    FROM 테이블
    WHERE 조건;
    
    >>비교연산자<<
    > , < , >= , <= : 대소비교
    =               : 양쪽이 같다 - 동등비교
    !=, ^=, <>      : 양쪽이 다르다. 
*/

-- EMPLOYEE에서 부서코드가 'D9'인 사원들만 조회(모든컬럼)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--EMPLOYEE에서 부서코드가 'D1'인 사원들의 사원명, 급여,부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--EMPLOYEE에서 부서코드가 'D1'이 아닌 사원들의 사원명, 급여,부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';

--월급이 400만원 이상인 사원들의 사원명, 부서코드,급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-------------------------------실습-----------------------

-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉(별칭->연봉)조회
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY *12 AS "연봉"
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉(별칭->연봉), 부서코드 조회
SELECT EMP_NAME, SALARY, SALARY * 12 AS "연봉", DEPT_CODE
FROM EMPLOYEE
WHERE SALARY * 12 > 50000000;

-- 연봉 >= 50000000; -> 에러가 발생한다
-- 이유 : 실행순서가 FROM -> WHERE -> SELECT

-- 3. 직급코드가 'J3'가 아닌 사원들의 사번,사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID,EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-- 4. 급여가 350만원 이상 600만원 이하인 모든사원의 사원명, 사번, 급여조회
-- 중간에 AND,OR로 조건으로 연결할수있다.

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

/*
        <AND, OR 연산자>
        조건을 여러개 연결할 때 사용한다.
        [표현법]
        조건A AND 조건B  ->  조건A와 조건B 모두 만족하는 값만 가져온다.
        조건A OR 조건B  -> 조건A와 조건B중 하나라도 만족하는 값은  가지고 온다.
        
        
        <BETWEEN AND>
        조건식에 사용되는 구문
        몇이상 몇이하인 범위에 대한 조건을 제시할 떄 사용하는 연산자(이상,이하만 가능)
        
        [표현법]
        비교대상 컬럼 BERWEEN 하안값  AND 상한값 (AND보다 높고 BERWEEN 보다 낮을떄)
*/

-- 급여가 350만원 이상 600만원 이하인 모든 사원의 사원명, 사번, 급여조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
-- WHERE SALARY >= 3500000 AND SALARY <= 6000000; (연산자 사용시)
WHERE SALARY BETWEEN 3500000 AND 6000000; --(비트윈 사용시)

-- 급여가 350만원 미만 600만원 초과인 모든 사원의 사원명 사번 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR SALARY > 6000000; 
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
--NOT 는 SALARY 앞 혹은 뒤 상관없다  NOT SALARY / SALARY NOT

-- NOT : 논리 부정 연산자
-- 컬럼명 앞 또는 BETWEEN앞에 선언 가능

--입사일이 '90/01/01' ~ '01/01/01' 사원을 전체 조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01'; --DATE타입도 비교연산이 가능하다.
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

--================================================================================

/*
    <LIKE>
    비교하고자하는 컬럼값이 내가 제시한 특정 패턴에 만족할 경우에 조회
    
    [표현법]
    비교할 대상컬럼 LIKE '특정패턴'; (일치하는 것만 가져온다.) (LIKE가 와일드카드)
    
    특정패턴을 제시할 때 와일드카드라는 특정패턴이 정의되어있다.
    1. '%' : 포함문자 검색 (0글자이상 전부 조회)
     C) 비교할대상컬럼 LIKE '문자%' : 비교대상컬럼값 중에서 해당문자로 시작하는 값들만 조회
         비교할대상컬럼 LIKE '%문자' : 비교대상컬럼값 중에서 해당문자로 끝나는 값들만 조회
         비교할대상컬럼 LIKE '%문자%' : 비교대상컬럼값 중에서 해당문자가 포함된 값 조회
    
    2. '_' : 1글자를 대체하는 검색
     EX) 비교할대상컬럼 LIKE '_문자' : 비교대상컬럼값 문자앞에 아무글자나 한글자가 있는 값을 조회
         비교할대상컬럼 LIKE '문자_' : 비교대상컬럼값 문자뒤에 아무글자나 한글자가 있는 값을 조회
         비교할대상컬럼 LIKE '_문자-' : 비교대상컬럼값 문자앞뒤에 아무글자나 한글자가 있는 값을 조회
         
         비교할대상컬럼 LIKE '_____문자' : 비교대상컬럼값 문자앞에 아무글자나 N글자가 있는 값을 조회
         비교할대상컬럼 LIKE '문자_____' : 비교대상컬럼값 문자뒤에 아무글자나 N글자가 있는 값을 조회
         비교할대상컬럼 LIKE '_____문자_____' : 비교대상컬럼값 문자앞뒤에 아무글자나 N글자가 있는 값을 조회
        
*/

-- 사원들중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 사원들중에서 이름에 '하' 라는 글자가 포함된 사원의 이름, 전화번호 목록을 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 사원들중에서 이름에 중간글자가 '하'인 사원의 이름 전화번호 목록조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의 3번째 자리가 1인 사원들의 사번, 사원명, 전화번호 조회
SELECT EMP_ID,EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- 이메일 중 _앞글자가 3글자인 사원들의 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
-- WHERE EMAIL LIKE '____%'; -> 와일드카드문자떄문에 정상출력이 되지않는다.
-- 와일드카드문자와 일반문자의 구분이 필요하다.
-- 데이터값으로 취급하고싶은 와일드카드 문자앞에 나만의 탈출문자를 제시해서 탈출시켜주면 된다.
-- ESCAPE OPTION을 등록해서 사용해야된다.
WHERE EMAIL LIKE '___\_%'ESCAPE '\'; --꼭 \ 일 필요없이 $%^ 무엇으든 상관없다 ESCAPE 는 탈출문이다.

--위 사원들이 아닌 그 외의 사원들을 조회하고 싶다 컬럼동일
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE NOT EMAIL LIKE '___\_%' ESCAPE '\';


--====================================실습==================================
-- 1. 이름이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. 전화번호 처음 3자리가 010이 아닌 사원들의 사우너명 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. 이름에 '하'가 포함되어있고 급여가 240만원 이상인 사원명 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;

-- 4. 부서테이블에서 해외영업부 인 부서들의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

--======================================================================

/*
    <IN>
    WHERE절에서 비교대상 컬럼값이 내가 제시한 목록중에 일치하는 값이 있는지 검사
    
    [표현법]
    비교대상컬럼 IN ('값1',값2',...)
*/

-- 부서코드가 D6 이거나 D8기어나 D5인 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5'; (AND,OR연산자 사용시)
WHERE DEPT_CODE IN ('D6','D8','D5'); --(IN 사용시)

--===============================================================================

/*
    <IS NULL & IS NOT NULL>
    컬럼값에 NULL이 있을경우 NULL값을 비교하기 위해서는 위의 연산자를 사용해야한다.
*/

--보너스를 받지않은 사원들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--보너스를 받는 사원들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

--사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--사수가 있는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 부서배치를 아직 받지 않았고 보너스를 받은 사원들의 이름, 보너스, 부서코드를 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--===========================================================================

/*
    <연선자 우선순위>
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL / LIKE / IN
    5. BERWEEN A AND B
    6. NOT
    7. AND
    8. OR
*/

-- 직급코드가 J7이거나 J2인 사원들 중에 급여가 200만원 이상인 사원들의 모든컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

--====================================실습문제======================================

-- 1. 사수가 없고 부서배치도 받지않은 사원들의 사원명, 사번, 부서코드 조회
SELECT EMP_NAME, EMP_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 2. 연봉(보너스 미포함)이 3천만원 이상이고 보너스를 받지 않는 사원들의 사번,사원명, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE (SALARY * 12) >= 30000000 AND BONUS IS NULL;


-- 3. 입사일이 '95/01/01' 이상이고 부서배치를 받지않은 사원들의 사번, 사원명, 입사일, 부서코드 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01'  AND DEPT_CODE IS  NULL;


-- 4. 급여가 200만원 이상이고 500만원 이하인 사원 중에서 입사일이 '01/01/01'이상이고 보너스를 받지 않는 사원들의
--    사번, 사원명, 급여, 입사일, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000 AND (HIRE_DATE >= '01/01/01') AND BONUS IS NULL;

-- 5. 보너스를 포함 연봉이 NULL이 아니고 이름에 '하'가 포함된 사원들의 사번, 사원명, 급여, 보너스 포함 연봉 조회
SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + (SALARY * BONUS)) * 12
FROM EMPLOYEE
WHERE ((SALARY + (SALARY * BONUS)) * 12) IS NOT NULL AND EMP_NAME LIKE '%하%';













