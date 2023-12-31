USE TestingSystem;

-- Question 2: Lấy ra tất cả phòng ban
SELECT* FROM Department;

-- Question 3: Lấy ra id của phòng ban "Sale"
SELECT* 
FROM `Account` AS A INNER JOIN Department AS D 
ON A.DepartmentID = D.DepartmentID 
WHERE DepartmentName ="Sale";

-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT * 
FROM `Account`
WHERE CHAR_LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) 
								FROM `Account`);

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT * 
FROM `Account`
WHERE CHAR_LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) 
								FROM `Account`
								WHERE DepartmentID = 3);
                            
-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2022
SELECT*
FROM `Group`
WHERE CreateDate < '2022-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời

SELECT QuestionID,COUNT(QuestionID) AS TEMP
FROM Answer
GROUP BY QuestionID 
HAVING TEMP >= 2;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT `code`
FROM Exam
WHERE Duration > 60 AND CreateDate < '2019-12-20';
-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `Group`
ORDER BY CreateDate DESC
LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT DepartmentID, COUNT(DepartmentID) AS SONHANVIEN
FROM `Account`
WHERE DepartmentID = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT Fullname
FROM `Account`
WHERE substring_index(Fullname," ",-1) LIKE 'D%o';
-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE FROM exam
WHERE CreateDate < '2019/12/20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE FROM Question
WHERE Content LIKE 'Câu hỏi%' AND QuestionID = 1;

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account`
SET 
	FullName = 'Nguyễn Bá Lộc',
    Email = 'loc.nguyenba@vti.com.vn'
WHERE AccountID = 5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4 
UPDATE GroupAccount 
SET GroupID = 4
Where AccountID = 5;