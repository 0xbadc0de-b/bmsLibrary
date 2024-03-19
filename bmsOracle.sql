/*
Oracle Dual 테이블이란?
 - 오라클 자체에서 제공되는 테이블
 - 간단하게 함수를 이용해서 계산 결과값을 확인 할 때 사용하는 테이블
*/


로컬PC 오라클 Oracle Database 11g Express Edition에 
Oracle SQL Developer로 localhost 접속계정 => sys / root
;



-- 온라인 오라클 테스트 사이트
-- https://sqltest.net/

과연??? 왜 안되지?? 뭘까? AAAA

-- 임의의 칼럼 만들기, 결과에 '직업코드: 1' 내용이 자동 채워져서 보여짐
select '직업코드: ', 1, job_id, job_title, min_salary from jobs;

-- 칼럼 이름바꾸기(alias), 별명 사용
select job_id as 직업ID, job_title as 직업명, min_salary as 최소임금 from jobs;
select job_id as "직업 ID", job_title as "직업 명", min_salary as "최소 임금" from jobs;

-- 산술연산자 사용 가능
select job_id, job_title, min_salary * 12 as 최소연봉 from jobs;

select '직업코드: ' || job_id, job_title, min_salary from jobs;
-- 아래 결과처럼 문자를 연결함
-- 직업코드: job-id1, job_title1, min_salary2
-- 직업코드: job-id2, job_title2, min_salary2
-- ...(계속)


select employee_id, salary, manager_id from employees 
where manager_id is null;     -- 메니저ID가 없는(NULL) 레코드만 추출


-- 웹 응용프로그램과 포트 번호가 곁치지 않기 위해 
-- 오라클 웹접속 8080 포트 변경을 위해 SYS 계정에 SYSBDA 권한으로 접속후
select dbms_xdb.gethttpport() from dual;
-- 위 쿼리 실행시 결과가 8080 포트이면 아래 쿼리를 실행하여 9090 포트로 변경
exec dbms_xdb.sethttpport(9090);


-- BETWEEN은 날짜, 숫자의 범위 검색에 아주 유용하며, 문자의 범위 검색도 가능
-- BETWEET 연산자와 비교 연산자(>=, <=)는 동일한 결과가 검색되지만, 특수한 경우가 아니면 BETWEEN 연산자를 사용할 것을 권장
-- ① 컬럼명 BETWEEN 시작일자 AND 종료일자 
-- ② 컬럼명 >= 시작일자 AND 컬럼명 <= 종료일자
-- [ 날짜 범위 검색 ]
SELECT * FROM emp 
WHERE 1=1 
AND hiredate BETWEEN TO_DATE('1981-01-01', 'YYYY-MM-DD') AND TO_DATE('1981-12-31', 'YYYY-MM-DD')
-- [ 숫자 범위 검색 ]
SELECT * FROM emp 
WHERE empno BETWEEN 7000 AND 7600                   


;
-- LIKE 조건식은 문자열의 패턴을 검색할 때 사용하는 조건식이다. 
SELECT emp_name FROM employees
WHERE 1=1
AND emp_name LIKE 'A%'   -- A로 시작하는 문자열
AND emp_name LIKE '%A'   -- A로 끝나는 문자열
AND emp_name LIKE '%A_'  -- 임의 문자열후 A뒤에 한글자 더오고 끝나 문자열
ORDER BY emp_name
;


-- 두 테이블의 쿼리 결과를 세로로 붙여서 보여주기
-- union all은 다수의 테이블의 컬럼을 한번에 출력하기 위합니다.(쿼리의 결합)
-- UNION       : 두 테이블의 결과를 중복제거하여 출력합니다.
-- UNION ALL   : 두 테이블의 결과를 중복허용하여 출력합니다.
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
-- 조인 (JOIN), 아우터 조인(Outer Join)
-- https://goddaehee.tistory.com/62 <---- 여기 설명먼저 보자!!!!!
-- 두 테이블의 쿼리 결과를 가로로 붙여서 보여주기
-- where 조건절에 두 테이블의 컬럼중 일치하는 정보를 기입해줘야함
SELECT table.column, table.column
FROM table1, table2
WHERE table1.column1 = table2.column2
;



