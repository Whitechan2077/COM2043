CREATE DATABASE SinhVien;
GO
USE SinhVien;
GO

CREATE TABLE ChuyenNganh(
	MaNganh nvarchar(2) PRIMARY KEY,
	tenNganh nvarchar(50),
);
GO

CREATE TABLE MonHoc(
  MaNganh nvarchar(2) CONSTRAINT FK_MaNganh FOREIGN KEY (MaNganh) REFERENCES ChuyenNganh(MaNganh),
  MaMonHoc int CHECK(LEN(MaMonHoc)<=6) PRIMARY KEY,
);
GO

CREATE TABLE LopHoc(
	MaNganh nvarchar(2) CONSTRAINT FK_MaNganh FOREIGN KEY (MaNganh) REFERENCES ChuyenNganh(MaNganh),
	MaLopHoc int CHECK(LEN(MaLopHoc)<=6) PRIMARY KEY,
);
GO

CREATE TABLE sinhVien(
	MSV nvarchar(7) PRIMARY KEY,
	HVT nvarchar(50) NOT NULL,
	NgaySinh date,
	MaNganh nvarchar(2) ,
	 CONSTRAINT FK_MaNganh 
	   FOREIGN KEY(MaNganh) REFERENCES ChuyenNganh(MaNganh),
	SDT int CHECK(LEN(SDT)<=10),
	--Sa
);

GO
CREATE TABLE diem(
	MSV nvarchar(7) CONSTRAINT FK_MSV FOREIGN KEY(MSV) REFERENCES sinhVien(MSV),
	MaNganh nvarchar(2) 
		CONSTRAINT FK_MaNganh 
		FOREIGN KEY (MaNganh) 
		REFERENCES ChuyenNganh(MaNganh),
		
	MaMonHoc int CHECK(LEN(MaMonHoc)<=6) 
		CONSTRAINT FK_MNH 
		FOREIGN KEY(MaMonHoc) 
		REFERENCES MonHoc(MaMonHoc),

	PRIMARY KEY(MSV,MaNganh,MaMonHoc),
);
GO