-- Ŀ�� ���� ����Ű : ctrl + enter
--���� ��ü ����: F5
SELECT 1+1
FROM dual;

--1. ���� ���� ��ɾ�
--conn/������/��й�ȣ;
conn system/123456;

--2. SQL�� ��/�ҹ��� ������ ����.
--��ɾ� Ű���� �빮��, �ĺ��ڴ� �ҹ��� �ַ� ����Ѵ�. (���� ��Ÿ�ϴ��)
SELECT user_id, username
FROM all_users
-- WHERE username = 'HR'    : HR ������ �ִ��� Ȯ��
;

-- ����� ���� ����
--11g ���� ����: � �̸����ε� ���� ���� ����
--12C ���� �̻�: 'c##'���ξ �ٿ��� ������ �����ϵ��� ��å�� ���� (common�� ����)
--c##���� ���������ϴ� ���
--     ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; --��ɾ� ���� �����ϸ� ��. 
--       �̰� �Ⱦ��� ORA-65096: ���� ����� �Ǵ� �� �̸��� �������մϴ�.
--       65096. 00000 -  "invalid common user or role name" ���� �߻�
-- CREATE USER ������ IDENTIFIED BY ��й�ȣ;
CREATE USER HR IDENTIFIED BY 123456;


-- ���̺� �����̽� ����
-- �ش� ������ ���� ���̺�����ϴ� �����ȿ��� ����������� ����Ҽ��ִ��� �뷮����, ��������
-- ALTER USER ������ DEFAULT TABLESPACE users;
--HR ������ �⺻ ���̺� ������ 'users'�������� ����
ALTER USER HR DEFAULT TABLESPACE users;

-- ������ ����� �� �ִ� �뷮 ����
-- HR ������ ����� �� �ִ� �뷮�� ���Ѵ�� ����
-- ALTER USER ������ QUOTA UNLIMITED ON users;
ALTER USER HR QUOTA UNLIMITED ON users;

-- ������ ������ �ο�
--GRANT ���Ѹ�1, ���Ѹ�2 TO ������;
--HR ������ connect, resource ������ �ο�
GRANT connect, resource TO HR;

--�⺻��������
--HR������ �����ϰ�, �⺻ ���� �� ���� �ο�
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR DEFAULT TABLESPACE users;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT connect, resource TO HR;

-- *���� ����
-- DROP USER ������ [CASCADE];
--HR���� ����
DROP USER HR [CASCADE];

--*���� ��� ����
-- ALTER USER ������ ACCOUNT UNLOCK;
ALTER USER HR ACCOUNT UNLOCK;

--HR ���� ��Ű��(������) ��������
--1. SQL PLUS 
--2. HR ������ ����
--3. ��ɾ� �Է�
--@[���]/hr_main.sql
--  @ : ����Ŭ�� ��ġ�� �⺻ ���
-- @?/demo/schema/human_resources/\HR_main.sql
--4. 123456 [��й�ȣ]
--5. users [tablespace]
--6. temp [temp tablespace] --�ӽ����̺����̽�
--7. [log ���] - @?/demo/schema/log



--3. 
--���̺� EMPLOYEES �� ���̺� ������ ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
DESC employees;

-- ������̺��� �����ȣ�� �̸��� ��ȸ
SELECT employee_id, first_name
FROM employees;

--4. ���̺� EMPLOYEES �� <����>�� ���� ��µǵ��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
--�ѱ� ��Ī�� �ο��Ͽ� ��ȸ
--*���Ⱑ ������, ����ǥ ��������
--*AS�� ��������
--���� employee_id AS ��� ��ȣ (X)
--      employee_id AS "��� ��ȣ" (0)
--      employee_id �����ȣ (0)
--AS (alias) : ��µǴ� �÷��� ������ ���� ��ɾ�
SELECT employee_id AS "��� ��ȣ"           --���Ⱑ ������ ""�� ǥ��
        , first_name AS �̸�
        , last_name AS ��
        , email AS �̸���
        , phone_number AS ��ȭ��ȣ
        , hire_date AS �Ի�����
        , salary AS �޿�
FROM employees
;

--
SELECT *            --(*) [�����͸�ũ] : ��� �÷� ����
FROM employees
;

--5. ���̺� EMPLOYEES �� JOB_ID�� �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
--DISTINCT ��� ��ɾ �����. 
-- DISTINCT �÷���: �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� Ű����
SELECT DISTINCT job_id FROM employees;


