USE QLDA
SELECT * FROM NHANVIEN
GO
ALTER FUNCTION fGetEmployeeDetail(@manv varchar(10)) 
RETURNS @employee TABLE 
		(
		tenNv nvarchar(7),diaChi nvarchar(70)
		)
AS
BEGIN
	if(@manv is null)
	INSERT INTO @employee
		SELECT TENNV,DCHI FROM NHANVIEN
	else
		INSERT INTO @employee
		SELECT TENNV,DCHI FROM NHANVIEN WHERE MANV = @manv
RETURN
END
GO
SELECT *  FROM fGetEmployeeDetail(null)