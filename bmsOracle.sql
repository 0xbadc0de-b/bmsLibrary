/*
Oracle Dual ���̺��̶�?
 - ����Ŭ ��ü���� �����Ǵ� ���̺�
 - �����ϰ� �Լ��� �̿��ؼ� ��� ������� Ȯ�� �� �� ����ϴ� ���̺�
*/


����PC ����Ŭ Oracle Database 11g Express Edition�� 
Oracle SQL Developer�� localhost ���Ӱ��� => sys / root
;



-- �¶��� ����Ŭ �׽�Ʈ ����Ʈ
-- https://sqltest.net/

����??? �� �ȵ���?? ����? AAAA

-- ������ Į�� �����, ����� '�����ڵ�: 1' ������ �ڵ� ä������ ������
select '�����ڵ�: ', 1, job_id, job_title, min_salary from jobs;

-- Į�� �̸��ٲٱ�(alias), ���� ���
select job_id as ����ID, job_title as ������, min_salary as �ּ��ӱ� from jobs;
select job_id as "���� ID", job_title as "���� ��", min_salary as "�ּ� �ӱ�" from jobs;

-- ��������� ��� ����
select job_id, job_title, min_salary * 12 as �ּҿ��� from jobs;

select '�����ڵ�: ' || job_id, job_title, min_salary from jobs;
-- �Ʒ� ���ó�� ���ڸ� ������
-- �����ڵ�: job-id1, job_title1, min_salary2
-- �����ڵ�: job-id2, job_title2, min_salary2
-- ...(���)


select employee_id, salary, manager_id from employees 
where manager_id is null;     -- �޴���ID�� ����(NULL) ���ڵ常 ����


-- �� �������α׷��� ��Ʈ ��ȣ�� ��ġ�� �ʱ� ���� 
-- ����Ŭ ������ 8080 ��Ʈ ������ ���� SYS ������ SYSBDA �������� ������
select dbms_xdb.gethttpport() from dual;
-- �� ���� ����� ����� 8080 ��Ʈ�̸� �Ʒ� ������ �����Ͽ� 9090 ��Ʈ�� ����
exec dbms_xdb.sethttpport(9090);


-- BETWEEN�� ��¥, ������ ���� �˻��� ���� �����ϸ�, ������ ���� �˻��� ����
-- BETWEET �����ڿ� �� ������(>=, <=)�� ������ ����� �˻�������, Ư���� ��찡 �ƴϸ� BETWEEN �����ڸ� ����� ���� ����
-- �� �÷��� BETWEEN �������� AND �������� 
-- �� �÷��� >= �������� AND �÷��� <= ��������
-- [ ��¥ ���� �˻� ]
SELECT * FROM emp 
WHERE 1=1 
AND hiredate BETWEEN TO_DATE('1981-01-01', 'YYYY-MM-DD') AND TO_DATE('1981-12-31', 'YYYY-MM-DD')
-- [ ���� ���� �˻� ]
SELECT * FROM emp 
WHERE empno BETWEEN 7000 AND 7600                   


;
-- LIKE ���ǽ��� ���ڿ��� ������ �˻��� �� ����ϴ� ���ǽ��̴�. 
SELECT emp_name FROM employees
WHERE 1=1
AND emp_name LIKE 'A%'   -- A�� �����ϴ� ���ڿ�
AND emp_name LIKE '%A'   -- A�� ������ ���ڿ�
AND emp_name LIKE '%A_'  -- ���� ���ڿ��� A�ڿ� �ѱ��� ������ ���� ���ڿ�
ORDER BY emp_name
;


-- �� ���̺��� ���� ����� ���η� �ٿ��� �����ֱ�
-- union all�� �ټ��� ���̺��� �÷��� �ѹ��� ����ϱ� ���մϴ�.(������ ����)
-- UNION       : �� ���̺��� ����� �ߺ������Ͽ� ����մϴ�.
-- UNION ALL   : �� ���̺��� ����� �ߺ�����Ͽ� ����մϴ�.
select * from ATable
union all
select * from BTable
;

select NO, NAME 
from(
      select * from ATable
      union all
      select * from BTable
	)
