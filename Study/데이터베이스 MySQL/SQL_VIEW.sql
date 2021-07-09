CREATE VIEW uv_memberTBL
AS
	SELECT memberName, memberAddress FROM member_tbl ;

# 실제 볼 수 있는 뷰에만 접근
SELECT * FROM uv_membertbl