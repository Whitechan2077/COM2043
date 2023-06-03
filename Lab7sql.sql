CREATE DATABASE QLNT
ON(
	NAME = ThongTinNhaTro,
	FILENAME = 'D:\FPTPOLYTECHNIC\Semester3\SQL SERVER\COM2043\ASIGNMENT\TTNT.mdf',
	SIZE = 5,
	MAXSIZE = 20,
	FILEGROWTH = 5
)
LOG ON(
	NAME = ThongTinNhaTro_LOG,
	FILENAME = 'D:\FPTPOLYTECHNIC\Semester3\SQL SERVER\COM2043\ASIGNMENT\TTNT.ldf',
	SIZE = 5,
	MAXSIZE = 20,
	FILEGROWTH = 5
);
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

SELECT * FROM Nguoi_Dung

GO

CREATE TRIGGER tg_checkMail ON Nguoi_Dung
	FOR INSERT
	AS
		BEGIN
		IF(SELECT email FROM inserted) like '%@gmail.com' PRINT 'INSERT thanh cong'
		ELSE 
			BEGIN
				Print'Loi do e mail sai'
				ROLLBACK TRANSACTION
			END
		END
GO

CREATE TRIGGER tg_checkSDT ON Nguoi_Dung
	FOR INSERT
	AS
		BEGIN
		IF(SELECT sdt FROM inserted) like '0%' AND (SELECT LEN(sdt) FROM inserted) = 10
			PRINT 'INSERT thanh cong'
		ELSE 
			BEGIN
				Print'Loi sdt sai'
				ROLLBACK TRANSACTION
			END
		END
GO
CREATE PROCEDURE sp_getUser
	@id int
	AS
		BEGIN
		IF @id = 0 SELECT maNguoiDung,tenNguoiDung,CASE
					WHEN gioiTinh =  0 THEN 'Nam'
					WHEN gioiTinh = 1 THEN N'Nữ'
					END AS [Gioi tinh]
					,
					'0'+CONVERT(varchar,FORMAT(CONVERT(int,sdt),'0##,##')) AS [sdt],
					diaChi,quan,email  FROM Nguoi_Dung
		ELSE 
			SELECT maNguoiDung,tenNguoiDung,CASE
					WHEN gioiTinh =  0 THEN 'Nam'
					WHEN gioiTinh = 1 THEN N'Nữ'
					END AS [Gioi tinh]
					,
					'0'+CONVERT(varchar,FORMAT(CONVERT(int,sdt),'0##,##')) AS [sdt],
					diaChi,quan,email
			FROM Nguoi_Dung
			WHERE maNguoiDung = @id;
		END
GO
EXEC sp_getUser 0
GO
CREATE PROCEDURE sp_insertUser
	@tenNguoiDung nvarchar(30),@gioiTinh tinyint,
	@sdt nvarchar(10),@diaChi nvarchar(50),
	@quan nvarchar(15),@email nvarchar(50)
AS
	BEGIN
	INSERT INTO Nguoi_Dung(tenNguoiDung,gioiTinh,sdt,diaChi,quan,email) 
		VALUES(@tenNguoiDung,@gioiTinh,@sdt,@diaChi,@quan,@email);
	END
EXEC sp_insertUser 'Hoang Lan',1,'0397767818','Nga Tu Ham Nghi','Nam Tu Lien','k1@gmail.com'
EXEC sp_insertUser 'Hoang Hong',1,'0397767813','Nga Tu Ham Nghi','Nam Tu Lien','k2@gmail.com'
EXEC sp_insertUser 'Hoang Duong',1,'0389767828','Nga Tu Ham Nghi','Nam Tu Lien','k3@gmail.com'
EXEC sp_insertUser 'Ambatukam',1,'03977678152','Nga Tu Ham Nghi','Nam Tu Lien','gm='