;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ���� (JOIN), �ƿ��� ����(Outer Join)
-- https://goddaehee.tistory.com/62 <---- ���� ������� ����!!!!!
-- �� ���̺��� ���� ����� ���η� �ٿ��� �����ֱ�
-- where �������� �� ���̺��� �÷��� ��ġ�ϴ� ������ �����������
SELECT table.column, table.column
FROM table1, table2
WHERE table1.column1 = table2.column2
;



-- GROUP�� Ư�� �÷��� �������� ���踦 ���µ� ���ȴ�.
-- SELECT [GROUP BY ���� ������ �÷�1] [GROUP BY���� ������ ��] 
-- FROM [���̺� ��] 
-- GROUP BY [ �׷����� ���� �÷� �� ]
SELECT CLASS, SUM(SCORE) 
FROM TBL_REPORT_CARD 
GROUP BY CLASS
;

/*
GROUP BY
 - �����͵��� ���ϴ� �׷����� ������ ������ �մϴ�.
 - GROUP BY ���� ��ġ�� WHERE �� ORDER BY�� ���̿� ��ġ�Ѵ�.

HAVING
 - GROUP BY ���� ���� ��
 - WHERE �������� �����Լ��� ����� �� ����.
 - HAVING ���� �����Լ��� ������ ���Ǻ񱳸� �� �� ����Ѵ�.
 - GROUP BY [�׷����� �÷�] HAVING [����]
*/
SELECT depart_no, SUM(salary), SUM(commission)
FROM emp 
GROUP BY depart_no 
HAVING SUM(commission) >= 2000 
ORDER BY SUM(commission)






desc jobs;		-- jobs ���̺��� Į�� �̸��� ����
describe jobs;



-- ����� ����(book_ex) ����, identified by �ڿ��� �н�����(book_ex)
-- �⺻���̺� �����̽� USERS, �ӽ����̺� �������� TEMP
create user book_ex identified by book_ex
default tablespace USERS
temporary tablespace TEMP;


-- ���ӱ��� �� DBA ���� �ο�
grant connect, dba to book_ex;





-- row ����
DELETE FROM ���̺�� -- ���̺���ü
DELETE FROM ���̺�� where �÷��� = [����] -- ���ǿ� �´� row ����



--UPDATE��
-- UPDATE ���̺��
-- SET 
-- �÷�1 = ������ ��,
-- �÷�2 = ������ ��
-- .....
-- WHERE
-- ����;


----------------------------------------------------------------------------------------------------
-- select ����� update
----------------------------------------------------------------------------------------------------
update test
set (pk, id, name) = (select pk, id, name from test1 where pk = 1) -- ���� �ش� ���������� ��ȸ��� ������ 2�� �̻��� �� ����
;

update test
    set count = test.count + a.count
    from (select * from test1) as a
    where test.pk = a.pk 
-- test���̺� �� pk�� test1 ���̺� �� pk �� ���� �����Ϳ��� count�� �߰�����
-- ���ε� ����
;



;
-- ���������� ��� �ӽ����̺� �����
-- ����Ŭ WITH�� ���� & ���� (�ӽ� ���̺� �����)
-- https://coding-factory.tistory.com/445
-- https://superkong1.tistory.com/35
-- WITH���� ���ǵ� ������ ������ ����Ҽ��� ȿ���� �����մϴ�.
-- WITH���� ���ǵ� ������ �ѹ��� ����Ѵٸ� ���������� ����ϴ°Ͱ� ũ�� �������̰� ���� �ʽ��ϴ�.
--
-- 1) with�� ����
WITH 
EXAMPLE AS(
      SELECT 'WITH��' AS STR1 FROM DUAL
)
SELECT * FROM EXAMPLE
;
--
-- 2) ���� with�� ����
WITH 
EXAMPLE1 AS ( --ù��° WITH��
      SELECT 'EX1' A FROM DUAL 
      UNION ALL
      SELECT 'EX2' FROM DUAL
), 
EXAMPLE2 AS ( --�ι�° WITH��
      SELECT 'EX3' A FROM DUAL 
      UNION ALL
      SELECT A FROM EXAMPLE1 --ù��° WITH�� ����
) 
SELECT * FROM EXAMPLE2
;



https://offbyone.tistory.com/253
����Ŭ MERGE INTO ������ ������ UPDATE ������ INSERT �ѹ��� �����ϱ�




----------------------------------------------------------------
-- Sequence ��ȸ/����
-- https://ditus.tistory.com/entry/Oracle-Sequence-��ȸ����
CREATE SEQUENCE idx;    -- ������ ����
DROP SEQUENCE idx;		-- ������ ����

