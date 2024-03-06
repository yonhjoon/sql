/*
    *��������(SUBQUERY)
    -�ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
    -���� SQL���� ���� ���� ��Ȱ�� �ϴ� ����
*/

--������ �������� ���� 1)
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ

-- 1) ���ö ����� �μ��ڵ�
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2)�μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';


--���� �� �ܰ踦 �ϳ��� ����������!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');
                    
--������ �������� ���� 2 )
--�� ������ ��ձ޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
-- 1)�������� ��ձ޿�
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE; //3047663

-- 2)3047663���� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

-- �� ������ �ϳ��� ���غ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT(AVG(SALARY))
                 FROM EMPLOYEE);

/*
    * ���������� ����
    ���������� ������ ������� ���� ��� �����Ŀ� ���� �з����ȴ�.
    
    --������ �������� : ���������� ��ȸ ������� ������ ������ 1���� ��
    --������ �������� : ���������� ��ȸ ������� �������� �� (������ �ѿ�)
    --���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� �� 
    --������ ���߿� �������� : ���������� ��ȸ ������� ������ �����ᷳ�� ��
    
    >> ���������� ������ ���Ŀ� ���� �������� �տ� �ٴ� �����ڰ� �޶�����.
*/


/*
     1. ������ ��������
     ���������� ��ȸ ������� ������ ������ 1���� �� (���� �ѿ�)
     �Ϲ� �񱳿����� ��밡��
     = != > <= ...
*/

-- 1) �������� ��� �޿����� �޿��� ���Թ޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG (SALARY)
                  FROM EMPLOYEE);
--WHERE SALARY < (3047662.60869565217391304347826086956522);                  
                  

-- 2)�����޿��� �޴� ����� ���, �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
--WHERE SALARY = ��� ���� �� �����޿�
WHERE SALARY = (SELECT MIN (SALARY)
                FROM EMPLOYEE);

-- 3) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿���ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE SALARY > ���ö ����� �޿�
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-- 4) ���ö ����� �޿����� ���̹޴� ������� ���, �̸�, �μ���, �޿���ȸ
--����Ŭ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND SALARY > (SELECT SALARY 
                                        FROM EMPLOYEE
                                        WHERE EMP_NAME = '���ö');
--ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-- 5) �μ��� �޿����� ���� ū �μ��� �μ��ڵ� �޿���
--5_1 ) �μ��� �޿����߿��� ���� ū �� �ϳ��� ��ȸ
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� ���Ѱ��� �˰������
--SELECT DEPT_CODE,(SUM(SALARY))
--FROM EMPLOYEE
--GROUP BY DEPT_CODE;

-- 5_2) �μ��� �޿����� 17700000�� �μ��� �μ��ڵ�, �޿��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

-- �� ������ ���غ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

-- 6) '������'����� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ����� ��ȸ
-- ��, ����������� ��ȸ
--����Ŭ
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND DEPT_CODE = (SELECT DEPT_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '������')
    AND EMP_NAME != '������';

--ANSI
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
    AND EMP_NAME != '������';
    
--------------------------------------------------------------------------------

/*
    2. ������ ��������
    ���������� ������ ������� �������� �� (�÷��� �Ѱ�)
    
    IN (��������) : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ� ��ȸ
    > ANY (��������) : �������� ����� �߿��� �Ѱ��� Ŭ��� ��ȸ
    < ANY (��������) : �������� ����� �߿��� �Ѱ��� ������� ��ȸ
        �񱳴�� > ANY (�������� ����� => ��1, ��2, ��3,...)
        �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3 ...
        
    > ALL (��������) : �������� ��� ������� ���� Ŭ ��� ��ȸ
    < ALL (��������) : �������� ��� ������� ���� ���� ��� ��ȸ
        �񱳴�� > ALL (���������� ����� => ��1, ��2, ��3...)
        �񱳴�� > ��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3 ...
*/

-- 1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿� ��ȸ
-- 1_1) ����� �Ǵ� ������ ����� ���� �����ڵ�
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('������','�����');

--1_2) ������ J3, J7 �� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3','J7');

-- �� ������ ���������� ���� ���غ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('������','�����'));
                    
-- 2) �븮�����ӿ��� �������� �޿��� �� �ּ� �޿����� ���� �޴� ����� ��ȸ
--(���, �̸�, ����, �޿�)

-- 2_1) ���� ���� �޿�
SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '����'; --3760000, 2200000, 2500000

-- 2_2 ) �븮�����̸鼭 ���� ����� ���� �ϳ��� ū ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
        AND SALARY > ANY (3760000,2200000,2500000)
        AND JOB_NAME = '�븮';

-- �� ���� ���غ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
    AND SALARY > ANY (SELECT SALARY
                      FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                      WHERE JOB_NAME = '����')
    AND JOB_NAME = '�븮';

