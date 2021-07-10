DROP DATABASE IF EXISTS sqldb; -- 만약 sqldb가 존재하면 우선 삭제한다.
CREATE DATABASE sqldb;

USE sqldb;
CREATE TABLE usertbl -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
);

CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM usertbl;
SELECT * FROM buytbl;

-- 관계 연산자 활용
SELECT userID, Name FROM usertbl WHERE birthyear >= 1970 AND height >= 182;
SELECT userID, Name FROM usertbl WHERE birthyear >= 1970 OR height >= 182;
SELECT userID, Name FROM usertbl WHERE height BETWEEN 180 AND 183;

-- IN 문
SELECT name, addr FROM usertbl WHERE addr IN ('경남', '전남', '경북');

-- LIKE 문 : 특정 % 무엇이든 허용한다는 의미이다.
SELECT name, height FROM usertbl WHERE name LIKE '김%';

-- LIKE 문 : 특정 _ 한글자 무엇이든 허용한다는 의미이다.
SELECT name, height FROM usertbl WHERE name LIKE '_승기';

-- 서브쿼리 : 오류난다. 수가 많기 때문에!
SELECT name, height FROM usertbl WHERE height >= (SELECT height FROM usertbl WHERE addr = '경남');
SELECT name, height FROM usertbl WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');

-- ORDER BY : 원하는 순서대로 정렬, 기본은 오름차순, 내림차순은 뒤에 mDate DESC; 형태면 된다.
SELECT name, mDate FROM usertbl ORDER BY mDate;

SELECT name, mDate FROM usertbl ORDER BY height DESC, name ASC; -- 키가 큰 순서대로 정렬 및 키가 같을 경우 이름 순으로 정렬 ASC는 생략 가능

-- 중복되는 정보 제거 후 출력
SELECT DISTINCT addr FROM usertbl;

-- 상위 N개만 출력 : head()와 기능 같음 -> offset, 개수
USE employees;
SELECT emp_no, hire_date FROM employees
	ORDER BY hire_date ASC
    LIMIT 0, 5;
    
-- 테이블 복사문
USE sqldb;
CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * FROM buytbl2;

-- 일부 열 복사도 가능하다. 그러나 PK나 FK는 복사되지 않는다.
CREATE TABLE buytbl3 (SELECT userID, prodName FROM buytbl);
SELECT * FROM buytbl3;