���ǵ� ������ ��ȸ
select * from user_sequences

���� ������ ��ȸ
select ����������.currval from dual

���� ������ ��ȸ
select ����������.nextval from dual

create table tbl_board (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate
);

-- https://luji.tistory.com/71
-- ����Ŭ auto_increment (������)
INSERT INTO tmp values(tmp_seq.NEXTVAL, 'tmptmp');



----------------------------------------------------------------
alter table tbl_board add constraint pk_board  -- Primary Key(PK) ����
primary key (bno);


----------------------------------------------------------------
-- ������ ����, row ����
insert into tbl_board (bno, title, content, writer)
values (seq_board.nextval, '�׽�Ʈ ����', '�׽�Ʈ ����', user00);     -- ������.nextval �Ź� ���ο� ��ȣ�� �Ҵ�








--------------------------------------------------------------------------------------------------------
-- ����Ŭ �����Լ� ����
--------------------------------------------------------------------------------------------------------

select chr(65) from dual;     -- �ƽ�Ű�ڵ带 ����(A)�� ���

select ascii('A') from dual;  -- ���ڸ� hex��(65)���� ���

select concat('Republic of ', 'KOREA') from dual;     -- ���ڿ� ���̱�

select initcap('MR. TEsT') from dual;     -- �� �ܾ� �ձ��� �빮��, ������ �ҹ���

select lower('Mr. TesT') from dual; -- ��� ���� �ҹ��� ��ȯ
select upper('Mr. TesT') from dual; -- ��� ���� �빮�� ��ȯ

select lpad('TEST', 8, '*') from dual;    -- (���� ä��)��ü ���̰� 8�� �ǵ��� ���ʿ� * ä��
select lpad(�÷���, 8, '*') from ���̺��;

select rpad('TEST', 8, '*') from dual;    -- (������ ä��)��ü ���̰� 8�� �ǵ��� �����ʿ� * ä��



----------------------------------------------------------------------------------------------------------------------------------------------
-- �÷����� ������ ����(or ����)�� ���ʿ��� ������ ���
SELECT LTRIM(' �׽�Ʈ�Դϴ�') AS LTRIM_ONE 
      ,LTRIM('�׽�Ʈ�Դϴ�','�׽�Ʈ') AS LTRIM_TWO
      ,LTRIM('�׽�Ʈ�Դϴ�','��Ʈ') AS LTRIM_THREE 
      FROM DUAL;

-- �÷����� ������ ����(or ����)�� �����ʿ��� ������ ���
SELECT 
       RTRIM('�׽�Ʈ�Դϴ� ') AS RTRIM_ONE 
      ,RTRIM('�׽�Ʈ�Դϴ�','�ϴ�') AS RTRIM_TWO
      ,RTRIM('�׽�Ʈ�Դϴ�','�Դ�') AS RTRIM_THREE 
FROM DUAL;

-- �÷����� ������ ����(or ����)�� ���ʿ��� ������ ���
-- LEADING : ���ʿ��� ����  |  TRAILING : �����ʿ��� ����  |  BOTH : ���ʿ��� ����
-- Ư���� �������ִ� ���� ������ �⺻���� BOTH
-- ������ ���ڴ� ���� �Ѱ�(ltrim, rtrim�� ������ ����)
SELECT TRIM(' �׽�Ʈ�Դϴ� ') AS TRIM_ONE 
        ,TRIM('��' FROM '�ٴ� �׽�Ʈ�Դϴ�') AS TRIM_TWO
        ,TRIM(BOTH '��' FROM '�ٴ� �׽�Ʈ�Դϴ�') AS TRIM_THREE 
        ,TRIM(LEADING '��' FROM '�ٴ� �׽�Ʈ�Դϴ�') AS TRIM_FOUR
        ,TRIM(TRAILING '��' FROM '�ٴ� �׽�Ʈ�Դϴ�') AS TRIM_FIVE
        FROM DUAL;
		
		
----------------------------------------------------------------------------------------------------------------------------------------------
-- SUBSTR �Լ��� ���ڴ����� ������ġ�� �ڸ� ���̸� �����Ͽ� ���ڿ��� �ڸ���.
-- - �Լ�  :  SUBSTR("���ڿ�", "������ġ", "����")
--[�տ������� ���ڿ��� �ڸ��� ���]
SELECT ENAME
     , SUBSTR(ENAME, 2)
     , SUBSTR(ENAME, 2, 3)
