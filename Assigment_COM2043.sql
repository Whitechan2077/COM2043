CREATE DATABASE Thong_Tin_Nha_Tro
ON(
NAME = ThongTinNhaTro,
FILENAME = 'D:\FPTPOLYTECHNIC\Semester3\SQL SERVER\COM2043\ASIGNMENT\ThongTinNhaTro.mdf',
SIZE = 5,
MAXSIZE = 20,
FILEGROWTH = 5
)
LOG ON(
NAME = ThongTinNhaTro_LOG,
FILENAME = 'D:\FPTPOLYTECHNIC\Semester3\SQL SERVER\COM2043\ASIGNMENT\ThongTinNhaTro.ldf',
SIZE = 5,
MAXSIZE = 20,
FILEGROWTH = 5
);
GO
USE Thong_Tin_Nha_Tro;
GO
CREATE TABLE Nguoi_Dung(
	maNguoiDung int IDENTITY(1,1) PRIMARY KEY,
	tenNguoiDung nvarchar(30) NOT NULL,
	gioiTinh tinyint NOT NULL,
	sdt nvarchar(10) NOT NULL UNIQUE,
	diaChi nvarchar(50) CHECK(LEN(diaChi)>1) NOT NULL,
	quan nvarchar(15) CHECK(LEN(quan)>1) NOT NULL,
	email nvarchar(50) NOT NULL
)
GO
CREATE TABLE LOAI_NHA(
	maLoai int PRIMARY KEY IDENTITY(1,1),
	tenLoai nvarchar(20)
);
GO
CREATE TABLE Nha_Tro(
	maNhaTro int IDENTITY(1,1) PRIMARY KEY,
	tenNhaTro nvarchar(50) NOT NULL,
	maLoai int CONSTRAINT FK_maLoai FOREIGN KEY (maLoai) REFERENCES LOAI_NHA(maLoai) NOT NULL,
	dientich float CHECK (dientich>0) NOT NULL,
	giaTien float check(giaTien>0)  NOT NULL, 
	diaChi nvarchar(50) CHECK(LEN(diaChi)>5) NOT NULL,
	quan nvarchar(50) CHECK(LEN(quan)>2) NOT NULL,
	moTa nvarchar(300),
	ngayDang date NOT NULL,
	nguoiLienHe int CONSTRAINT FK_maNguoiDung FOREIGN KEY(nguoiLienHe) REFERENCES Nguoi_Dung(maNguoiDung) NOT NULL,
);
GO

CREATE TABLE Danh_Gia (
	maDanhGia int IDENTITY(1,1) PRIMARY KEY,
	nguoiDanhGia INT CONSTRAINT FK_maNguoiDanhGia FOREIGN KEY (nguoiDanhGia) REFERENCES  Nguoi_Dung(maNguoiDung) NOT NULL,
	maNhaTro INT CONSTRAINT FK_maNha FOREIGN KEY (maNhaTro) REFERENCES Nha_Tro(maNhaTro),
	danhGia TINYINT CHECK (danhGia BETWEEN 1 AND 5) NOT NULL,
	noiDungDanhGia NVARCHAR(300),
);

GO
---Nhap Nguoi Dung
CREATE PROCEDURE nhapNGuoiDung
		@tenNguoiDung nvarchar(30),@gioiTinh tinyint,@sdt nvarchar(10),@diaChi nvarchar(50),@quan nvarchar(15),@email nvarchar(50)
	AS
	BEGIN
		IF(@gioiTinh is NULL) OR (@tenNguoiDung IS NULL) OR (@sdt IS NULL) OR (@diaChi IS NULL) OR(@quan IS NULL) OR (@email IS NULL)
		BEGIN
			PRINT'Loi thieu thong tin'
		END
		ELSE 
			BEGIN
				INSERT INTO Nguoi_Dung(tenNguoiDung,gioiTinh,sdt,diaChi,quan,email)
				VALUES(@tenNguoiDung,@gioiTinh,@sdt,@diaChi,@quan,@email)
			END
	END