--6. ���̺� EMPLOYEES �� SALARY(�޿�)�� 6000�� �ʰ��ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
--WHERE ����: ��ȸ ������ �ۼ��ϴ� ����
SELECT * FROM employees
WHERE salary >6000;

--7. ���̺� EMPLOYEES �� SALARY(�޿�)�� 10000�� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM employees
WHERE salary = 10000;       --sql������ �񱳿����� = �ϳ��� �����

--8. ���̺� EMPLOYEES �� ��� �Ӽ����� SALARY �� �������� �������� �����ϰ�, FIRST_NAME �� �������� �������� ����
--   �Ͽ� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ���� ��ɾ� : ORDER BY �÷��� [ASC/DESC];
--�����ؼ� ���� �⺻�� ��������
SELECT * FROM employees ORDER BY salary DESC, first_name ASC;

--9. ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�. 
-- �÷����� ���� ������ ���� ''�� ��. �׸��� �빮�ڷ� �����Ǿ�����. 
-- ��ɾ ��ҹ��� ������ ���°��� �ȿ� ����ִ� ���� �����ؾ� ��. 
--OR ���� : ~�Ǵ�, ~�̰ų�
--WHERE A OR B
SELECT * FROM employees 
WHERE job_id = 'FI_ACCOUNT' OR job_id = 'IT_PROG';

--10. ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�. 
--<����> IN Ű���带 ����Ͽ� SQL ������ �ϼ��Ͻÿ�.
-- * �÷��� IN ('A', 'B')   : OR ������ ��ü�Ͽ� ����� �� �ִ� Ű����
SELECT * FROM employees 
WHERE job_id IN ('FI_ACCOUNT', 'IT_PROG') ;

--11. ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �ƴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�. (HR ���� ���� ������)
-- <����> IN Ű���带 ����Ͽ� SQL ������ �ϼ��Ͻÿ�.
-- * �÷��� NOT IN ('A', 'B')   : OR ������ ��ü�Ͽ� ����� �� �ִ� Ű����
SELECT * FROM employees 
WHERE job_id NOT IN ('FI_ACCOUNT', 'IT_PROG') ;

--12. ���̺� EMPLOYEES �� JOB_ID�� ��IT_PROG�� �̸鼭 SALARY �� 6000 �̻��� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�
--���ǿ���: ~�̸鼭, �׸���, ���ÿ�
--WHERE A AND B;
SELECT * FROM employees WHERE job_id = 'IT_PROG' AND salary >=6000;

--13. ���̺� EMPLOYEES �� FIRST_NAME �� ��S���� �����ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
--WHERE first_name LIKE 'S%'
-- LIKE  : �÷��� LIKE '���ϵ�ī��';
-- % �������ڸ� ��ü
-- _ �� ���ڸ� ��ü
SELECT * FROM employees WHERE first_name LIKE 'S%';

--14. ���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ������ ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM employees WHERE first_name LIKE '%s';

--15. ���̺� EMPLOYEES �� FIRST_NAME �� �ҹ��ڡ�s���� ���ԵǴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM employees WHERE first_name LIKE '%s%';

--16. ���̺� EMPLOYEES �� FIRST_NAME �� 5������ ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM employees WHERE first_name LIKE '_____';
--�ƴϸ� �Լ��� �̿��� �� ����.
SELECT * FROM employees WHERE LENGTH(first_name) =5;

--17. ���̺� EMPLOYEES �� COMMISSION_PCT�� NULL �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- COMMISSION_PCT:������ ����
-- WHERE commition_pst =NULL; : ��� =�� ���� ���ϴ°ǵ�, NULL�� ���� �ƴϹǷ� �� �Ұ�. 
--IS NULL�̶�� Ű����� ����. 
SELECT * FROM employees WHERE commission_pct IS NULL;

--18. ���̺� EMPLOYEES �� COMMISSION_PCT�� NULL�� �ƴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

--19. ���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�� �̻��� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM employees WHERE hire_date >=  '04/01/01'; --SQL developer�� ������ �����͸� ��¥�� �����ͷ� �ڵ� ��ȯ
                            --DATEŸ��        CHARŸ��
--TO_DATE() : ���������� ��¥�� �����ͷ� ��ȯ�ϴ� �Լ�
SELECT * FROM employees WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD');
                            --DATEŸ��        DATEŸ��
                            
                            