FROM EMP
--[�ڿ������� ������ �ڸ��� ���]
SELECT ENAME
     , SUBSTR(ENAME, -3)
     , SUBSTR(ENAME, -3, 2)
FROM EMP


-----------------------------------------------------------------------------
-- TO_CHAR() �Լ��� ��¥, ���� ���� ���� ���ڿ��� ��ȯ�ϴ� �Լ�
-- (����)https://gent.tistory.com/331
-- ��¥ ���� ���� (YYYY-MM-DD)
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')              --20200723
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD')            --2020/07/23
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD')            --2020-07-23
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') --2020-07-23 11:10:52
FROM dual;



-- https://kongda.tistory.com/36
-- https://dev4u.tistory.com/100
-- ����Ŭ 1000���� ���ڰ��� 3�ڸ� ���� �޸�(,) ���
SELECT TO_CHAR( num_col , 'FM999,999,999') FROM DUAL;
SELECT TO_CHAR( num_col , '999,999,999,999,999') FROM DUAL;


-- https://gent.tistory.com/69
-- ����Ŭ(Oracle) ��¥ ����(Week) ���ϴ� ���
TO_CHAR ( "��¥", "����" )




---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DECODE �Լ��� ���α׷��ֿ�����  if else �� ����� ����� �����Ѵ�. ������ ������� �Ʒ��� ����.
-- ���� 4���϶�: DECODE(�÷�,����,TRUE �����,FALSE �����)
-- ���� 5�� �̻��϶�: DECODE(�÷�, ����1, ���1, ����2, ���2, ����3, ���3..........) 
-- https://gent.tistory.com/227
-- https://coding-factory.tistory.com/297
-- ELSE �κ��� ������ �����ϴ�. �ش� ������ ������ NULL
SELECT gender
     , DECODE(gender, 'M', '����', 'F', '����', '��Ÿ') gender2
  FROM temp





---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TO_CHAR : ���ڳ� ��¥�� ���ڿ��� ��ȯ
-- TO_NUMBER : ���ڸ� ���ڷ� ��ȯ
-- TO_DATE : ���ڸ� ��¥�� ��ȯ


-- ���ڿ� ��¥�� ���ϴ� ���ڿ� �������� �����ϱ�
-- ��¥���� ������ TO_CHAR �Լ��� ����Ͽ� ���� ������ �� �ִ�. �׷��� ���ڿ� ��¥, 
-- ������� "20180823"�� "2018-08-23"���� ���� �ϱ� ���ؼ��� ���ŷο� �۾��� �ʿ��ϴ�.
-- �Ʒ��� 2������ ����� ����Ͽ� ������ �����ϴ� �����̴�. 
-- ù��°�� ���ڿ��� TO_DATE �Լ��� ��¥������ ������ ���� �ٽ� TO_CHAR �Լ��� ����Ͽ� ���ϴ� �������� �����ϴ� ����̴�.
-- �ι�°�� ���Խ��Լ� REGEXP_REPLACE�� ����Ͽ� ���ϴ� �������� ���ڿ��� ������ �����ϴ� ����̴�. 
-- �� �Լ��� ����Ŭ 10g �̻��� �������� ��밡�� �ϴ�.
SELECT TO_CHAR(TO_DATE('20180823', 'YYYYMMDD'), 'YYYY-MM-DD') AS T1 FROM DUAL; 
SELECT REGEXP_REPLACE('20180823', '(.{4})(.{2})(.{2})', '\1-\2-\3') AS T2 FROM DUAL;


-- ��¥+�ð��� ���Ե� ���ڿ��� Date �������� ��ȯ
��)2023/03/14 17:05:01
SELECT TO_DATE( '2023/03/14 17:05:01', 'YYYY/MM/DD HH24:MI:SS' ) FROM DUAL;

��)2023-03-14 ���� 5:50:30
-- �Ʒ�ó�� AM / PM ����� ����
SELECT TO_DATE( '2023-03-14 ���� 5:50:30', 'YYYY-MM-DD AM HH:MI:SS' ) FROM DUAL;
SELECT TO_DATE( '2023-03-14 ���� 5:50:30', 'YYYY-MM-DD PM HH:MI:SS' ) FROM DUAL;