GO
---Nhap loai nha
CREATE PROCEDURE nhapLoaiNha
		@tenLoai nvarchar(20)
	AS
	BEGIN
	IF(@tenLoai IS NULL) PRINT 'Khong duoc de trong ten loai'
	ELSE 
		BEGIN
			INSERT INTO LOAI_NHA(tenLoai)
			VALUES(@tenLoai)
		END
	END
GO
--Nhap Loai Nha
CREATE PROCEDURE nhapNhaTro 
	@tenNhaTro nvarchar(70),@maLoai int,@dientich float,
	@giaTien float,@diaChi nvarchar(50),@quan nvarchar(50)
	,@moTa nvarchar(300),@ngayDang date ,@nguoiLienHe int
AS
	BEGIN
	IF (@tenNhaTro IS NULL) OR (@maLoai IS NULL) OR(@diaChi IS NULL) OR (@dientich IS NULL)
		OR(@giaTien IS NULL) OR(@quan IS NULL) OR(@moTa IS NULL) OR(@ngayDang IS NULL) OR (@nguoiLienHe IS NULL)
		PRINT 'Thieu Du lieu'
	ELSE 
		BEGIN
			INSERT INTO Nha_Tro(tenNhaTro,maLoai,giaTien,dientich,diaChi,quan,moTa,ngayDang,nguoiLienHe)
				VALUES(@tenNhaTro,@maLoai,@giaTien,@dientich,@diaChi,@quan,@moTa,@ngayDang,@nguoiLienHe)
		END
	END
GO
--Nhap Danh gia
CREATE PROCEDURE nhapDanhGia
		@nguoiDanhGia int,@danhGia tinyint,@noiDungDanhGia nvarchar(300),@maNhaTro INT
	AS
	BEGIN
	 IF(@nguoiDanhGia IS NULL) OR (@danhGia IS NULL) OR (@noiDungDanhGia IS NULL) OR (@maNhaTro IS NULL) PRINT 'Thieu du lieu'
		ELSE
			BEGIN
				INSERT INTO Danh_Gia(nguoiDanhGia,maNhaTro,danhGia,noiDungDanhGia)
				VALUES(@nguoiDanhGia,@maNhaTro,@danhGia,@noiDungDanhGia)
		END
	END


--Tim kiem theo quan
GO
CREATE PROCEDURE timKiemTheoQuan
	@quan nvarchar(20)
AS
BEGIN
	SELECT N'Cho thuê nhà trọ tại' + ' ' + Nha_Tro.diaChi + ' ' + Nha_Tro.quan AS N'Cho thuê phòng',
		CONVERT(varchar,Nha_Tro.dientich) + 'm2' AS 'Diện tích',
		FORMAT(Nha_Tro.giaTien, '#,##0') AS N'Giá Tiền',
		Nha_Tro.moTa AS 'Mô tả',
		CONVERT(varchar, Nha_Tro.ngayDang, 105) AS N'Ngày Đăng',
		CASE
			WHEN Nguoi_Dung.gioiTinh = 0 THEN 'A ' + Nguoi_Dung.tenNguoiDung
			ELSE 'C ' + Nguoi_Dung.tenNguoiDung
		END AS N'Người Giới Thiệu',Nguoi_Dung.sdt,Nguoi_Dung.diaChi
	FROM Nha_Tro
	JOIN Nguoi_Dung ON Nha_Tro.nguoiLienHe = Nguoi_Dung.maNguoiDung
	WHERE Nha_Tro.quan = @quan;
END
GO
--Tim kiem theo Khoang tien
CREATE PROCEDURE timKiemTheoKhoangTien
	@gia1 float , @gia2 float
