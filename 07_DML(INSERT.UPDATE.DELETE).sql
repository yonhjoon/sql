/*
    DQL(QUERY ������ ���Ǿ�) : SELECT (���)
    DML( MANIPULATION ������ ���۾� ) : INSERT, UPDATE, DELETE
    DDL ( DEFINITION ������ ���Ǿ� ) : CREATE, ALTER, DROP
    DCL ( CONTROL ������ ���� ) : GRANT, REVOKE
    TCL ( TRANSACTION Ʈ����� ����) : COMMIT, ROLLBACK
    
    < DML >
    : ������ ���� ���
    
    ���̺� ���� ����(INSERT) �ϰų�, ����(UPDATE)�ϰų�, ����(DELETE) �ϴ� ����
*/
/*
    1. INSERT
        ���̺� ���ο� ���� �߰��ϴ� ����
        
        [ǥ����]
        1)INSERT INTO ���Ը��� VALUES (��, ��, ��, ...)
        ���̺��� ��� �÷��� ���� ���� ���� �����ؼ� �� ���� INSERT�ϰ��� �� ��
        �÷��� ������ ���Ѽ� VALUES�� ���� �����ؾ���
        
        �����ϰ� ���� ������ ��� -> not enough values ����
        ���� �� ���� ������ �ܿ� -> too many values ����
*/
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE 
VALUES(900, '�̼ұ�','880914-1456789', 'SG8809@naver.com', '01075966990',
        'D7', 'J5', 4000000, 0.2, 200, SYSDATE, NULL, 'N');


/* *****(�̰��� ���� �˾Ƶ־� �Ұ�!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)*****
    2) INSERT INTO ���̺�� (�÷�, �÷�, �÷�) VALUES(��, ��, ��)
    ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ����Ѵ�.
    �׷��� �� �� ������ �߰��Ǳ� ������ ���þȵ� �÷��� �⺻������ NULL�� ����.
    => NOT NULL���������� �ɷ��ִ� �÷��� �ݵ�� ���� ���� �־�����Ѵ�.
    ��, �⺻���� �����Ǿ� ������ NULL�� �ƴ� �⺻���� ����.
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES (901, '������', '440701-1234567', 'J7', SYSDATE);

SELECT * FROM EMPLOYEE;

-- ���������� ���η� ����
INSERT 
  INTO EMPLOYEE
     (
       EMP_ID
      ,EMP_NAME
      ,EMP_NO
      ,JOB_CODE
      ,HIRE_DATE
      )
VALUES
    (
      902
     ,'�谳��'
     ,'870105-224510'
     ,'J7'
     ,SYSDATE
     );

-------------------------------------------------------------------------

/*
    3) INSERT INTO ���̺�� (��������);
    VALUES�� ���� ���� ����ϴ� �� ���
    ���������� ��ȸ�� ������� ��ä�� INSERT �����ϴ�.
*/
-- ���̺� ���� �����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DRPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

INSERT INTO EMP_01 (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
                    FROM EMPLOYEE
                    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID));

-------------------------------------------------------------------------

/*
    2. INSERT ALL
    �ΰ� �̻��� ���̺� ���� INSERT�� ��
    �̶� ���Ǵ� ���������� �����Ѱ��
*/

--> �׽�Ʈ ���̺�
CREATE TABLE EMP_DEPT
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0); -- �Ѱ��� �ش�ȵǰ� ������ �ɾ �����̸��� ���������ϱ�
SELECT * FROM EMP_DEPT;

CREATE TABLE EMP_MANAGER
AS (SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0);

--�μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';


/*
    [ǥ����]
    INSERT ALL
    INTO ���̺��1 VALUES(�÷�,�÷�,�÷�,...)
    INTO ���̺��2 VALUES(�÷�,�÷�,�÷�,...)
    ��������;
    
*/


INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
        (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
         FROM EMPLOYEE
         WHERE DEPT_CODE = 'D1');

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;



--------------------------------------------------------------------------------

/*
    3. UPDATE
    ���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ����
    
    [ǥ����]
    UPDATE ���̺��
    SET �÷� = ��,
        �÷� = ��,
        ... --AND�� �����ϴ� ���� �ƴ϶� �׳� , �� �����Ѵ�.
    [WHERE ����] --> ������ ��ü ��� ���� �����Ͱ� ����ȴ�.
    
    *������Ʈ�ÿ��� ���������� �� Ȯ���ؾ��Ѵ�.
*/

CREATE TABLE DEPT_TABLE
AS (SELECT * FROM DEPARTMENT);

SELECT * FROM DEPT_TABLE;

--D9�μ��� �μ����� '������ȹ������ ����'
UPDATE DEPT_TABLE
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

CREATE TABLE EMP_SALARY
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE);

SELECT * FROM EMP_SALARY;
--���ö ����� �޿��� 100�������� ����
UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '���ö';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '���ö';

--������ ����� �޿��� 700����, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2
WHERE EMP_NAME = '������';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '������';

--��ü����� �޿��� �����޿��� 10% �λ�� �ݾ��� ���� (�����޿� * 1.1)
UPDATE EMP_SALARY
SET SALARY = SALARY * 1.1;

SELECT * FROM EMP_SALARY;


--*UPDATE�� �������� ����ϱ�*

/*

    UPDATE ���̺�� 
    SET �÷��� = (��������)
    WHERE ����;
    
*/

--���� ����� �޿��� ���ʽ����� ����� ����� �޿��� ���ʽ� ������ ����
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
                FROM EMP_SALARY
                WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS
                FROM EMP_SALARY
                WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '����' OR EMP_NAME = '�����';

-- ���߿����������� ����
UPDATE EMP_SALARY
   SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                         FROM EMP_SALARY
                         WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

--ASIA�������� �ٹ��ϴ� ������� ���ʽ����� 0.3���� ����

--ASIA�������� �ٹ��ϴ� �����
SELECT EMP_ID, EMP_NAME 
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

--�ش� ������� ���ʽ����� 0.3���� ����
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID 
                 FROM EMP_SALARY
                 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                 JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                 WHERE LOCAL_NAME LIKE 'ASIA%');

COMMIT; --����

------------------------------------------------------------------------------

/*
    4. DELETE
    �׺񸣿� ��ϵ� �����͸� �����ϴ� ����(�� �� ������ ������ �ȴ�)
    
    [ǥ����]
    DELETE FROM ���̺�
    [WHERE ����] --> WHERE�� ���þ��ϸ� ��ü�� �� �������ȴ�. *����*
*/

DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '�̼ұ�';

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '901';

COMMIT;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
--D1�� ���� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ ������ ���� �ʴ´�.



