select mod(10,3) from daul;
-- MOD ������ ���ϱ� �Լ�
-- ���: 1


-- TRUNC �Լ��� �ַ� �Ҽ��� ���� �� ��¥�� �ð��� ���� �� ����Ѵ�.
-- 10 ������ 3 = 3.3333333...  �ϰ�� �Ҽ��� �����Ͽ� ����� 3
-- �ᱹ ������ ������ �� �������°ų�
select trunc(10/3) from dual; 


------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- https://coding-factory.tistory.com/461
-- https://tragramming.tistory.com/82
-- ����Ŭ ������ ����
START WITH.. CONNECT BY
SYS_CONNECT_BY_PATH
;

-- https://devjhs.tistory.com/171
-- CONNECT_BY_ISLEAF - �ڽ� ��� ã��


select * from dep;

DEP_CD PARENT_CD DEPT_NAME
101     		�Ѱ����ߺ�
102	    101	    ����ϰ��߼���
103	    101	    �����߼���
104	    101	    �ý��۰��߼���
105	    102	    ���θ�(�����)
106	    103	    ����SI
107	    103	    ���θ�
108	    105	    ����������
109	    106	    ����1��
100	    106	    ����2��
111	    104	    ERP�ý���
112	    106	    �׽�Ʈ1
;

SELECT	LPAD(' ', 4*(LEVEL-1)) || DEPT_NAME AS "�μ���",
                LEVEL,
                DEP_CD,
                PARENT_CD,                
                CONNECT_BY_ISLEAF AS LEAF   -- �ڽĳ�� ���翩��(0:���� / 1:����)
FROM DEP 
START WITH PARENT_CD IS NULL --�ֻ������ ����,
CONNECT BY PRIOR DEP_CD = PARENT_CD --�θ���� �ڽĳ�� ����
--ORDER SIBLINGS BY  DEP_CD -- �Ϲ����� ORDER BY �� �ƴ� ���������� ����
;


https://jogakleeron.tistory.com/49
���������� �����ϱ� ORDER SIBLINGS BY





---------------------------------------------------------------------------------
-- https://coding-factory.tistory.com/417
--����Ŭ ��(view) ����/����
CREATE OR REPLACE VIEW [��Ű��.][�� NAME] AS
SELECT��;
--��(View) ����
DROP VIEW [��Ű��.][�� NAME]
--��(View) ���� Ȯ��
desc [��Ű��.][�� NAME];



------------------------------------------------------------------------------------------------------------------------------------------
-- https://offbyone.tistory.com/245
-- https://bebeya.tistory.com/entry/����Ŭ-DBLINK���ũ-��ȸ��������-���
-- https://bangu4.tistory.com/322
-- https://bebeya1.tistory.com/3
-- ���Ǿ�(�ó���) ����
-- DB��ũ ����
SELECT * FROM ALL_SYNONYMS;

����������(PUBLIC / PRIVATE)�� �����Ѵ� 
- PUBLIC   ��� ������ ��밡���� ���븵ũ�� ���鶧 �����Ѵ�.
- PRIVATE Ư�� ������ ��밡�� �� DB��ũ�� ���鶧 �����Ѵ�. 

CREATE [PUBLIC/PRIVATE] DATABASE LINK [��ũ�� ����� ��Ī] 
CONNECT TO [������ �α��� ������] 
IDENTIFIED BY "[������ ���� �н�����]" 
USING [���ü����� tnsnames.ora�� ������ ������ ��Ī�̸�]


------------------------------------------------------------------------------------------------------------------------------------------
https://joont.tistory.com/153
ORA-28001, ����Ŭ �н����� ���� �ذ�


select username, account_status, lock_date, expiry_date, created, profile
from dba_users 
where username='BOOK_EX'
;

alter user BOOK_EX identified by book_ex
;


select * from dba_profiles 
where resource_type='PASSWORD'
;


------------------------------------------------------------------------------------------------------------------------------------------
/*
https://gent.tistory.com/241
https://gent.tistory.com/192
https://dpdpwl.tistory.com/121
	��¥ �� ���� �ݿø�, ����
	ROUND("��", "�ڸ���")	-- �ݿø�
	TRUNC("��", "�ɼ�")	-- ����(����)
	CEIL("��")			-- �Ҽ��� ù°�ڸ� �ø�, �ڸ��� �����Ұ�
	FLOOR("��")			-- �Ҽ��� ù°�ڸ� ����, �ڸ��� �����Ұ�
*/
SELECT CEIL(3.1) FROM DUAL;		-- 4
SELECT FLOOR(3.7) FROM DUAL;	-- 3