AS
BEGIN
	SELECT N'Cho thuê nhà trọ tại' + ' ' + Nha_Tro.diaChi + ' ' + Nha_Tro.quan AS N'Cho thuê phòng',
		CONVERT(varchar,Nha_Tro.dientich) + 'm2' AS 'Diện tích',
		FORMAT(Nha_Tro.giaTien, '#,##0') AS N'Giá Tiền',
		Nha_Tro.moTa AS 'Mô tả',
		CONVERT(varchar, Nha_Tro.ngayDang, 105) AS N'Ngày Đăng',
		CASE
			WHEN Nguoi_Dung.gioiTinh = 0 THEN 'A ' + Nguoi_Dung.tenNguoiDung
			ELSE 'C ' + Nguoi_Dung.tenNguoiDung
		END AS N'Người Giới Thiệu',Nguoi_Dung.sdt,Nguoi_Dung.diaChi
	FROM Nha_Tro
	JOIN Nguoi_Dung ON Nha_Tro.nguoiLienHe = Nguoi_Dung.maNguoiDung
	WHERE Nha_Tro.giaTien BETWEEN @gia1 AND @gia2
END
GO
--Tim kiem theo khoang Dien tich
CREATE PROCEDURE timKiemTheoKhoangDienTich
	@dienTich1 float, @dienTich2 float
AS
BEGIN
	SELECT N'Cho thuê nhà trọ tại' + ' ' + Nha_Tro.diaChi + ' ' + Nha_Tro.quan AS N'Cho thuê phòng',
		CONVERT(varchar,Nha_Tro.dientich) + 'm2' AS 'Diện tích',
		FORMAT(Nha_Tro.giaTien, '#,##0') AS N'Giá Tiền',
		Nha_Tro.moTa AS 'Mô tả',
		CONVERT(varchar, Nha_Tro.ngayDang, 105) AS N'Ngày Đăng',
		CASE
			WHEN Nguoi_Dung.gioiTinh = 0 THEN 'A ' + Nguoi_Dung.tenNguoiDung
			ELSE 'C ' + Nguoi_Dung.tenNguoiDung
		END AS N'Người Giới Thiệu',Nguoi_Dung.sdt,Nguoi_Dung.diaChi
	FROM Nha_Tro
	JOIN Nguoi_Dung ON Nha_Tro.nguoiLienHe = Nguoi_Dung.maNguoiDung
	WHERE Nha_Tro.giaTien BETWEEN @dienTich1 AND @dienTich2
END
GO
--tim kiem theo loai nha tro
CREATE PROCEDURE timKiemTheoLoaiNhaTro
	@maLoai int
AS
BEGIN
	SELECT N'Cho thuê nhà trọ tại' + ' ' + Nha_Tro.diaChi + ' ' + Nha_Tro.quan AS N'Cho thuê phòng',
		CONVERT(varchar,Nha_Tro.dientich) + 'm2' AS 'Diện tích',
		FORMAT(Nha_Tro.giaTien, '#,##0') AS N'Giá Tiền',
		Nha_Tro.moTa AS 'Mô tả',
		CONVERT(varchar, Nha_Tro.ngayDang, 105) AS N'Ngày Đăng',
		CASE
			WHEN Nguoi_Dung.gioiTinh = 0 THEN 'A ' + Nguoi_Dung.tenNguoiDung
			ELSE 'C ' + Nguoi_Dung.tenNguoiDung
		END AS N'Người Giới Thiệu',Nguoi_Dung.sdt,Nguoi_Dung.diaChi
	FROM LOAI_NHA JOIN Nha_Tro ON LOAI_NHA.maLoai = Nha_Tro.maLoai
	JOIN Nguoi_Dung ON Nha_Tro.nguoiLienHe = Nguoi_Dung.maNguoiDung 
	WHERE Nha_Tro.maLoai = @maLoai
END
GO
--tim kiem theo khoang nam
CREATE PROCEDURE timKiemTheoLoaiKhoangNam
	@nam1 int,@nam2 int
