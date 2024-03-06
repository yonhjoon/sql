/*
    <JOIN>
    �ΰ� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽������� �ּ����� �����͸� ������ ���̺� ��� ����
    (�ߺ� ������ �ּ�ȭ�ϱ� ���ؼ� �ִ��� �ɰ��� ������)
    
    => ������ �����ͺ��̽����� SQL���� �̿��� ���̺� "���踦 �δ� ���"
    (������ �� ��ȸ�� ���°� �ƴ϶� �� ���̺� �����(�ܷ�Ű)�� ���� �����͸� ��Ī���� ��ȸ�ؾ��Ѵ�.)
    
    JOIN�� ũ�� "����Ŭ ���� ����" �� "ANSI ����" ( ANSI == �̱�����ǥ����ȸ )
    
    [�������]
    
              ����Ŭ ���뱸��            |               ANSI ����
    ----------------------------------------------------------------------------
                �����                |                 ��������     
            ( EQUAL JOIN )             |       (INNER JOIN) => JOIN USING/ON
            
    ----------------------------------------------------------------------------
                ��������                |         ���� �ܺ� ���� (LEET OUTER JOIN)
             (LEFT OUTER)              |       ���������� �ܺ� ����(RIGHT OUTER JOIN)
             (RLGHT OUTER)             |        ��ü �ܺ� ����(FULL OUTER JOIN)
             
    ----------------------------------------------------------------------------  
        ��ü����(SELF JOIN)             |               JOIN ON
        �� ���� (NON EAUAL JOIN)
        
    ----------------------------------------------------------------------------
                
*/

-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    1. ����� ( EQUAL JOIN ) / �������� ( LNNER JOIN )
    �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ( == ��ġ�ϴ� ���� ���� ���� ��ȸ ���� )
*/

--> ����Ŭ ���뱸��
-- FROM���� ��ȸ�ϰ����ϴ� ���̺��� ����( , �� ����)
-- WHERE���� ��Ī��ų �÷��� ���� ������ ����

-- 1) ������ �� �÷����� �ٸ���� ( EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID )
-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- NULL, D3, D4, D7 �����ʹ� �������̺����� �����ϱ� ������ ���ܵ� �� �� �� �ִ�.
-- ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵ� ���� Ȯ���� �� �ִ�.


-- 2) ������ �� �÷����� ������� ( EMPLOYEE : JOB_CODE  /  JOB : JOB_CODE )
-- ��ü ������� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


-------> ANSI����
--FROM���� �����̵Ǵ� ���̺� �ϳ� ���
-- JOIN���� ���� �����ϰ����ϴ� ���̺� ��� + ��Ī��ų �÷������� ���ǵ� ���
--JOIN USING / JOIN ON

-- 1. ������ �� �÷����� �ٸ����( EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID )
--JOIN ON
-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ������� ( EMPLOYEE : JOB_CODE  /  JOB : JOB_CODE )
-- ��ü ������� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);
-- JOIN USING���� ��� �����ϴ� �÷����� ���� ���� ��밡��

-- �߰����� ���ǵ� ����
--������ �븮�� ����� ���, �����, ���޸�, �޿���ȸ
--����Ŭ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '�븮';


--ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING ( JOB_CODE )
WHERE JOB_NAME = '�븮';


-------------------------------------����----------------------------------------
--1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
-->����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
AND DEPT_TITLE = '�λ������';

-->ANSI
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON ( DEPT_CODE = DEPT_ID )
WHERE DEPT_TITLE = '�λ������';

--2. DEPARTMENT �� LOCATION ���̺��� �����Ͽ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
-->����Ŭ
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT, LOCATION;

-->ANSI
SELECT LOCATION_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
-->����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
AND BONUS IS NOT NULL;

-->ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
AND BONUS IS NOT NULL;

-- 4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿���ȸ
-->����Ŭ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '�ѹ���';
-->ANSI
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '�ѹ���';

--==============================================================================

/*
    2. �������� / �ܺ����� (OUTER JOIN)
    �� ���̺��� JOIN�� ��ġ���� �ʴ� �ൿ ���Խ��� ��ȸ����
    ��, �ݵ�� LEFT / RIGHT�� �����ؾߵȴ�. ( �������̺��� ���ؾ��Ѵ�. )
*/

-- �����, �μ���, �޿�, ����
-- �������ν� �μ���ġ�� �������� 2���� ��������� �����ȴ�.
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--1 ) LEFT JOIN : �� ���̺� �� ���� ����� ���̺��� �������� JOIN
--����Ŭ
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

--ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- 2 ) RIGHT JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
--����Ŭ
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

--ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);



-- 3 ) FULL JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� �ִ�(����ŬX)
--ANSI ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--==============================================================================

/*
    3. ���� ���� ( NON EQUAL JOIN )
    ��Ī��ų �÷��� ���� ���� �ۼ��� '='�� ������� �ʴ� ���ι�
    ANSI�������δ� JOIN ON
*/

-- ����� ,�޿�, �޿�����
--����Ŭ����
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

--ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY >= MIN_SAL AND SALARY <= MAX_SAL);
--JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

--==============================================================================

/*
    4. ��ü���� ( SELF JOIN )
    ���� ���̺��� �ٽ��ѹ� �����ϴ� ���
*/

-- ��ü������� ������, �����, ����μ��ڵ�, --> EMPLOYEE E
--            ������, �����, ����μ��ڵ� --> EMPLOYEE M
--> ����Ŭ
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE,
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-- ANSI
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE,
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE
       FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);



--==============================================================================
/*
    <��������>
    2�� �̻��� ���̺��� ������ JOIN�� ��
*/

-- ���, �����, �μ���, ���޸�
---> ����Ŭ����
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;

--->ANSI����
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);


-- ���, �����, �μ���, ������ ��ȸ
SELECT * FROM EMPLOYEE; --    DEPT_CODE
SELECT * FROM DEPARTMENT;  -- DEPT_ID       LOCATION_ID
SELECT * FROM LOCATION; --                  LOCAL_CODE

-- ����Ŭ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

--ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM  EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);








