CREATE DATABASE Thong_Tin_Nha_Tro;
GO
USE Thong_Tin_Nha_Tro;
GO
CREATE TABLE Nguoi_Dung(
	maNguoiDung int IDENTITY(1,1) PRIMARY KEY,
	tenNguoiDung nvarchar(30) NOT NULL,
	gioiTinh tinyint NOT NULL,
	sdt nvarchar(10) NOT NULL,
	diaChi nvarchar(50) CHECK(LEN(diaChi)>5) NOT NULL,
	quan nvarchar(15) CHECK(LEN(quan)>3) NOT NULL,
	email nvarchar(50) NOT NULL,
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
GO
-------------------------------------------------------
ALTER TABLE Nguoi_Dung
 ALTER COLUMN sdt nvarchar(10) NOT NULL UNIQUE,
