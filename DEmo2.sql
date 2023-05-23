USE QLDA;

DECLARE @chieuDai int = 4;
DECLARE @chieuRong int = 69;
DECLARE @dienTich int = @chieuDai*@chieuRong;
DECLARE @chuVi int = (@chieuDai+@chieuRong)*2;
SELECT @dienTich,@chuVi
PRINT 'Dien Tich'+ CONVERT(varchar,@dienTich)
PRINT 'Chu Vi '+ CONVERT(varchar,@chuVi)

------------------------------
DECLARE @luong float;
SELECT @luong = Max(LUONG) FROM NHANVIEN
SELECT TENNV,LUONG FROM NHANVIEN WHERE LUONG = @luong 

---------------------------------------------

DECLARE @avgLuong float;
SELECT @avgLuong = AVG(LUONG) FROM NHANVIEN WHERE PHG = 5;
SELECT @avgLuong
SELECT HONV, TENLOT,TENNV,LUONG FROM NHANVIEN WHERE LUONG > @avgLuong


---------------------------------------------


DECLARE @luongTb TABLE(PHG int , luongTB float)
INSERT INTO @luongTb
	SELECT PHONGBAN.MAPHG , AVG(NHANVIEN.LUONG) FROM PHONGBAN JOIN NHANVIEN ON PHONGBAN.MAPHG = NHANVIEN.PHG
	GROUP BY MAPHG
SELECT COUNT(MANV) AS'SoLuongNhanVien',PHG,TENPHG
	FROM NHANVIEN JOIN PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
	GROUP BY PHG,TENPHG
	HAVING PHG IN (SELECT PHG FROM @luongTb WHERE luongTB > 30000)


----------------------------------------------------------

DECLARE @soLuong table(SoLuongDeAn int, TenPhong nvarchar(20))
INSERT INTO @soLuong
SELECT COUNT(DEAN.PHONG) ,PHONGBAN.TENPHG
	FROM DEAN JOIN PHONGBAN ON DEAN.PHONG = PHONGBAN.MAPHG
	GROUP BY PHONGBAN.TENPHG
SELECT * FROM @soLuong
SELECT * FROM DEAN