-- GROUP는 특정 컬럼을 기준으로 집계를 내는데 사용된다.
-- SELECT [GROUP BY 절에 지정된 컬럼1] [GROUP BY별로 집계할 값] 
-- FROM [테이블 명] 
-- GROUP BY [ 그룹으로 묶을 컬럼 값 ]
SELECT CLASS, SUM(SCORE) 
FROM TBL_REPORT_CARD 
GROUP BY CLASS
;

/*
GROUP BY
 - 데이터들을 원하는 그룹으로 나누는 역할을 합니다.
 - GROUP BY 절의 위치는 WHERE 와 ORDER BY절 사이에 위치한다.

HAVING
 - GROUP BY 사용시 조건 값
 - WHERE 절에서는 집계함수를 사용할 수 없다.
 - HAVING 절은 집계함수를 가지고 조건비교를 할 때 사용한다.
 - GROUP BY [그룹핑할 컬럼] HAVING [조건]
*/
SELECT depart_no, SUM(salary), SUM(commission)
FROM emp 
GROUP BY depart_no 
HAVING SUM(commission) >= 2000 
ORDER BY SUM(commission)






desc jobs;		-- jobs 테이블의 칼럼 이름만 나열
describe jobs;



-- 사용자 계정(book_ex) 생성, identified by 뒤에가 패스워드(book_ex)
-- 기본테이블 스페이스 USERS, 임시테이블 스페이즈 TEMP
create user book_ex identified by book_ex
default tablespace USERS
temporary tablespace TEMP;


-- 접속권한 및 DBA 권한 부여
grant connect, dba to book_ex;





-- row 삭제
DELETE FROM 테이블명 -- 테이블전체
DELETE FROM 테이블명 where 컬럼명 = [조건] -- 조건에 맞는 row 삭제



--UPDATE문
-- UPDATE 테이블명
-- SET 
-- 컬럼1 = 변경할 값,
-- 컬럼2 = 변경할 값
-- .....
-- WHERE
-- 조건;


----------------------------------------------------------------------------------------------------
-- select 결과로 update
----------------------------------------------------------------------------------------------------
update test
set (pk, id, name) = (select pk, id, name from test1 where pk = 1) -- 만약 해당 서브쿼리의 조회결과 갯수가 2개 이상일 시 에러
;

update test
    set count = test.count + a.count
    from (select * from test1) as a
    where test.pk = a.pk 
-- test테이블 내 pk와 test1 테이블 내 pk 가 같은 데이터에만 count를 추가해줌
-- 조인도 가능
;



;
-- 서브쿼리문 대신 임시테이블 만들기
-- 오라클 WITH절 사용법 & 예제 (임시 테이블 만들기)
-- https://coding-factory.tistory.com/445
-- https://superkong1.tistory.com/35
-- WITH절에 정의된 쿼리는 여러번 사용할수록 효율이 증가합니다.
-- WITH절에 정의된 내용을 한번만 사용한다면 서브쿼리를 사용하는것과 크게 성능차이가 나지 않습니다.
--
-- 1) with절 사용법
WITH 
EXAMPLE AS(
      SELECT 'WITH절' AS STR1 FROM DUAL
)
SELECT * FROM EXAMPLE
;
--
-- 2) 다중 with절 사용법
WITH 
EXAMPLE1 AS ( --첫번째 WITH문
      SELECT 'EX1' A FROM DUAL 
      UNION ALL
      SELECT 'EX2' FROM DUAL
), 
EXAMPLE2 AS ( --두번째 WITH문
      SELECT 'EX3' A FROM DUAL 
      UNION ALL
      SELECT A FROM EXAMPLE1 --첫번째 WITH문 참조
) 
SELECT * FROM EXAMPLE2
;



