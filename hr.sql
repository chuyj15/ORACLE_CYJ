-- 커서 실행 단축키 : ctrl + enter
--문서 전체 실행: F5
SELECT 1+1
FROM dual;

--1. 계정 접속 명령어
--conn/계정명/비밀번호;
conn system/123456;

--2. SQL은 대/소문자 구분이 없다.
--명령어 키워드 대문자, 식별자는 소문자 주로 사용한다. (각자 스타일대로)
SELECT user_id, username
FROM all_users
-- WHERE username = 'HR'    : HR 계정이 있는지 확인
;

-- 사용자 계정 생성
--11g 버전 이하: 어떤 이름으로도 계정 생성 가능
--12C 버전 이상: 'c##'접두어를 붙여서 계정을 생성하도록 정책을 정함 (common의 약자)
--c##없이 계정생성하는 방법
--     ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; --명령어 먼저 실행하면 됨. 
--       이걸 안쓰면 ORA-65096: 공통 사용자 또는 롤 이름이 부적합합니다.
--       65096. 00000 -  "invalid common user or role name" 오류 발생
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER HR IDENTIFIED BY 123456;


-- 테이블 스페이스 변경
-- 해당 계정이 현재 테이블관리하는 영역안에서 어느범위까지 사용할수있는지 용량설명, 영역설정
-- ALTER USER 계정명 DEFAULT TABLESPACE users;
--HR 계정의 기본 테이블 영역을 'users'영역으로 지정
ALTER USER HR DEFAULT TABLESPACE users;

-- 계정이 사용할 수 있는 용량 설정
-- HR 계정이 사용할 수 있는 용량을 무한대로 지정
-- ALTER USER 계정명 QUOTA UNLIMITED ON users;
ALTER USER HR QUOTA UNLIMITED ON users;

-- 계정에 권한을 부여
--GRANT 권한명1, 권한명2 TO 계정명;
--HR 계정에 connect, resource 권한을 부여
GRANT connect, resource TO HR;

--기본계정생성
--HR계정을 생성하고, 기본 설정 후 권한 부여
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR DEFAULT TABLESPACE users;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT connect, resource TO HR;

-- *계정 삭제
-- DROP USER 계정명 [CASCADE];
--HR계정 삭제
DROP USER HR [CASCADE];

--*계정 잠금 해제
-- ALTER USER 계정명 ACCOUNT UNLOCK;
ALTER USER HR ACCOUNT UNLOCK;

--HR 샘플 스키마(데이터) 가져오기
--1. SQL PLUS 
--2. HR 계정을 접속
--3. 명령어 입력
--@[경로]/hr_main.sql
--  @ : 오라클이 설치된 기본 경로
-- @?/demo/schema/human_resources/\HR_main.sql
--4. 123456 [비밀번호]
--5. users [tablespace]
--6. temp [temp tablespace] --임시테이블스페이스
--7. [log 경로] - @?/demo/schema/log



--3. 
--테이블 EMPLOYEES 의 테이블 구조를 조회하는 SQL문을 작성하시오.
DESC employees;

-- 사원테이블의 사원번호와 이름을 조회
SELECT employee_id, first_name
FROM employees;

--4. 테이블 EMPLOYEES 이 <예시>와 같이 출력되도록 조회하는 SQL 문을 작성하시오.
--한글 별칭을 부여하여 조회
--*띄어쓰기가 없으면, 따옴표 생략가능
--*AS도 생략가능
--만약 employee_id AS 사원 번호 (X)
--      employee_id AS "사원 번호" (0)
--      employee_id 사원번호 (0)
--AS (alias) : 출력되는 컬럼명에 별명을 짓는 명령어
SELECT employee_id AS "사원 번호"           --띄어쓰기가 있으면 ""로 표기
        , first_name AS 이름
        , last_name AS 성
        , email AS 이메일
        , phone_number AS 전화번호
        , hire_date AS 입사일자
        , salary AS 급여
FROM employees
;

--
SELECT *            --(*) [에스터리크] : 모든 컬럼 지정
FROM employees
;

--5. 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고 조회하는 SQL 문을 작성하시오.
--DISTINCT 라는 명령어를 사용함. 
-- DISTINCT 컬럼명: 중복된 데이터를 제거하고 조회하는 키워드
SELECT DISTINCT job_id FROM employees;


--6. 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
--WHERE 조건: 조회 조건을 작성하는 구문
SELECT * FROM employees
WHERE salary >6000;

--7. 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * FROM employees
WHERE salary = 10000;       --sql에서의 비교연산은 = 하나만 사용함

--8. 테이블 EMPLOYEES 의 모든 속성들을 SALARY 를 기준으로 내림차순 정렬하고, FIRST_NAME 을 기준으로 오름차순 정렬
--   하여 조회하는 SQL 문을 작성하시오.
-- 정렬 명령어 : ORDER BY 컬럼명 [ASC/DESC];
--생략해서 쓰면 기본은 오름차순
SELECT * FROM employees ORDER BY salary DESC, first_name ASC;

--9. 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
-- 컬럼안의 값을 지정할 때는 ''을 씀. 그리고 대문자로 지정되어있음. 
-- 명령어가 대소문자 구분이 없는거지 안에 들어있는 값은 구분해야 함. 
--OR 연산 : ~또는, ~이거나
--WHERE A OR B
SELECT * FROM employees 
WHERE job_id = 'FI_ACCOUNT' OR job_id = 'IT_PROG';

