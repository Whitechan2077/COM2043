USE QLDA;
DECLARE @i int = 1;
DECLARE @max int;
SELECT @max = MAX(CONVERT(int,MANV)) FROM NHANVIEN;
DECLARE @gio float;
DECLARE @thuong float;
DECLARE @ten nvarchar(10);
WHILE @i<=@max
BEGIN
	IF EXISTS(SELECT MANV FROM NHANVIEN WHERE CONVERT(int,MANV) = @i)
		BEGIN
			SELECT @gio = COALESCE(SUM(PHANCONG.THOIGIAN),0)
				FROM PHANCONG JOIN NHANVIEN ON NHANVIEN.MANV = PHANCONG.MA_NVIEN
				WHERE CONVERT(int,MANV) = @i
			SELECT @thuong=CASE 
				WHEN @gio>35 THEN 10000000 + (@gio - 35) * 2000000
				WHEN @gio<35 AND @gio>0 THEN 10000000 - (35 - @gio) * 1000000
				WHEN @gio = 0 THEN 0
				END
			FROM PHANCONG
			SELECT @ten = TENNV
				FROM NHANVIEN 
				WHERE CONVERT(int,MANV) = @i	
			print CONVERT(varchar,@i)+N'. Nhân Viên '+@ten+N' Thời gian '+CONVERT(varchar,@gio)+' Thuong '+CONVERT(varchar,@thuong)
		END
	SET @i = @i +1
	
END