https://offbyone.tistory.com/253
오라클 MERGE INTO 문으로 있으면 UPDATE 없으면 INSERT 한번에 수행하기




----------------------------------------------------------------
-- Sequence 조회/생성
-- https://ditus.tistory.com/entry/Oracle-Sequence-조회생성
CREATE SEQUENCE idx;    -- 시퀀스 생성
DROP SEQUENCE idx;		-- 시퀀스 삭제

정의된 시퀀스 조회
select * from user_sequences

현재 시퀀스 조회
select 시퀀스네임.currval from dual

다음 시퀀스 조회
select 시퀀스네임.nextval from dual

create table tbl_board (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate
);

-- https://luji.tistory.com/71
-- 오라클 auto_increment (시퀀스)
INSERT INTO tmp values(tmp_seq.NEXTVAL, 'tmptmp');



----------------------------------------------------------------
alter table tbl_board add constraint pk_board  -- Primary Key(PK) 지정
primary key (bno);


----------------------------------------------------------------
-- 데이터 삽입, row 생성
insert into tbl_board (bno, title, content, writer)
values (seq_board.nextval, '테스트 제목', '테스트 내용', user00);     -- 시퀀스.nextval 매번 새로운 번호를 할당








--------------------------------------------------------------------------------------------------------
-- 오라클 내장함수 정리
--------------------------------------------------------------------------------------------------------

select chr(65) from dual;     -- 아스키코드를 문자(A)로 출력

select ascii('A') from dual;  -- 문자를 hex값(65)으로 출력

select concat('Republic of ', 'KOREA') from dual;     -- 문자열 붙이기

select initcap('MR. TEsT') from dual;     -- 각 단어 앞글자 대문자, 나머지 소문자

select lower('Mr. TesT') from dual; -- 모든 문자 소문자 변환
select upper('Mr. TesT') from dual; -- 모든 문자 대문자 변환

select lpad('TEST', 8, '*') from dual;    -- (왼쪽 채움)전체 길이가 8이 되도록 왼쪽에 * 채움
select lpad(컬럼명, 8, '*') from 테이블명;

select rpad('TEST', 8, '*') from dual;    -- (오른쪽 채움)전체 길이가 8이 되도록 오른쪽에 * 채움



----------------------------------------------------------------------------------------------------------------------------------------------
-- 컬럼에서 지정한 문자(or 공백)를 왼쪽에서 제거한 결과
SELECT LTRIM(' 테스트입니다') AS LTRIM_ONE 
      ,LTRIM('테스트입니다','테스트') AS LTRIM_TWO
      ,LTRIM('테스트입니다','스트') AS LTRIM_THREE 
      FROM DUAL;

-- 컬럼에서 지정한 문자(or 공백)를 오른쪽에서 제거한 결과
SELECT 
       RTRIM('테스트입니다 ') AS RTRIM_ONE 
      ,RTRIM('테스트입니다','니다') AS RTRIM_TWO
      ,RTRIM('테스트입니다','입니') AS RTRIM_THREE 
FROM DUAL;

-- 컬럼에서 지정한 문자(or 공백)를 양쪽에서 제거한 결과
-- LEADING : 왼쪽에서 제거  |  TRAILING : 오른쪽에서 제거  |  BOTH : 양쪽에서 제거
-- 특별히 설정해주는 값이 없으면 기본값은 BOTH
-- 제거할 문자는 오직 한개(ltrim, rtrim은 여러개 가능)
SELECT TRIM(' 테스트입니다 ') AS TRIM_ONE 
        ,TRIM('다' FROM '다는 테스트입니다') AS TRIM_TWO
        ,TRIM(BOTH '다' FROM '다는 테스트입니다') AS TRIM_THREE 
        ,TRIM(LEADING '다' FROM '다는 테스트입니다') AS TRIM_FOUR
        ,TRIM(TRAILING '다' FROM '다는 테스트입니다') AS TRIM_FIVE
        FROM DUAL;
		
		
