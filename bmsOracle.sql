/*
Oracle Dual 테이블이란?
 - 오라클 자체에서 제공되는 테이블
 - 간단하게 함수를 이용해서 계산 결과값을 확인 할 때 사용하는 테이블
*/

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



-- LIKE 조건식은 문자열의 패턴을 검색할 때 사용하는 조건식이다. 
SELECT emp_name FROM employees
WHERE 1=1
AND emp_name LIKE 'A%'   -- A로 시작하는 문자열
AND emp_name LIKE '%A'   -- A로 끝나는 문자열
AND emp_name LIKE '%A_'  -- 임의 문자열후 A뒤에 한글자 더오고 끝나 문자열
ORDER BY emp_name;


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

-- 조인 (JOIN), 아우터 조인(Outer Join)
-- https://goddaehee.tistory.com/62 <---- 여기 설명먼저 보자!!!!!
-- 두 테이블의 쿼리 결과를 가로로 붙여서 보여주기
-- where 조건절에 두 테이블의 컬럼중 일치하는 정보를 기입해줘야함
SELECT table.column, table.column
FROM table1, table2
WHERE table1.column1 = table2.column2;



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




https://offbyone.tistory.com/253
오라클 MERGE INTO 문으로 있으면 UPDATE 없으면 INSERT 한번에 수행하기




----------------------------------------------------------------
create sequence seq_board;    -- 시퀀스 생성

create table tbl_board (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate
);

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


-- 컬럼에서 지정한 문자를 왼쪽에서 제거한 결과
SELECT LTRIM(' 테스트입니다') AS LTRIM_ONE 
      ,LTRIM('테스트입니다','테스트') AS LTRIM_TWO
      ,LTRIM('테스트입니다','스트') AS LTRIM_THREE 
      FROM DUAL;

-- 컬럼에서 지정한 문자를 오른쪽에서 제거한 결과
SELECT RTRIM('테스트입니다 ') AS RTRIM_ONE 
      ,RTRIM('테스트입니다','니다') AS RTRIM_TWO
      ,RTRIM('테스트입니다','입니') AS RTRIM_THREE 
      FROM DUAL;

-- 컬럼에서 지정한 문자를 양쪽에서 제거한 결과
-- LEADING : 왼쪽에서 제거  |  TRAILING : 오른쪽에서 제거  |  BOTH : 양쪽에서 제거
-- 특별히 설정해주는 값이 없으면 기본값은 BOTH
-- 제거할 문자는 오직 한개(ltrim, rtrim은 여러개 가능)
SELECT TRIM(' 테스트입니다 ') AS TRIM_ONE 
        ,TRIM('다' FROM '다는 테스트입니다') AS TRIM_TWO
        ,TRIM(BOTH '다' FROM '다는 테스트입니다') AS TRIM_THREE 
        ,TRIM(LEADING '다' FROM '다는 테스트입니다') AS TRIM_FOUR
        ,TRIM(TRAILING '다' FROM '다는 테스트입니다') AS TRIM_FIVE
        FROM DUAL;

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

-- TO_CHAR() 함수는 날짜, 숫자 등의 값을 문자열로 변환하는 함수
-- (참고)https://gent.tistory.com/331
-- 날짜 포맷 변경 (YYYY-MM-DD)
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')              --20200723
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD')            --2020/07/23
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD')            --2020-07-23
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') --2020-07-23 11:10:52
FROM dual;



-- https://dev4u.tistory.com/100
-- 오라클 1000단위 숫자값에 3자리 마다 콤마(,) 찍기
SELECT TO_CHAR( num_col , '999,999,999,999,999') FROM DUAL;


-- https://gent.tistory.com/69
-- 오라클(Oracle) 날짜 요일(Week) 구하는 방법
TO_CHAR ( "날짜", "포맷" )


-- DECODE 함수는 프로그래밍에서의  if else 와 비슷한 기능을 수행한다. 간단한 사용방법은 아래와 같다.
-- 인자 4개일때: DECODE(컬럼,조건,TRUE 결과값,FALSE 결과값)
-- 인자 5개 이상일때: DECODE(컬럼, 조건1, 결과1, 조건2, 결과2, 조건3, 결과3..........) 
-- https://gent.tistory.com/227
-- https://coding-factory.tistory.com/297
-- ELSE 부분은 생략이 가능하다. 해당 조건이 없으면 NULL
SELECT gender
     , DECODE(gender, 'M', '남자', 'F', '여자', '기타') gender2
  FROM temp


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


select mod(10,3) from daul;
-- MOD 나머지 구하기 함수
-- 결과: 1


-- TRUNC 함수는 주로 소수점 절사 및 날짜의 시간을 없앨 때 사용한다.
-- 10 나누기 3 = 3.3333333...  일경우 소수점 절사하여 결과는 3
-- 결국 나머지 버리고 몫만 가져오는거네
select trunc(10/3) from dual; 


--오라클 계층형 쿼리
START WITH.. CONNECT BY
SYS_CONNECT_BY_PATH


-- https://coding-factory.tistory.com/417
--오라클 뷰(view) 생성/수정
CREATE OR REPLACE VIEW [스키마.][뷰 NAME] AS
SELECT문;
--뷰(View) 삭제
DROP VIEW [스키마.][뷰 NAME]
--뷰(View) 구조 확인
desc [스키마.][뷰 NAME];




-- https://offbyone.tistory.com/245
-- https://bebeya.tistory.com/entry/오라클-DBLINK디비링크-조회생성삭제-방법
-- 동의어(시노임) 생성
-- DB링크 생성
SELECT * FROM ALL_SYNONYMS;






https://joont.tistory.com/153
ORA-28001, 오라클 패스워드 만료 해결



https://gent.tistory.com/241
https://gent.tistory.com/192
날짜 및 숫자 반올림, 절사(버림)
ROUND("값", "자리수")
TRUNC("값", "옵션")


MOD(M,N) : M을 N으로 나누었을때 나머지 반환


CONNECT BY LEVEL	연속된 숫자 조회할때 활용




-- https://gent.tistory.com/405
-- # 시간 차이 계산
-- 13:00부터 15:00까지 시간 차이는 2시간으로 계산 되어서 반환된다.
-- 시간과 초가 함께 존재하면 소수점이 발생하므로 꼭 ROUND 함수로 소수점을 처리해 줘야 한다.
SELECT ROUND((TO_DATE('15:00', 'HH24:MI') - TO_DATE('13:00', 'HH24:MI')) * 24, 2) FROM dual


-- 테이블 삭제
DROP TABLE 테이블명;


-- 프로시저(PROCEDURE) 실행
EXEC 프로시저명;

















