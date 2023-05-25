CREATE DATABASE Thong_Tin_Nha_Tro
ON(
NAME = ThongTinNhaTro,
FILENAME = 'D:\FPT POLYTECHNIC\Semester 3\SQL SERVER\COM2043\ASIGNMENT\ThongTinNhaTro.mdf',
SIZE = 5,
MAXSIZE = 20,
FILEGROWTH = 5
)
LOG ON(
NAME = ThongTinNhaTro_LOG,
FILENAME = 'D:\FPT POLYTECHNIC\Semester 3\SQL SERVER\COM2043\ASIGNMENT\ThongTinNhaTro.ldf',
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
	giaTien int check(giaTien>0)  NOT NULL, 
	diaChi nvarchar(50) CHECK(LEN(diaChi)>5) NOT NULL,
	moTa nvarchar(300),
	ngayDang date NOT NULL,
	nguoiLienHe int CONSTRAINT FK_maNguoiDung FOREIGN KEY(nguoiLienHe) REFERENCES Nguoi_Dung(maNguoiDung) NOT NULL,
);
GO
CREATE TABLE Danh_Gia(
	nguoiDanhGia int CONSTRAINT FK_maNguoiDanhGia FOREIGN KEY(nguoiDanhGia) REFERENCES Nguoi_Dung(maNguoiDung) NOT NULL,
	maNhaTro int CONSTRAINT FK_maNha FOREIGN KEY(maNhaTro) REFERENCES Nha_Tro(maNhaTro),
	danhGia tinyint CHECK(danhGia>0) NOT NULL,
	noiDungDanhGia nvarchar(300),
	PRIMARY KEY(nguoiDanhGia)
);
---Nhap Nguoi Dung
CREATE PROCEDURE nhapNGuoiDung
		@tenNguoiDung nvarchar(30),@gioiTinh tinyint,@sdt nvarchar(10),@diaChi nvarchar(50),@quan nvarchar(15),@email nvarchar(50)
	AS
	BEGIN
	INSERT INTO Nguoi_Dung(tenNguoiDung,gioiTinh,sdt,diaChi,quan,email)
		VALUES(@tenNguoiDung,@gioiTinh,@sdt,@diaChi,@quan,@email)
	END
---Nhap loai nha
CREATE PROCEDURE nhapLoaiNha
		@tenLoai nvarchar(20)
	AS
	BEGIN
		INSERT INTO LOAI_NHA(tenLoai)
		VALUES(@tenLoai)
	END
--Nhap Danh gia
CREATE PROCEDURE nhapDanhGia
		@nguoiDanhGia int,@danhGia tinyint,@noiDungDanhGia nvarchar(300)
	AS
	BEGIN
	INSERT INTO Danh_Gia
		VALUES(@nguoiDanhGia,@danhGia,@noiDungDanhGia)
	END
--Thuc thi STRORE PROCEDURE
EXEC nhapNGuoiDung N'Bùi Hoàng Dũng',0,'0397767819',N'Mỹ Đình 2',N'Nam Từ Liêm','buidung8198@gmail.com';
EXEC nhapNGuoiDung N'Bùi Hoàng Dương',0,'0397767818',N'Mỹ Đình 1',N'Nam Từ Liêm','buiduong8198@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Minh Đức',0,'0597767819',N'Sứ giả',N'Hoàng Mai','duc8198@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Đức Chung',0,'0397757819',N'Yển Khê',N'Thanh Ba','NguyenducChung@gmail.com';
EXEC nhapNGuoiDung N'Trịnh Văn Quyết ',0,'0397757811',N'Vĩnh Thịnh',N'Vĩnh Tường','XuanQuyet@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Tấn Dũng',0,'0397747811',N'Cà Mau',N'Cà Mau','XuanQuyet@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Thanh Long',0,'0397744811',N'Giao Thủy',N'Nam Định','Long@gmail.com';
EXEC nhapNGuoiDung N'Chu Ngọc Anh',0,'0397742811',N'Lang Sơn',N'Hạ Hòa','nAnh@gmail.com';
EXEC nhapNGuoiDung N'Trần Đại Quang',0,'0297744811',N'Thụy Khuê',N'Tây Hồ','Long@gmail.com';
EXEC nhapNGuoiDung N'Nguyễn Xuân Phúc',0,'0396744811',N'Quế Phú',N'Quế Sơn','Long@gmail.com';
EXEC nhapNGuoiDung N'Cù Thị Hậu',1,'0396344811',N'Hạ Hòa',N'Phú Thọ','Hau@gmail.com';
EXEC nhapLoaiNha 'Villa';
EXEC nhapLoaiNha N'Chung cư';
EXEC nhapLoaiNha N'Biệt Thự';
EXEC nhapLoaiNha N'Nhà Cấp 4';
EXEC nhapDanhGia 4,0,;