----------------------------------------------------------------------------------------------------------------------------------------------
-- SUBSTR 함수는 문자단위로 시작위치와 자를 길이를 지정하여 문자열을 자른다.
-- - 함수  :  SUBSTR("문자열", "시작위치", "길이")
--[앞에서부터 문자열을 자르는 방법]
SELECT ENAME
     , SUBSTR(ENAME, 2)
     , SUBSTR(ENAME, 2, 3)
FROM EMP
--[뒤에서부터 문열을 자르는 방법]
SELECT ENAME
     , SUBSTR(ENAME, -3)
     , SUBSTR(ENAME, -3, 2)
FROM EMP


-----------------------------------------------------------------------------
-- TO_CHAR() 함수는 날짜, 숫자 등의 값을 문자열로 변환하는 함수
-- (참고)https://gent.tistory.com/331
-- 날짜 포맷 변경 (YYYY-MM-DD)
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')              --20200723
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD')            --2020/07/23
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD')            --2020-07-23
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') --2020-07-23 11:10:52
FROM dual;



-- https://kongda.tistory.com/36
-- https://dev4u.tistory.com/100
-- 오라클 1000단위 숫자값에 3자리 마다 콤마(,) 찍기
SELECT TO_CHAR( num_col , 'FM999,999,999') FROM DUAL;
SELECT TO_CHAR( num_col , '999,999,999,999,999') FROM DUAL;


-- https://gent.tistory.com/69
-- 오라클(Oracle) 날짜 요일(Week) 구하는 방법
TO_CHAR ( "날짜", "포맷" )




---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DECODE 함수는 프로그래밍에서의  if else 와 비슷한 기능을 수행한다. 간단한 사용방법은 아래와 같다.
-- 인자 4개일때: DECODE(컬럼,조건,TRUE 결과값,FALSE 결과값)
-- 인자 5개 이상일때: DECODE(컬럼, 조건1, 결과1, 조건2, 결과2, 조건3, 결과3..........) 
-- https://gent.tistory.com/227
-- https://coding-factory.tistory.com/297
-- ELSE 부분은 생략이 가능하다. 해당 조건이 없으면 NULL
SELECT gender
     , DECODE(gender, 'M', '남자', 'F', '여자', '기타') gender2
  FROM temp





---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TO_CHAR : 숫자나 날짜를 문자열로 변환
-- TO_NUMBER : 문자를 숫자로 변환
-- TO_DATE : 문자를 날짜로 변환


-- 문자열 날짜를 원하는 문자열 포맷으로 변경하기
-- 날짜형의 포맷은 TO_CHAR 함수를 사용하여 쉽게 변경할 수 있다. 그러나 문자열 날짜, 
-- 예를들어 "20180823"을 "2018-08-23"으로 변경 하기 위해서는 번거로운 작업이 필요하다.
-- 아래는 2가지의 방법을 사용하여 포맷을 변경하는 예제이다. 
-- 첫번째는 문자열을 TO_DATE 함수로 날짜형으로 변경한 다음 다시 TO_CHAR 함수를 사용하여 원하는 포맷으로 변경하는 방법이다.
-- 두번째는 정규식함수 REGEXP_REPLACE를 사용하여 원하는 패턴으로 문자열의 형식을 변경하는 방법이다. 
-- 이 함수는 오라클 10g 이상의 버전에서 사용가능 하다.
SELECT TO_CHAR(TO_DATE('20180823', 'YYYYMMDD'), 'YYYY-MM-DD') AS T1 FROM DUAL; 
SELECT REGEXP_REPLACE('20180823', '(.{4})(.{2})(.{2})', '\1-\2-\3') AS T2 FROM DUAL;