--------------------------------------------------------------------------------
/*
    3. ���߿� ��������
    ������� �� �������� ������ �÷����� �������� ���
*/

-- 1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ
--(�����, �μ��ڵ�, �����ڵ�, �Ի���)
--> ������ ��������
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
    AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������');

-- ���߿� �������� �ۼ�
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������');

-- �ڳ��� ����� ���� �����ڵ�, ���� ����� �������ִ� ������� ���, �����, �����ڵ�, �����ȣ
-- 1) �ڳ��� ����� �����ڵ�, ����ڵ� ��ȸ
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '�ڳ���';

SELECT EMP_ID,EMP_NAME,JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                 FROM EMPLOYEE
                                 WHERE EMP_NAME = '�ڳ���')
    AND EMP_NAME != '�ڳ���';

--------------------------------------------------------------------------------

/*
    4. ������ ���߿� ��������
    ���������� ��ȸ ������� ������ �������� ���
*/

-- 1) �� ���޺� �ּұ޿��� �޴� �����ȸ(���,�����,�����ڵ�,�޿�)
-- �� ���޺� �ּұ޿�
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

--> �� ���޺� �ּұ޿��� �޴� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
   OR JOB_CODE = 'J7' AND SALARY = 1380000
   OR JOB_CODE = 'J3' AND SALARY = 3400000
   ...;
   
-- �������� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE 
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);
                             
-- �� �μ��� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�

SELECT EMP_ID,EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE,SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                             FROM EMPLOYEE
                             GROUP BY DEPT_CODE);
                             
--------------------------------------------------------------------------------

/*
    5. �ζ��� ��
    FROM���� ���������� �ۼ��� ��
    ���������� ������ ����� ��ġ ���̺�ó�� ���
*/

--������� ���, �̸�, ���ʽ����Կ���, �μ��ڵ� ��ȸ
--��, ���ʽ����� ������ NULL�� �Ǹ� �ȵȴ�.
--��, ���ʽ����� ������ 3000���� �̻��� ����鸸 ��ȸ

SELECT ROWNUM EMP_ID,EMP_NAME, (SALARY + (SALARY * NVL(BONUS,0))) * 12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + (SALARY * NVL(BONUS,0))) * 12 >= 30000000;

-- > �ζ��κ並 �ַ� ����ϴ� �� >> TOP-N�м� : ���� ��� ��ȸ
-- �� ������ �޿��� ���� ���� 5�� ��ȸ
-- ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

--> ORDER BY���� ����� ����� ������ ROWNUM�ο� -> ���� 5�� ��ȸ
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;


--���� �ֱٿ� �Ի��� ��� 5�� ��ȸ�ϱ�(�����, �޿�, �Ի���)
SELECT *
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT EMP_NAME, SALARY, HIRE_DATE
FROM (SELECT *
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;

-- �� �μ��� ��ձ޿��� ���� 3���� �μ� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY ROUND(AVG(SALARY));

SELECT DEPT_CODE, ��ձ޿�
FROM (SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "��ձ޿�"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY ROUND(AVG(SALARY) )DESC)
WHERE ROWNUM <= 3;

-- �μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��鿡 ���ؼ�
--(�μ��ڵ�, �μ��� �� �޿���, �μ��� ��ձ޿�, �μ��� �����) ��ȸ
SELECT DEPT_CODE, SUM(SALARY) AS "����", AVG(SALARY) AS "���", COUNT(*) AS "�ο���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY DEPT_CODE ASC;

SELECT *
FROM (SELECT DEPT_CODE, SUM(SALARY) AS "����", 
        AVG(SALARY) AS "���",
        COUNT(*) AS "�ο���"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY DEPT_CODE ASC)
WHERE ��� >= 2700000;

--------------------------------------------------------------------------------

/*
    *������ �ű�� �Լ� (WINDOW FUNCTION)
    RANK() OVER(���ı���) | DANSE_RANK() OVER (���ı���)
    RANK() OVER(���ı���) : ������ ���� ������ ����� ������ �ο� �� ��ŭ �ǳʶٰ� �������
     DENSE_RANK() OVER(���ı���) : ������ ������ �ִٰ� �ص� �� ���� ����� ������ 1�� ������Ŵ
     
     ������ SELECT�������� ��밡��
*/

--�޿��� ���� ������� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-- ���� 19�� 2�� �� ���� ����� 21������ �ϳ� �ǳ� �� �� �� �� �ִ�.

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE; 
-- > 19���� ���������� �� �ڿ� 20���� �ٷ� ������ ���� �� �� �ִ�.

SELECT *
FROM (SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
        FROM EMPLOYEE)
WHERE ���� <= 5;






