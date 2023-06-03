-- view sử dụng thường để lduuw trữ các truy vấn khá đơn giản vào trong db
-- view có một số lợi ích như sau
--lợi ích là che đấu dữ liệu không cho xem full
-- với mỗi người dùng khác nhau có thể tạo các view riêng cho db đó
-- mỗi tài khoản login có thể tạo riêng tùy theo mục đích sử dụng view
-- luư truy vấn để tái sử dụng
--thực thi nhanh hơn truy vấn thường
--đảm bảo tính toàn vẹn của dữ liệu 
-- cú pháp tạo view
/*sytax
CREATE VIEW ten tên cột 1, tên cột 2
	WITH(Thông tin thiết đặt)
	AS 
	Câu truy vấn 
	WITH(thông tin thiết đặt)
	as
	truy vấn 
	WITH CHECK OPTION // có thể không có
Lưu ý tên view không được giống nhau hoặc trùng tên bảng
view không chưá các từ khóa như into order by, có thể dùng order by mới có top

ví dụ về view

*/
USE con_gio_bac_ki
/*
CREATE VIEW pdMoreThan20
as
select * from Products WHERE unint >20
*\
-- view chia lamf 2 loai
-- view cập nhật view update và view readonly
-- view có thể update trên csdl
-- với view update truy vấn không thể có  distinct top,group by 
-- ngược lại là readonly =))
--UPDATE VIEW tenvieu SET (DK)
Lưu ý khi sử dụng view có update là việc chúng ta sửa đổi các bản gi theo điều kiện trong view
thành giá trị mà ta muốn nến sẽ rất dễ xảy ra trường hợp dư liệu bị sửa một loạt đẫn đến sai nên chúng
ta cần cẩn trọng và có thể kết hợp với các cú pháp để kiểm ttra hoặc dùng transaction
bt tạo view để lấy ra tất cả CUSTOMER tất cả những mà Country là %a%

--function
-- chia làm 2 loại trả về giá trị và trả về bảng
-- bảng thì bảng đơn với bảng đa
-- giông nhau sp - function
-- PROCEDUCE có thể không return nhưng function thì bắt buộc 
-- function không chứa tham số out
-- Không chứa insert delete update
-- tuy nhiên vẫn có thể tạo được biến tạm trong thân function
ví đụ về một function trả về giá trị vô hướng 
 
CREATE function tính tuổi (@namSinh date)
retunrs int
AS 
BEGIN
	return YEAR(GETDATE() - YEAR(@namSinh))
END