-- 날짜+시간이 포함된 문자열을 Date 포맷으로 변환
예)2023/03/14 17:05:01
SELECT TO_DATE( '2023/03/14 17:05:01', 'YYYY/MM/DD HH24:MI:SS' ) FROM DUAL;

예)2023-03-14 오후 5:50:30
-- 아래처럼 AM / PM 결과는 같음
SELECT TO_DATE( '2023-03-14 오후 5:50:30', 'YYYY-MM-DD AM HH:MI:SS' ) FROM DUAL;
SELECT TO_DATE( '2023-03-14 오후 5:50:30', 'YYYY-MM-DD PM HH:MI:SS' ) FROM DUAL;



select mod(10,3) from daul;
-- MOD 나머지 구하기 함수
-- 결과: 1


-- TRUNC 함수는 주로 소수점 절사 및 날짜의 시간을 없앨 때 사용한다.
-- 10 나누기 3 = 3.3333333...  일경우 소수점 절사하여 결과는 3
-- 결국 나머지 버리고 몫만 가져오는거네
select trunc(10/3) from dual; 


------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- https://coding-factory.tistory.com/461
-- https://tragramming.tistory.com/82
-- 오라클 계층형 쿼리
START WITH.. CONNECT BY
SYS_CONNECT_BY_PATH
;

-- https://devjhs.tistory.com/171
-- CONNECT_BY_ISLEAF - 자식 노드 찾기


select * from dep;

DEP_CD PARENT_CD DEPT_NAME
101     		총괄개발부
102	    101	    모바일개발센터
103	    101	    웹개발센터
104	    101	    시스템개발센터
105	    102	    쇼핑몰(모바일)
106	    103	    외주SI
107	    103	    쇼핑몰
108	    105	    전산지원팀
109	    106	    구축1팀
100	    106	    구축2팀
111	    104	    ERP시스템
112	    106	    테스트1
;

SELECT	LPAD(' ', 4*(LEVEL-1)) || DEPT_NAME AS "부서명",
                LEVEL,
                DEP_CD,
                PARENT_CD,                
                CONNECT_BY_ISLEAF AS LEAF   -- 자식노드 존재여부(0:있음 / 1:없음)
FROM DEP 
START WITH PARENT_CD IS NULL --최상위노드 설정,
CONNECT BY PRIOR DEP_CD = PARENT_CD --부모노드와 자식노드 연결
--ORDER SIBLINGS BY  DEP_CD -- 일반적인 ORDER BY 가 아닌 계층내에서 정렬
;


https://jogakleeron.tistory.com/49
계층내에서 정렬하기 ORDER SIBLINGS BY





---------------------------------------------------------------------------------
-- https://coding-factory.tistory.com/417
--오라클 뷰(view) 생성/수정
CREATE OR REPLACE VIEW [스키마.][뷰 NAME] AS
SELECT문;
--뷰(View) 삭제
DROP VIEW [스키마.][뷰 NAME]
--뷰(View) 구조 확인
desc [스키마.][뷰 NAME];



------------------------------------------------------------------------------------------------------------------------------------------
-- https://offbyone.tistory.com/245
-- https://bebeya.tistory.com/entry/오라클-DBLINK디비링크-조회생성삭제-방법
-- https://bangu4.tistory.com/322
-- https://bebeya1.tistory.com/3
-- 동의어(시노임) 생성
-- DB링크 생성
SELECT * FROM ALL_SYNONYMS;

접근제한자(PUBLIC / PRIVATE)가 존재한다 
- PUBLIC   모든 유저가 사용가능한 공용링크를 만들때 지정한다.
- PRIVATE 특정 유저만 사용가능 한 DB링크를 만들때 지정한다. 