AS
BEGIN
	SELECT N'Cho thuê nhà trọ tại' + ' ' + Nha_Tro.diaChi + ' ' + Nha_Tro.quan AS N'Cho thuê phòng',
		 CONVERT(varchar,Nha_Tro.dientich)+ 'm2' AS 'Diện tích',
		FORMAT(Nha_Tro.giaTien, '#,##0') AS N'Giá Tiền',
		Nha_Tro.moTa AS 'Mô tả',
		CONVERT(varchar, Nha_Tro.ngayDang, 105) AS N'Ngày Đăng',
		CASE
			WHEN Nguoi_Dung.gioiTinh = 0 THEN 'A ' + Nguoi_Dung.tenNguoiDung
			ELSE 'C ' + Nguoi_Dung.tenNguoiDung
		END AS N'Người Giới Thiệu',Nguoi_Dung.sdt,Nguoi_Dung.diaChi
	FROM LOAI_NHA JOIN Nha_Tro ON LOAI_NHA.maLoai = Nha_Tro.maLoai
	JOIN Nguoi_Dung ON Nha_Tro.nguoiLienHe = Nguoi_Dung.maNguoiDung 
	WHERE YEAR(Nha_Tro.ngayDang) BETWEEN @nam1 AND @nam2
END
GO
--Ham tra ve ma nguoi dung
CREATE PROCEDURE timMaNguoiDung 
	@tenNguoiDung nvarchar(30),@gioiTinh tinyint,@sdt nvarchar(10),@quan nvarchar(15),@diaChi nvarchar(50),@email nvarchar(50)
	AS
	    DECLARE @maNguoiDung int
		SELECT @maNguoiDung=maNguoiDung  FROM Nguoi_Dung WHERE tenNguoiDung like @tenNguoiDung AND gioiTinh = @gioiTinh AND sdt like @sdt AND diaChi like @diaChi AND quan like @quan AND email like @email
	RETURN @maNguoiDung
GO
--Dem so like cua nha Tro
CREATE PROCEDURE demSoLike
	@maNhaTro int
	AS
		BEGIN
			SELECT COUNT(Danh_Gia.danhGia),Nha_Tro.tenNhaTro FROM Nha_Tro JOIN Danh_Gia ON Nha_Tro.maNhaTro = Danh_Gia.maNhaTro
			GROUP BY Nha_Tro.tenNhaTro
			HAVING Danh_Gia.danhGia = 0
		END
GO
--Tra ve danh gia cua nha tro
CREATE PROCEDURE hienThiDanhGia
	@maNhaTro int
	AS
		BEGIN
			SELECT Nha_Tro.maNhaTro,Nguoi_Dung.tenNguoiDung,Danh_Gia.danhGia,Danh_Gia.noiDungDanhGia
				FROM Nguoi_Dung 
				JOIN Danh_Gia ON Nguoi_Dung.maNguoiDung = Danh_Gia.nguoiDanhGia 
				JOIN Nha_Tro ON Nha_Tro.maNhaTro = Danh_Gia.maNhaTro
		END
GO
--Xoa nha theo so dislike
CREATE PROCEDURE xoaTheoSoDisLike
	@soDislike int
	AS
	BEGIN

	END
