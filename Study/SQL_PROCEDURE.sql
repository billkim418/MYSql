SELECT * FROM member_TBL WHERE memberName = '당탕이';member_tbl

DELIMITER //
CREATE PROCEDURE myProc() # 프로시저 이름
BEGIN
	SELECT * FROM member_TBL WHERE memberName = '당탕이'; # 필요한 특정 내용을 프로그래밍, 함수와도 같은 개념
END //
DELIMITER ;

# 프로시저을 호출하는 방법
CALL myProc()