CREATE [PUBLIC/PRIVATE] DATABASE LINK [링크로 사용할 명칭] 
CONNECT TO [원격지 로그인 유저명] 
IDENTIFIED BY "[원격지 유저 패스워드]" 
USING [로컬서버의 tnsnames.ora에 설정된 접속할 매칭이름]


------------------------------------------------------------------------------------------------------------------------------------------
https://joont.tistory.com/153
ORA-28001, 오라클 패스워드 만료 해결


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
	날짜 및 숫자 반올림, 절사
	ROUND("값", "자리수")	-- 반올림
	TRUNC("값", "옵션")	-- 절사(버림)
	CEIL("값")			-- 소수점 첫째자리 올림, 자릿수 지정불가
	FLOOR("값")			-- 소수점 첫째자리 내림, 자릿수 지정불가
*/
SELECT CEIL(3.1) FROM DUAL;		-- 4
SELECT FLOOR(3.7) FROM DUAL;	-- 3


MOD(M,N) : M을 N으로 나누었을때 나머지 반환


CONNECT BY LEVEL	연속된 숫자 조회할때 활용



;
-- https://gent.tistory.com/405
-- # 시간 차이 계산
-- 13:00부터 15:00까지 시간 차이는 2시간으로 계산 되어서 반환된다.
-- 시간과 초가 함께 존재하면 소수점이 발생하므로 꼭 ROUND 함수로 소수점을 처리해 줘야 한다.
SELECT ROUND((TO_DATE('15:00', 'HH24:MI') - TO_DATE('13:00', 'HH24:MI')) * 24, 2) FROM dual

;

-- 예제) 
SELECT
  (EXTRACT(DAY FROM (TO_TIMESTAMP('20230630185121', 'YYYYMMDDHH24MISS') - TO_TIMESTAMP('20230630085531', 'YYYYMMDDHH24MISS'))) * 24 +
  EXTRACT(HOUR FROM (TO_TIMESTAMP('20230630185121', 'YYYYMMDDHH24MISS') - TO_TIMESTAMP('20230630085531', 'YYYYMMDDHH24MISS')))) AS hours,
  EXTRACT(MINUTE FROM (TO_TIMESTAMP('20230630185121', 'YYYYMMDDHH24MISS') - TO_TIMESTAMP('20230630085531', 'YYYYMMDDHH24MISS'))) AS minutes,
  EXTRACT(SECOND FROM (TO_TIMESTAMP('20230630185121', 'YYYYMMDDHH24MISS') - TO_TIMESTAMP('20230630085531', 'YYYYMMDDHH24MISS'))) AS seconds
FROM
  dual;



-- 테이블 삭제
DROP TABLE 테이블명;


-- 프로시저(PROCEDURE) 실행
EXEC 프로시저명;


https://coding-factory.tistory.com/453
프로시저란?
- 함수는 특정 연산을 수행한 뒤 결과 값을 반환하지만 
- 프로시저는 특정한 로직을 처리하기만 하고 결과 값은 반환하지 않는 서브 프로그램 임






/*
https://moonong.tistory.com/48
오라클 기본키(PK) 2개 이상 지정하기
	- 기본키를 구성하는 컬럼이 복수일 수는 있어도
	- 기본키가 복수일 수는 없다
*/	
CREATE TABLE TEST(
    CODE VARCHAR2(30), 
    SEQ NUMBER,    
    CONSTRAINT [기본키이름아무거나] PRIMARY KEY(CODE, SEQ)
);
-- 이 경우 두 개 컬럼이 하나의 기본키로 작동하기 때문에 컬럼1 / 2는 각각 중복될 수 있으나, 
-- 컬럼 1 & 2 의 값이 중복되는 경우에는 기본키의 UNIQUE 오류를 내게 된다. 

-- 테이블 PK 확인방법
-- https://gent.tistory.com/202
SELECT *
FROM 
      ALL_CONS_COLUMNS A
    , ALL_CONSTRAINTS  B
