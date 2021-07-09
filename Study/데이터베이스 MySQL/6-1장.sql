/* 06장 */

USE employees;

USE mysql;
SELECT * FROM employees;

SELECT * FROM titles ;

SELECT * FROM employees.titles;

SELECT * FROM employees.titles;
SELECT * FROM titles;

SELECT first_name FROM employees;

SELECT first_name, last_name, gender FROM employees;

-- 한줄 주석 연습
SELECT first_name, last_name, gender -- 이름과 성별 열을 가져옴
FROM employees;

/* 블록 주석 연습
SELECT first_name, last_name, gender
FROM employees;
*/



-- <실습 1> --

SHOW DATABASES;

USE employees;

SHOW TABLE STATUS;

SHOW TABLES; 

DESCRIBE employees; -- 또는 DESC employees;

SELECT first_name, gender FROM employees;

-- </실습 1> --

SELECT first_name AS 이름 , gender 성별, hire_date '회사 입사일'
FROM employees;