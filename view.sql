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
	*/