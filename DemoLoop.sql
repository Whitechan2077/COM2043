USE QLDA;
DECLARE @i int = 1;
DECLARE @countEmployee int
select @countEmployee=MAX(MANV) FROM NHANVIEN;
DECLARE @employeeName nvarchar(10)
DECLARE @employeeAddress nvarchar(10)
WHILE @i <= @countEmployee
	BEGIN
	IF EXISTS (SELECT MANV FROM NHANVIEN WHERE CONVERT(int,MANV) = @i)
	BEGIN
		SELECT @employeeName=TENNV 
			FROM NHANVIEN 
			WHERE CONVERT(int,MANV) = @i
	    SELECT @employeeAddress = SUBSTRING(DCHI,CHARINDEX(',',DCHI)+1,LEN(DCHI)-CHARINDEX(',',DCHI)) 
			FROM NHANVIEN 
			WHERE CONVERT(int,MANV) = @i
	    PRINT CAST(@i AS varchar)+'. Nhan vien '+ @employeeName+' sinh song tai '+TRIM(@employeeAddress)
	END
	SET @i = @i+1
END
--------------------------------------------
print'---------------------------------------'
SET @i=1 
WHILE @i <= @countEmployee
	BEGIN
	IF EXISTS (SELECT MANV FROM NHANVIEN WHERE CONVERT(int,MANV) = @i)
	BEGIN
		SELECT @employeeName=TENNV 
			FROM NHANVIEN 
			WHERE CONVERT(int,MANV) = @i
	    SELECT @employeeAddress = PHAI 
			FROM NHANVIEN 
			WHERE CONVERT(int,MANV) = @i
	IF(@employeeAddress like N'Nữ')
		PRINT CAST(@i AS varchar)+'. Nhan vien '+ @employeeName+N' Gioi tinh '+TRIM(@employeeAddress)+'Thuong 10 tr'
	ELSE 
		PRINT CAST(@i AS varchar)+'. Nhan vien '+ @employeeName+'Gioi tinh '+TRIM(@employeeAddress)+' Thuong 6 tr'

	END
	SET @i = @i+1
END