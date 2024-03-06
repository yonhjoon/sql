-- ������ DROP�� ������ ���̺� �ݴ������ ��������� ���߿� �߸��Ǿ����� 
-- ����� ���ϰ� �������´�
DROP TABLE  MEMBER;
DROP TABLE TEST;

CREATE TABLE TEST(
    TNO NUMBER,
    TNAME VARCHAR2(20),
    TDATE DATE
);

SELECT * FROM TEST;

CREATE TABLE MEMBER(
    USERNO NUMBER PRIMARY KEY, -- ��ǰ ��ȣ
    USERID VARCHAR2(15) NOT NULL, --��ǰ �̸�
    USERPWD VARCHAR2(15) NOT NULL, --��ǰ ������ȣ
    USERNAME VARCHAR2(20) NOT NULL, --ȭ�� �̸�
    EMAIL VARCHAR2(30), --ȭ�� �̸���
    PHONE CHAR(11), --ȭ�� ��ȭ��ȣ
    ADDRESS VARCHAR2(100), --ȭ�� �ּ�
    HOBBY VARCHAR2(50), -- ũ��
    ENROLLDATE DATE DEFAULT SYSDATE NOT NULL --�����
);

DROP SEQUENCE SEQ_USERNO;
CREATE SEQUENCE SEQ_USERNO
NOCACHE;

INSERT INTO MEMBER
VALUES(SEQ_USERNO.NEXTVAL, '�𳪸���','001','���������� �� ��ġ','admin@iei.or.kr','01012345678','��Ż���� ���׻�','53 x 77 cm', '1503~1506������� ����');

INSERT INTO MEMBER
VALUES(SEQ_USERNO.NEXTVAL, '������ ����','002','���������� �� ��ġ','admin@iei.or.kr','01012345678','��Ż���� ���׻�','880 x 700 cm', '1490��');

COMMIT;

SELECT * FROM MEMBER;