WHERE 1=1
    AND A.TABLE_NAME = B.TABLE_NAME
    AND A.TABLE_NAME = 'EXAMPLE5'   -- 위에서 만든 테이블명
    AND B.CONSTRAINT_TYPE = 'P' 
	AND A.OWNER = B.OWNER
	AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
;


/*
https://positivemh.tistory.com/330
오라클 Primary Keys 설정
	1. PK 생성 - CREATE TABLE 문 사용
	2. PK 생성 - ALTER TABLE 문 사용
	3. PK 삭제
	4. PK 비활성화
	5. PK 활성화
*/	
-- PK 비활성화
ALTER TABLE [대상테이블명]
DISABLE CONSTRAINT [대상 PK명];   -- [대상 PK명] == CONSTRAINT_NAME

;
https://gent.tistory.com/475
http://www.gurubee.net/article/61158
오라클 가장 늦은 날짜 결과 구하기
최대값이 여러개일 경우 가장 최신 날짜의 최대값만 추출
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
오라클 OVER() 함수
    - 분석_함수() OVER(PARTITION BY 컬럼 / ORDER BY 컬럼 / 세부 분할 기준)
    - 분석 함수와 OVER()는 필수
    - 분석 함수 종류
        COUNT(컬럼) - 갯수
        SUM(컬럼) - 합계
        AVG(컬럼) - 평균
        MAX(컬럼) - 최대값
        MIN(컬럼) - 최소값
        RANK() OVER(ORDER BY 컬럼...) - 순위
        DENSE_RANK() OVER(ORDER BY 컬럼...) - 중복 순위가 있어도 1씩 증가
        ... 더 있음




--------------------------------------------------------------------------------
https://gent.tistory.com/189
NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다.
	- 함수  :  NVL("값", "지정값") 
NVL2 함수는 NULL이 아닌 경우 지정값1을  출력하고, NULL인 경우 지정값2를 출력한다.
	- 함수 :  NVL2("값", "지정값1", "지정값2") // NVL2("값", "NOT NULL", "NULL") 
	
    
--------------------------------------------------------------------------------
https://gent.tistory.com/422
오라클 문자열 길이 구하기 (LENGTH, LENGTHB)
	SELECT LENGTH('오라클'), LENGTH('오라클 SQL')
	FROM dual




--------------------------------------------------------------------------------
https://gent.tistory.com/260
오라클 ADD_MONTHS 함수 사용법 (이전달, 다음달, 월빼기)
	ADD_MONTHS( '날짜', '숫자' )




--------------------------------------------------------------------------------
https://allmana.tistory.com/83
행 데이터 한 열로 합치기
세로 출력을 가로로 변환하기
	LISTAGG(컬럼,구분자) WITHIN GROUP(ORDER BY 합쳐진컬럼안 정렬)
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
https://meyouus.tistory.com/175
오라클 순번 채번 CONNECT BY LEVEL 활용하기  

    SELECT LEVEL AS NO FROM DUAL CONNECT BY LEVEL <=10;
    
    SELECT '2020 년 '||LPAD(LEVEL, 2, 0)||'월' AS NO FROM DUAL
    CONNECT BY LEVEL <=12;


    특정 날짜 구간 조회하기
    검색조건의 From ~ To 사이의 날짜 리스트를 구할수도 있습니다.
    ex) From : 2020년 07월 1일  / To : 2020년 07월 17일
;

SELECT TO_DATE('20200701', 'YYYYMMDD') + (LEVEL-1) AS DT
   FROM DUAL
CONNECT BY LEVEL <= (TO_DATE('20200717', 'YYYYMMDD') - TO_DATE('20200701', 'YYYYMMDD')) + 1
;


WITH WD AS
(
    SELECT TO_DATE('20200701', 'YYYYMMDD') AS FROM_DT   -- 시작일자
         , TO_DATE('20200717', 'YYYYMMDD') AS TO_DT     -- 종료일자    
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

    
    