--20. ���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�⵵���� 05�⵵�� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM employees WHERE hire_date >= '04/01/01' AND hire_date < '06/01/01';
SELECT * FROM employees WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD')
                            AND hire_date <= TO_DATE('20051231', 'YYYYMMDD')
;
SELECT * FROM employees WHERE hire_date BETWEEN  '04/01/01' AND '05/12/31';
SELECT * FROM employees WHERE hire_date BETWEEN TO_DATE('20040101', 'YYYYMMDD') AND TO_DATE('20051231', 'YYYYMMDD')
;

--21. 12.45, -12.45 ���� ũ�ų� ���� ���� �� ���� ���� ���� ����ϴ� SQL ���� ���� �ۼ��Ͻÿ�.
--- ��� : 13, -12


--22. 12.55�� -12.55 ���� �۰ų� ���� ���� �� ���� ū ���� ����ϴ� SQL ���� ���� �ۼ��Ͻÿ�.
--- ��� : 13, -12

--23. �� �ҹ����� ���õ� ���� �ڸ� ���� �̿��Ͽ� �ݿø��ϴ� SQL���� �ۼ��Ͻÿ�.
-- 0.54 �� �Ҽ��� �Ʒ� ù° �ڸ����� �ݿø��Ͻÿ�. �� ��� : 1
-- 0.54 �� �Ҽ��� �Ʒ� ��° �ڸ����� �ݿø��Ͻÿ�. �� ��� : 0.5
-- 125.67 �� ���� �ڸ����� �ݿø��Ͻÿ�. �� ��� : 130
-- 125.67 �� ���� �ڸ����� �ݿø��Ͻÿ�. �� ��� : 120


--24. �� �ҹ����� ���õ� �� ���� �̿��Ͽ� �������� ���ϴ� SQL���� �ۼ��Ͻÿ�.
--- 3�� 8�� ���� �������� ���Ͻÿ�. �� ��� : 3
--- 30�� 4�� ���� �������� ���Ͻÿ�. �� ��� : 2



--25. �� �ҹ����� ���õ� �� ���� �̿��Ͽ� �������� ���ϴ� SQL���� �ۼ��Ͻÿ�.
--- 2�� 10������ ���Ͻÿ�. �� ��� : 1024

--- 2�� 31������ ���Ͻÿ�. �� ��� : 2147483648


--26. �� �ҹ����� ���õ� ���� �̿��Ͽ� �������� ���ϴ� SQL���� �ۼ��Ͻÿ�.
--- 2�� �������� ���Ͻÿ�. �� ��� : 1.41421...
--- 100�� �������� ���Ͻÿ�. �� ��� : 10


--27. �� �ҹ����� ���õ� ���� �ڸ� ���� �̿��Ͽ� �ش� ���� �����ϴ� SQL���� �ۼ��Ͻÿ�.
--- 527425.1234 �� �Ҽ��� �Ʒ� ù° �ڸ����� �����Ͻÿ�.
--- 527425.1234 �� �Ҽ��� �Ʒ� ��° �ڸ����� �����Ͻÿ�.
--- 527425.1234 �� ���� �ڸ����� �����Ͻÿ�.
--- 527425.1234 �� ���� �ڸ����� �����Ͻÿ�.


--28. �� �ҹ����� ���õ� ���� �̿��Ͽ� ������ ���ϴ� SQL���� �ۼ��Ͻÿ�.
--    -20 �� ������ ���Ͻÿ�.
--    -12.456 �� ������ ���Ͻÿ�.


--29. <����>�� ���� ���ڿ��� �빮��, �ҹ���, ù���ڸ� �빮�ڷ� ��ȯ�ϴ� SQL���� �ۼ��Ͻÿ�.
--���� �빮�� �ҹ��� ù���ڸ� �빮��
--AlOhA WoRlD~! ALOHA WORLD~! aloha world~! Aloha World~!


--30. <����>�� ���� ���ڿ��� ���� ���� ����Ʈ ���� ����ϴ� SQL���� �ۼ��Ͻÿ�.




--31. <����>�� ���� ���� �Լ��� ��ȣ�� �̿��Ͽ� �� ���ڿ��� �����Ͽ� ����ϴ� SQL���� �ۼ��Ͻÿ�.
