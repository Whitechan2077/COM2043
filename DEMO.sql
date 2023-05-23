USE demo;


SELECT MAX(Luong) FROM NHANVIEN;
BEGIN
DECLARE @maxLuong int;
SELECT @maxLuong = Luong FROM NHANVIEN WHERE Luong = 100
SELECT @maxLuong
PRINT 'max Luong'+CONVERT(nvarchar(12),@maxLuong)


SELECT * FROM NHANVIEN
DECLARE @nhanVien Table(
		FullName nvarchar(50),
		Ad nvarchar(5));
INSERT INTO @nhanVien
	SELECT maNV,DiaChi FROM NHANVIEN WHERE DiaChi like 'HN'
SELECT * FROM @nhanVien;
END;
BEGIN
DECLARE @a int , @b int , @c int
SET @a= 1;
SET @b = 2;
SET @c = @a +@b;

END;