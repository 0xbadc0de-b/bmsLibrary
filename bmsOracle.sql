/*
Oracle Dual 테이블이란?
 - 오라클 자체에서 제공되는 테이블
 - 간단하게 함수를 이용해서 계산 결과값을 확인 할 때 사용하는 테이블
*/


-- 온라인 오라클 테스트 사이트
-- https://sqltest.net/


-- 오라클 내장함수

select chr(65) from dual;	-- 아스키코드를 문자(A)로 출력

select ascii('A') from dual;	-- 문자를 hex값(65)으로 출력

select concat('Republic of ', 'KOREA') from dual;	-- 문자열 붙이기

select initcap('MR. TEsT') from dual;	-- 각 단어 앞글자 대문자, 나머지 소문자

select lower('Mr. TesT') from dual;	-- 모든 문자 소문자 변환
select upper('Mr. TesT') from dual;	-- 모든 문자 대문자 변환

select lpad('TEST', 8, '*') from dual;	-- (왼쪽 채움)전체 길이가 8이 되도록 왼쪽에 * 채움
select lpad(컬럼명, 8, '*') from 테이블명;

select rpad('TEST', 8, '*') from dual;	-- (오른쪽 채움)전체 길이가 8이 되도록 오른쪽에 * 채움


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



# select 자료조회

select * from emp;
select emp.* from emp;
select empno, job from emp;
select emp.empno, emp.job from emp;

desc jobs;		-- jobs 테이블의 칼럼 이름만 나열
describe jobs;

-- 임의의 칼럼 만들기, 결과에 '직업코드: 1' 내용이 자동 채워져서 보여짐
select '직업코드: ', 1, job_id, job_title, min_salary from jobs;

-- 칼럼 이름바꾸기(alias), 별명 사용
select job_id as 직업ID, job_title as 직업명, min_salary as 최소임금 from jobs;
select job_id as "직업 ID", job_title as "직업 명", min_salary as "최소 임금" from jobs;

select job_id, job_title, min_salary * 12 as 최소연봉 from jobs;		-- 산술연산자 사용 가능


select '직업코드: ' || job_id, job_title, min_salary from jobs;
-- 아래 결과처럼 문자를 연결함
-- 직업코드: job-id1, job_title1, min_salary2
-- 직업코드: job-id2, job_title2, min_salary2
-- ...(계속)


select employee_id, salary from employees 
where salary >= 9000;	-- 급여가 9000 이상이 결과만 추출

select employee_id, salary, manager_id from employees 
where manager_id is null;	-- 메니저ID가 없는(NULL) 레코드만 추출


-- 사용자 계정(book_ex) 생성, identified by 뒤에가 패스워드(book_ex)
-- 기본테이블 스페이스 USERS, 임시테이블 스페이즈 TEMP
create user book_ex identified by book_ex
default tablespace USERS
temporary tablespace TEMP;


-- 접속권한 및 DBA 권한 부여
grant connect, dba to book_ex;




-- 웹 응용프로그램과 포트 번호가 곁치지 않기 위해 
-- 오라클 웹접속 8080 포트 변경을 위해 SYS 계정에 SYSBDA 권한으로 접속후
select dbms_xdb.gethttpport() from dual;
-- 위 쿼리 실행시 결과가 8080 포트이면 아래 쿼리를 실행하여 9090 포트로 변경
exec dbms_xdb.sethttpport(9090);





