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
	danhGia tinyint CHECK(danhGia>0) NOT NULL,
	noiDungDanhGia nvarchar(300)
);
-------------------------------------------------------
CREATE PROCEDURE nhapNGuoiDung
		@tenNguoiDung nvarchar(30),@gioiTinh tinyint,@sdt nvarchar(10),@diaChi nvarchar(50),@quan nvarchar(15),@email nvarchar(50)
	AS
	BEGIN
	INSERT INTO Nguoi_Dung(tenNguoiDung,gioiTinh,sdt,diaChi,quan,email)
		VALUES(@tenNguoiDung,@gioiTinh,@sdt,@diaChi,@quan,@email)
	END
EXEC nhapNGuoiDung N'Bùi Hoàng Dũng',0,'0397767819',N'Mỹ Đình 2',N'Nam Từ Liêm','buidung8198@gmail.com';