MOD(M,N) : M�� N���� ���������� ������ ��ȯ


CONNECT BY LEVEL	���ӵ� ���� ��ȸ�Ҷ� Ȱ��



;
-- https://gent.tistory.com/405
-- # �ð� ���� ���
-- 13:00���� 15:00���� �ð� ���̴� 2�ð����� ��� �Ǿ ��ȯ�ȴ�.
-- �ð��� �ʰ� �Բ� �����ϸ� �Ҽ����� �߻��ϹǷ� �� ROUND �Լ��� �Ҽ����� ó���� ��� �Ѵ�.
SELECT ROUND((TO_DATE('15:00', 'HH24:MI') - TO_DATE('13:00', 'HH24:MI')) * 24, 2) FROM dual

;

-- ����) 
SELECT
  (EXTRACT(DAY FROM (TO_TIMESTAMP('20230630185121', 'YYYYMMDDHH24MISS') - TO_TIMESTAMP('20230630085531', 'YYYYMMDDHH24MISS'))) * 24 +
  EXTRACT(HOUR FROM (TO_TIMESTAMP('20230630185121', 'YYYYMMDDHH24MISS') - TO_TIMESTAMP('20230630085531', 'YYYYMMDDHH24MISS')))) AS hours,
  EXTRACT(MINUTE FROM (TO_TIMESTAMP('20230630185121', 'YYYYMMDDHH24MISS') - TO_TIMESTAMP('20230630085531', 'YYYYMMDDHH24MISS'))) AS minutes,
  EXTRACT(SECOND FROM (TO_TIMESTAMP('20230630185121', 'YYYYMMDDHH24MISS') - TO_TIMESTAMP('20230630085531', 'YYYYMMDDHH24MISS'))) AS seconds
FROM
  dual;



-- ���̺� ����
DROP TABLE ���̺��;


-- ���ν���(PROCEDURE) ����
EXEC ���ν�����;


https://coding-factory.tistory.com/453
���ν�����?
- �Լ��� Ư�� ������ ������ �� ��� ���� ��ȯ������ 
- ���ν����� Ư���� ������ ó���ϱ⸸ �ϰ� ��� ���� ��ȯ���� �ʴ� ���� ���α׷� ��






/*
https://moonong.tistory.com/48
����Ŭ �⺻Ű(PK) 2�� �̻� �����ϱ�
	- �⺻Ű�� �����ϴ� �÷��� ������ ���� �־
	- �⺻Ű�� ������ ���� ����
*/	
CREATE TABLE TEST(
    CODE VARCHAR2(30), 
    SEQ NUMBER,    
    CONSTRAINT [�⺻Ű�̸��ƹ��ų�] PRIMARY KEY(CODE, SEQ)
);
-- �� ��� �� �� �÷��� �ϳ��� �⺻Ű�� �۵��ϱ� ������ �÷�1 / 2�� ���� �ߺ��� �� ������, 
-- �÷� 1 & 2 �� ���� �ߺ��Ǵ� ��쿡�� �⺻Ű�� UNIQUE ������ ���� �ȴ�. 

-- ���̺� PK Ȯ�ι��
-- https://gent.tistory.com/202
SELECT *
FROM 
      ALL_CONS_COLUMNS A
    , ALL_CONSTRAINTS  B
WHERE 1=1
    AND A.TABLE_NAME = B.TABLE_NAME
    AND A.TABLE_NAME = 'EXAMPLE5'   -- ������ ���� ���̺��
    AND B.CONSTRAINT_TYPE = 'P' 
	AND A.OWNER = B.OWNER
	AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
;


/*
https://positivemh.tistory.com/330
����Ŭ Primary Keys ����
	1. PK ���� - CREATE TABLE �� ���
	2. PK ���� - ALTER TABLE �� ���
	3. PK ����
	4. PK ��Ȱ��ȭ
	5. PK Ȱ��ȭ
*/	
-- PK ��Ȱ��ȭ
ALTER TABLE [������̺��]
DISABLE CONSTRAINT [��� PK��];   -- [��� PK��] == CONSTRAINT_NAME