--10. 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. 
--<조건> IN 키워드를 사용하여 SQL 쿼리를 완성하시오.
-- * 컬럼명 IN ('A', 'B')   : OR 연산을 대체하여 사용할 수 있는 키워드
SELECT * FROM employees 
WHERE job_id IN ('FI_ACCOUNT', 'IT_PROG') ;

--11. 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오. (HR 계정 샘플 데이터)
-- <조건> IN 키워드를 사용하여 SQL 쿼리를 완성하시오.
-- * 컬럼명 NOT IN ('A', 'B')   : OR 연산을 대체하여 사용할 수 있는 키워드
SELECT * FROM employees 
WHERE job_id NOT IN ('FI_ACCOUNT', 'IT_PROG') ;

--12. 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오
--조건연산: ~이면서, 그리고, 동시에
--WHERE A AND B;
SELECT * FROM employees WHERE job_id = 'IT_PROG' AND salary >=6000;

--13. 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘S’로 시작하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
--WHERE first_name LIKE 'S%'
-- LIKE  : 컬럼명 LIKE '와일드카드';
-- % 여러글자를 대체
-- _ 한 글자를 대체
SELECT * FROM employees WHERE first_name LIKE 'S%';

--14. 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘s’로 끝나는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * FROM employees WHERE first_name LIKE '%s';

--15. 테이블 EMPLOYEES 의 FIRST_NAME 에 소문자‘s’가 포함되는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * FROM employees WHERE first_name LIKE '%s%';

--16. 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * FROM employees WHERE first_name LIKE '_____';
--아니면 함수를 이용할 수 있음.
SELECT * FROM employees WHERE LENGTH(first_name) =5;

--17. 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- COMMISSION_PCT:성과급 비율
-- WHERE commition_pst =NULL; : 사실 =는 값을 비교하는건데, NULL은 값이 아니므로 비교 불가. 
--IS NULL이라는 키워드로 비교함. 
SELECT * FROM employees WHERE commission_pct IS NULL;

--18. 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL이 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

--19. 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * FROM employees WHERE hire_date >=  '04/01/01'; --SQL developer가 문자형 데이터를 날짜형 데이터로 자동 변환
                            --DATE타입        CHAR타입
--TO_DATE() : 문자형식을 날짜형 데이터로 변환하는 함수
SELECT * FROM employees WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD');
                            --DATE타입        DATE타입
                            
                            
--20. 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT * FROM employees WHERE hire_date >= '04/01/01' AND hire_date < '06/01/01';
SELECT * FROM employees WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD')
                            AND hire_date <= TO_DATE('20051231', 'YYYYMMDD')
;
SELECT * FROM employees WHERE hire_date BETWEEN  '04/01/01' AND '05/12/31';
SELECT * FROM employees WHERE hire_date BETWEEN TO_DATE('20040101', 'YYYYMMDD') AND TO_DATE('20051231', 'YYYYMMDD')
;

--21. 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 계산하는 SQL 문을 각각 작성하시오.
--- 결과 : 13, -12


--22. 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를 계산하는 SQL 문을 각각 작성하시오.
--- 결과 : 13, -12

--23. 각 소문제에 제시된 수와 자리 수를 이용하여 반올림하는 SQL문을 작성하시오.
-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오. → 결과 : 1
-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오. → 결과 : 0.5
-- 125.67 을 일의 자리에서 반올림하시오. → 결과 : 130
-- 125.67 을 십의 자리에서 반올림하시오. → 결과 : 120


--24. 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문을 작성하시오.
--- 3을 8로 나눈 나머지를 구하시오. → 결과 : 3
--- 30을 4로 나눈 나머지를 구하시오. → 결과 : 2



--25. 각 소문제에 제시된 두 수를 이용하여 제곱수를 구하는 SQL문을 작성하시오.
--- 2의 10제곱을 구하시오. → 결과 : 1024

--- 2의 31제곱을 구하시오. → 결과 : 2147483648


--26. 각 소문제에 제시된 수를 이용하여 제곱근을 구하는 SQL문을 작성하시오.
--- 2의 제곱근을 구하시오. → 결과 : 1.41421...
--- 100의 제곱근을 구하시오. → 결과 : 10


--27. 각 소문제에 제시된 수와 자리 수를 이용하여 해당 수를 절삭하는 SQL문을 작성하시오.
--- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
--- 527425.1234 을 소수점 아래 둘째 자리에서 절삭하시오.
--- 527425.1234 을 일의 자리에서 절삭하시오.
--- 527425.1234 을 십의 자리에서 절삭하시오.


--28. 각 소문제에 제시된 수를 이용하여 절댓값을 구하는 SQL문을 작성하시오.
--    -20 의 절댓값을 구하시오.
--    -12.456 의 절댓값을 구하시오.


--29. <예시>와 같이 문자열을 대문자, 소문자, 첫글자만 대문자로 변환하는 SQL문을 작성하시오.
--원문 대문자 소문자 첫글자만 대문자
--AlOhA WoRlD~! ALOHA WORLD~! aloha world~! Aloha World~!


--30. <예시>와 같이 문자열의 글자 수와 바이트 수를 출력하는 SQL문을 작성하시오.




--31. <예시>와 같이 각각 함수와 기호를 이용하여 두 문자열을 병합하여 출력하는 SQL문을 작성하시오.
