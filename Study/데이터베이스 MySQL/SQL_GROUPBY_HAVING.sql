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

-- GROUP BY 절
USE sqldb;
SELECT userID, amount FROM buytbl ORDER BY userID;

-- 그룹형태로 합계를 내서 출력해라.
SELECT userID, SUM(amount) FROM buytbl GROUP BY userID;
-- 별칭을 따로 만들어주는 방법
SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수'
	FROM buytbl GROUP BY userID;
    
-- 특정 사용자의 평균
SELECT userID, AVG(amount) AS '평균 구매 개수' FROM buytbl GROUP BY userID;

-- 가장 큰 키와 작은 키를 출력하는 쿼리, 제대로 안나옴 -> 서브쿼리를 구성해야 함
SELECT name, MAX(height), MIN(height) FROM usertbl GROUP BY name;

SELECT name, height
	FROM usertbl
    WHERE height = (SELECT MAX(height)FROM usertbl)
		OR height = (SELECT MIN(height)FROM usertbl);
        
-- 특정 조건을 가진 객체 카운트
SELECT COUNT(mobile1) AS '휴대폰이 있는 사용자' FROM usertbl;

-- HAVING 절 : 집계 함수인 SUM은 WHERE와 같이 쓸 수 없다. 이를 위해 사용하는 것이 HAVING 함수이다.
SELECT userID AS '사용자', SUM(price * amount) AS '총 구매액'
	FROM buytbl
    WHERE SUM(price * amount) > 1000
    GROUP BY userID;

SELECT userID AS '사용자', SUM(price * amount) AS '총 구매액'
	FROM buytbl
    GROUP BY userID
    HAVING SUM(price*amount) > 1000;
    
-- ROLL UP : 총합 및 중간 합계 사용시
SELECT num, groupName, SUM(price * amount) AS '비용'
	FROM buytbl
    GROUP BY groupName, num
    WITH ROLLUP;