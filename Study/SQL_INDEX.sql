# index 만드는 구문
CREATE TABLE indexTBL
 (first_name varchar(14), last_name varchar(16), hire_date date);
 INSERT INTO indexTBL # employees문에서 데이터 삽입
	SELECT first_name, last_name, hire_date
    FROM employees.employees
    LIMIT 500;

# index 연습을 하기 위한 정보 확인
SELECT * FROM indexTBL;

# 기존 일반 검색 : 책 한권을 처음부터 검색하는 것이다.
SELECT * FROM indexTBL WHERE first_name = 'Mary';

# 인덱스 검색
CREATE INDEX idx_indexTBL_firstname ON indexTBL(first_name);