;
https://gent.tistory.com/475
http://www.gurubee.net/article/61158
����Ŭ ���� ���� ��¥ ��� ���ϱ�
�ִ밪�� �������� ��� ���� �ֽ� ��¥�� �ִ밪�� ����
	ROWNUM
	ROW_NUMBER() OVER()
	MAX() KEEP()
;


select *
from emp
 WHERE job IN ('MANAGER', 'SALESMAN') ;


SELECT job
     , MAX(sal) KEEP(DENSE_RANK LAST ORDER BY sal)   AS sal_last
     , MAX(ename) KEEP(DENSE_RANK LAST ORDER BY sal) AS ename_last
  FROM emp
 WHERE job IN ('MANAGER', 'SALESMAN')
 GROUP BY job;


;


--------------------------------------------------------------------------------
https://gent.tistory.com/442
https://wakestand.tistory.com/243
����Ŭ OVER() �Լ�
    - �м�_�Լ�() OVER(PARTITION BY �÷� / ORDER BY �÷� / ���� ���� ����)
    - �м� �Լ��� OVER()�� �ʼ�
    - �м� �Լ� ����
        COUNT(�÷�) - ����
        SUM(�÷�) - �հ�
        AVG(�÷�) - ���
        MAX(�÷�) - �ִ밪
        MIN(�÷�) - �ּҰ�
        RANK() OVER(ORDER BY �÷�...) - ����
        DENSE_RANK() OVER(ORDER BY �÷�...) - �ߺ� ������ �־ 1�� ����
        ... �� ����




--------------------------------------------------------------------------------
https://gent.tistory.com/189
NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�.
	- �Լ�  :  NVL("��", "������") 
NVL2 �Լ��� NULL�� �ƴ� ��� ������1��  ����ϰ�, NULL�� ��� ������2�� ����Ѵ�.
	- �Լ� :  NVL2("��", "������1", "������2") // NVL2("��", "NOT NULL", "NULL") 
	
    
--------------------------------------------------------------------------------
https://gent.tistory.com/422
����Ŭ ���ڿ� ���� ���ϱ� (LENGTH, LENGTHB)
	SELECT LENGTH('����Ŭ'), LENGTH('����Ŭ SQL')
	FROM dual




--------------------------------------------------------------------------------
https://gent.tistory.com/260
����Ŭ ADD_MONTHS �Լ� ���� (������, ������, ������)
	ADD_MONTHS( '��¥', '����' )




--------------------------------------------------------------------------------
https://allmana.tistory.com/83
�� ������ �� ���� ��ġ��
���� ����� ���η� ��ȯ�ϱ�
	LISTAGG(�÷�,������) WITHIN GROUP(ORDER BY �������÷��� ����)
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
https://meyouus.tistory.com/175
����Ŭ ���� ä�� CONNECT BY LEVEL Ȱ���ϱ�  

    SELECT LEVEL AS NO FROM DUAL CONNECT BY LEVEL <=10;
    
    SELECT '2020 �� '||LPAD(LEVEL, 2, 0)||'��' AS NO FROM DUAL
    CONNECT BY LEVEL <=12;


    Ư�� ��¥ ���� ��ȸ�ϱ�
    �˻������� From ~ To ������ ��¥ ����Ʈ�� ���Ҽ��� �ֽ��ϴ�.
    ex) From : 2020�� 07�� 1��  / To : 2020�� 07�� 17��
;

SELECT TO_DATE('20200701', 'YYYYMMDD') + (LEVEL-1) AS DT
   FROM DUAL
CONNECT BY LEVEL <= (TO_DATE('20200717', 'YYYYMMDD') - TO_DATE('20200701', 'YYYYMMDD')) + 1
;


WITH WD AS
(
    SELECT TO_DATE('20200701', 'YYYYMMDD') AS FROM_DT   -- ��������
         , TO_DATE('20200717', 'YYYYMMDD') AS TO_DT     -- ��������    
      FROM DUAL
)
SELECT DT, DT2
  FROM ( 
     SELECT TO_CHAR(FROM_DT + (LEVEL-1), 'YYYYMMDD') AS DT
          , TO_CHAR(FROM_DT + (LEVEL-1), 'YYYY-MM-DD') AS DT2
       FROM WD
    CONNECT BY LEVEL <= (TO_DT - FROM_DT) + 1
  )
  ;

    
    