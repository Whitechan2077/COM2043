USE QLDA;
GO
ALTER TRIGGER XoaNv ON NHANVIEN
	FOR DELETE 
	AS
		BEGIN
		DECLARE @DIACHI nvarchar(200);
		SELECT @DIACHI = DCHI FROM NHANVIEN
		IF (CHARINDEX('Tp HCM',@DIACHI)) > 0
			BEGIN
				PRINT 'Khong the xoa';
				ROLLBACK TRANSACTION 
			END
		END
DROP TRIGGER XoaNv
DELETE FROM NHANVIEN WHERE MANV like '018';
/*
Cấu trúc của Tigger
 CREATE TRIGGER tên_trigger ON tên_bảng 
	FOR (INSERT , UPDATE <DELETE)
	AS
	t -sql
	có rất nhiều loại trigger như 
	DML DDL System, db trigger, cpmpund, dll, instead of để thực hiện nhiều loại chức năng khác nhau
	DML thực hiện khi insert delete update thí nó sẽ thực thi trong khi hoặc sau khi 
	các truy vấn khi dữ liệu được sửa đổi
	FOR (trong khi)
	AFTER (sau khi)
	loại trigger chỉ định nghĩa trong csdl
	Hai loại bảng inserted, deleted là hai bảng dùng để lưu trữ dư liệu tạm thời khi chúng ta thực hiên truy vấn insert
	delete update
	-khi chúng ta xóa các bản gi có giá > 5000
	bản chất dữ liệu cần xóa sẽ tạo bản sao trong bàng deleted 
	truy vấn được commit thì các bản ghi trong bảng mới được xóa thật
	bảng deleted tạo re để kiểm soát các hành vi liên quan để hành động xóa
	nếu có lỗi thì chúng ra có thể Roll back TRANSACTION bảo toàn dữ liệu cũ
	nguyên lý hoạt đọng sẽ như sau
	-> insert delete update đẩy dữ liệu vào trong inserted là deleted
	-> kiểm tra điều kiện kết quả -> thực hiện trigger nếu có -> thực hiện truy vấn trong db
	Trigger for trong khi truy vấn

	*/
Go
CREATE TRIGGER selectInsert ON NHANVIEN 
	FOR INSERT
	AS
	BEGIN
	SELECT * FROM NHANVIEN
	END
SELECT * FROM NHANVIEN
INSERT INTO NHANVIEN
		VALUES('A','B','C','018','2000-11-1',N'119 Cống Quỳnh, Tp HCM','Nam',50000,'006',5);
GO
CREATE TRIGGER tg_checkLuong ON NHANVIEN
	FOR INSERT 
	AS
		BEGIN
		IF (SELECT LUONG FROM inserted) < 5000 --ở trong bảng ảo
		BEGIN
			PRINT 'luong >5000'
			ROLLBACK TRANSACTION 
		END
		END
GO
CREATE TRIGGER tg_check_update ON NHANVIEN 
	FOR UPDATE 
AS
	BEGIN
	IF(SELECT LUONG FROM inserted) <5000
		BEGIN
		PRINT 'Luong >5000'
		ROLLBACK TRANSACTION
		END
	END
	UPDATE NHANVIEN 
		SET LUONG = 5000
		WHERE MANV like '018'
/*
Nói một phần về lý thuyết
trigger sinh ra để kiểm tra dữ liệu của db khi được thay đổi
Trigger có 2 DML DDL 
-- AFTER TRIGGER 
Trigger đã được dùng sau khi tương tác xong với csdl
*/
GO
CREATE TRIGGER tg_checkNv 
	ON NHANVIEN
	AFTER DELETE 
	AS
		BEGIN
		SELECT COUNT(MANV) AS'Da xoa nhan vien' FROM deleted
	END
GO
CREATE TRIGGER Tg_checkUpdate 
	ON NHANVIEN
	AFTER UPDATE
	AS
		BEGIN
		SELECT COUNT(MANV) FROM inserted
		END
/*
INSTEAD OF TRIGGER
 Khi delete ,UPDATE INSERT => xảy ra cấn do rằng buộc
 => sinh ra để giải quyết, change toàn bộ
 vd delete sẽ delete dữ liệu liên quan
*/
GO
CREATE TRIGGER tg_delete ON NHANVIEN
	INSTEAD OF DELETE 
	AS
	BEGIN
		DELETE FROM THANNHAN WHERE MA_NVIEN IN (SELECT MANV FROM deleted)
		DELETE FROM NHANVIEN WHERE MANV IN (SELECT MANV FROM deleted)
	END
DELETE FROM NHANVIEN WHERE MANV = '017'
SELECT * FROM THANNHAN
SELECT * FROM NHANVIEN