GO
--Thuc thi STRORE PROCEDURE
EXEC nhapNGuoiDung N'Bùi Hoàng Dũng',0,'0397767819',N'Mỹ Đình 2',N'Nam Từ Liêm','buidung8198@gmail.com';
EXEC nhapNGuoiDung N'Bùi Hoàng Dương',0,'0397767818',N'Mỹ Đình 1',N'Nam Từ Liêm','buiduong8198@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Minh Đức',0,'0597767819',N'Sứ giả',N'Hoàng Mai','duc8198@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Đức Chung',0,'0397757819',N'Yển Khê',N'Thanh Ba','NguyenducChung@gmail.com';
EXEC nhapNGuoiDung N'Trịnh Văn Quyết ',0,'0397757811',N'Vĩnh Thịnh',N'Vĩnh Tường','XuanQuyet@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Tấn Dũng',0,'0397747811',N'Cà Mau',N'Cà Mau','XuanQuyet@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Thanh Long',0,'0397744811',N'Giao Thủy',N'Nam Định','Long@gmail.com';
EXEC nhapNGuoiDung N'Chu Ngọc Anh',0,'0397742811',N'Lang Sơn',N'Hạ Hòa','nAnh@gmail.com';
EXEC nhapNGuoiDung N'Trần Đại Quang',0,'0297744811',N'Thụy Khuê',N'Tây Hồ','quang@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Xuân Phúc',0,'0396744811',N'Quế Phú',N'Quế Sơn','phuc@gmail.com';
EXEC nhapNGuoiDung N'Cù Thị Hậu',1,'0396344811',N'Hạ Hòa',N'Phú Thọ','Hau@gmail.com';
EXEC nhapNGuoiDung 'Tao la Bo',NULL,NULL,NULL,NULL,'abc@gmail.com';

SELECT * FROM Nguoi_Dung

EXEC nhapLoaiNha 'Villa';
EXEC nhapLoaiNha N'Chung cư';
EXEC nhapLoaiNha N'Biệt Thự';
EXEC nhapLoaiNha N'Nhà Cấp 4';
EXEC nhapLoaiNha NULL;

SELECT * FROM Nha_Tro
EXEC nhapNhaTro N'Chung cư siêu cấp',2,10000,9000,N'98 Nguyễn Khánh Toàn',N'Cầu Giấy',N'Nhà siêu xịn','2022-12-12',1
EXEC nhapNhaTro N'Nhà cấp 4 ven hồ',4,10000,9000,N'Hồ Tây',N'Tây Hồ',N'Nhà siêu Sạch','2022-3-12',3
EXEC nhapNhaTro N'Biệt thự sang sang chảnh',3,300000,9000,N'Hồ Tây',N'Tây Hồ',N'Nhà siêu Sạch ĐẸP','2022-3-12',3
EXEC nhapNhaTro N'Villa Chân Cầu Long Biên',3,400000,1000,N'Cầu Long Biên',N'Long Biên',N'Siêu bát hương','2012-3-12',9
EXEC nhapNhaTro N'Villa Song Sắt',3,400000,1000,N'Hỏa Lò',N'Hỏa Lò',N'Du ven tút','2012-3-12',4
EXEC nhapNhaTro N'Nhà Đá',2,600000,8000,N'Hỏa Lò',N'Hỏa Lò',N'Du ven tút','2012-3-12',4
EXEC nhapNhaTro N'Mon city',2,600000,8000,N'Mỹ Đình',N'Nam Từ Liêm',N'Sạch','2012-3-12',1
EXEC nhapNhaTro N'Nhà Đá',2,NULL,8000,N'Hỏa Lò',N'Hỏa Lò',N'Du ven tút','2012-3-12',4
EXEC nhapNhaTro N'Villa Sau Song Sắt Siêu VIP',1,40000,8000,N'Hỏa Lò',N'Hỏa Lò',N'Du ven tút','2022-6-12',8

SELECT * FROM Danh_Gia
EXEC nhapDanhGia 4,1,N'Nhà siêu đẹp tiếc không có 1 cuốn lịch',9
EXEC nhapDanhGia 4,1,N'Nhà siêu đẹp tiếc không có tường đá để đếm',8


EXEC timKiemTheoLoaiNhaTro 1
EXEC timKiemTheoKhoangDienTich 1000,3000
EXEC timKiemTheoKhoangTien 100,8000
EXEC timKiemTheoLoaiKhoangNam 2012,2022
EXEC timKiemTheoQuan N'Hỏa Lò'
DECLARE @ma int;
EXEC @ma = timMaNguoiDung N'Bùi Hoàng Dương',0,'0397767818',N'Nam Từ Liêm',N'Mỹ Đình 1','buiduong8198@gmail.com'
SELECT @ma