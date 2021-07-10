# 특정 정보 기존 데이터에 추가
INSERT INTO member_tbl VALUES('Figure', '연아', '경기도 군포시');

# 업데이트 되었는지 확인
SELECT * FROM member_TBL;

# 특정 살제한 날짜
CREATE TABLE deletedMEMBER_TBL(
	memberID char(8),
    memberName char(5),
    memberAddress char(20),
    deletedDate date -- 삭제한 날짜
);

# safe 모드 해제 후 삭제
set sql_safe_updates = 0;
DELETE FROM member_tbl WHERE memberName = '연아';

SELECT * FROM member_TBL;

DELIMITER //
CREATE TRIGGER trg_deletedMember_TBL -- 트리거 명
	AFTER DELETE -- 삭제 후에 작동하게 지정
    ON member_TBL -- 트리거 부착할 테이블
    FOR EACH ROW -- 각행마다 적용
    
BEGIN
	-- OLD 테이블의 내용을 백업 테이블에 삽입
    INSERT INTO deletedMember_TBL
		VALUES (OLD.memberID, OLD.memberName, OLD.memberAddress, CURDATE());
END //
DELIMITER ;

SELECT * FROM deletedMember_TBL;
DELETE FROM member_TBL WHERE memberName = '당탕이';

# 삭제된 데이터 확인
SELECT * FROM deletedMember_TBL;
SELECT * FROM Member_TBL;