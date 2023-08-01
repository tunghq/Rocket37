DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

CREATE TABLE Department(
	DepartmentID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName		VARCHAR(50) UNIQUE KEY NOT NULL
);

CREATE TABLE `Position`(
	PositionID			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	PositionName		ENUM('Dev', 'Test', 'Scrum Master', 'PM')  UNIQUE KEY
);

CREATE TABLE `Account`(
	AccountID			SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email				VARCHAR(50) UNIQUE KEY,
    Username			VARCHAR(50) UNIQUE KEY NOT NULL,
    FullName			VARCHAR(50) NOT NULL,
    DepartmentID		TINYINT UNSIGNED,
    PositionID			TINYINT UNSIGNED,
    CreateDate			DATE DEFAULT(now()), -- '2023-02-18'
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE,
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID) ON DELETE CASCADE
);

CREATE TABLE `Group`(
	GroupID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName			VARCHAR(100) UNIQUE KEY NOT NULL,
    CreatorID			SMALLINT UNSIGNED,
    CreateDate			DATE DEFAULT(now()),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

CREATE TABLE `GroupAccount`(
	ID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	GroupID				TINYINT UNSIGNED,    -- 1 1 1 2
	AccountID			SMALLINT UNSIGNED,	 -- 1 2 4 1
    JoinDate			DATE DEFAULT(now()),
	UNIQUE KEY (GroupID, AccountID),
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID) ON DELETE CASCADE,
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

CREATE TABLE TypeQuestion(
	TypeID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	TypeName			ENUM('Essay', 'Multiple-Choice') UNIQUE KEY
);

CREATE TABLE CategoryQuestion(
	CategoryID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	CategoryName			VARCHAR(50) UNIQUE KEY NOT NULL
);

CREATE TABLE Question(
	QuestionID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Content					VARCHAR(1000) NOT NULL,
	CategoryID				TINYINT UNSIGNED,
	TypeID					TINYINT UNSIGNED,
	CreatorID				SMALLINT UNSIGNED,
    CreateDate				DATE DEFAULT(now()),
    FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID) ON DELETE CASCADE,
    FOREIGN KEY (TypeID) REFERENCES `TypeQuestion`(TypeID) ON DELETE CASCADE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

CREATE TABLE Answer(
	AnswerID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Content					VARCHAR(1000) NOT NULL,
	QuestionID				TINYINT UNSIGNED,
	isCorrect				BOOLEAN NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID) ON DELETE CASCADE
);

CREATE TABLE Exam(
	ExamID					TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`Code`					VARCHAR(20) UNIQUE KEY NOT NULL,
	Title					VARCHAR(50) NOT NULL,
	CategoryID				TINYINT UNSIGNED,
	Duration				SMALLINT UNSIGNED NOT NULL,
	CreatorID				SMALLINT UNSIGNED,
	CreateDate				DATE DEFAULT(now()),
    FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID) ON DELETE CASCADE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE
);

CREATE TABLE ExamQuestion(
	ID						TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	ExamID					TINYINT UNSIGNED,
    QuestionID				TINYINT UNSIGNED,
	UNIQUE KEY (ExamID, QuestionID),
    FOREIGN KEY (ExamID) REFERENCES `Exam`(ExamID) ON DELETE CASCADE,
    FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID) ON DELETE CASCADE
);


/*============================== THÊM DỮ LIỆU VÀO BẢNG =================================*/
/*======================================================================================*/
-- Thêm dữ liệu cho bảng Department
INSERT INTO Department(DepartmentName) VALUES 
						('Trainee'		),
						('Sale'			),
						('Bảo vệ'		),
						('Nhân sự'		),
						('Kỹ thuật'		),
						('Tài chính'	),
						('Phó giám đốc'	),
						('Giám đốc'		),
						('Thư kí'		),
						('Bán hàng'		);
    
-- Thêm dữ liệu cho bảng `Position`
INSERT INTO `Position`	(PositionName	) 
VALUE 					('Dev'			),
						('Test'			),
						('Scrum Master'	),
						('PM'			); 

-- Thêm dữ liệu cho bảng `Account`
INSERT INTO `Account`(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUE 				('haidang29productions@gmail.com'	, 'dangblack'		,'Nguyen Hai Dang'		,   '1'			,   '1'		,'2022-03-05'),
					('account1@gmail.com'				, 'quanganh'		,'Tong Quang Anh'		,   NULL		,   '2'		,'2022-03-05'),
                    ('account2@gmail.com'				, 'vanchien'		,'Nguyen Van Chien'		,   1			,   '3'		,'2022-03-07'),
                    ('account3@gmail.com'				, 'cocoduongqua'	,'Duong Do'				,   '3'			,   '4'		,'2022-03-08'),
                    ('account4@gmail.com'				, 'doccocaubai'		,'Nguyen Chien Thang'	,   '2'			,   '4'		,'2022-03-10'),
                    ('dapphatchetngay@gmail.com'		, 'khasalebanh'		,'Ngo Ba Kha'			,   '6'			,   '3'		,'2022-04-05'),
                    ('songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'		,   '7'			,   '2'		,'2022-04-05'),
                    ('sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'	,   '3'			,   '1'		,'2022-04-07'),
                    ('duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'		,   '5'			,   '2'		,'2022-04-07'),
                    ('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'				,   '10'		,   '1'		,'2022-04-09'),
					('account5@gmail.com'				, 'account5'		,'Nguyen T Dao'			,   '1'			,   '1'		,'2022-04-11'),
					('account6@gmail.com'				, 'account6'		,'Tong Quang Anh'		,   2			,   '2'		,'2022-04-11'),
                    ('account7@gmail.com'				, 'account7'		,'Nguyen Van Chien'		,   '1'			,   '3'		,'2022-04-12'),
                    ('account8@gmail.com'				, 'account8'		,'Duong Do'				,   '3'			,   '4'		,'2022-04-12'),
                    ('admin@gmail.com'					, 'admin'			,'Nguyen Chien Thang'	,   '5'			,   '4'		,'2022-04-13');

-- Thêm dữ liệu cho bảng `Group`
INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUE 				('Testing System'		,   5			,'2022-03-05'),
					('Developement'			,   1			,'2022-03-07'),
                    ('VTI Sale 01'			,   2			,'2022-03-09'),
                    ('VTI Sale 02'			,   3			,'2022-03-10'),
                    ('VTI Sale 03'			,   4			,'2022-03-28'),
                    ('VTI Creator'			,   6			,'2022-04-06'),
                    ('VTI Marketing 01'		,   7			,'2022-04-07'),
                    ('Management'			,   8			,'2022-04-08'),
                    ('Chat with love'		,   9			,'2022-04-09'),
                    ('Vi Ti Ai'				,   10			,'2022-04-10');

-- Thêm dữ liệu cho bảng GroupAccount
INSERT INTO GroupAccount	(  GroupID	, AccountID	, JoinDate	 )
VALUE 						(	1		,    1		,'2022-03-05'),
							(	2		,    2		,'2022-03-07'),
							(	1		,    2		,'2022-03-07'),
							(	3		,    3		,'2022-03-09'),
							(	1		,    4		,'2022-03-10'),
							(	2		,    5		,'2022-03-28'),
							(	5		,    5		,'2022-03-28'),
							(	2		,    6		,'2022-04-06'),
							(	3		,    7		,'2022-04-07'),
							(	8		,    8		,'2022-04-08'),
							(	9		,    9		,'2022-04-09'),
							(	2		,    10		,'2022-04-10'),
							(	10		,    10		,'2022-04-10'),
							(	3		,    11		,'2022-04-11'),
							(	4		,    12		,'2022-04-15'),
							(	9		,    12		,'2022-04-15'),
							(	4		,    13		,'2022-04-21'),
							(	2		,    14		,'2022-04-22'),
							(	5		,    15		,'2022-04-22');


-- Thêm dữ liệu cho bảng TypeQuestion
INSERT INTO TypeQuestion	(TypeName			) 
VALUE 						('Essay'			), 
							('Multiple-Choice'	); 


-- Thêm dữ liệu cho CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUE 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);
													
-- Thêm bảng Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUE 					('Câu hỏi về Java'	,	1		,   '1'			,   '1'		,'2022-04-05'),
						('Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2022-04-05'),
						('Hỏi về C#'		,	9		,   '2'			,   '3'		,'2022-04-06'),
						('Hỏi về Ruby'		,	6		,   '1'			,   '4'		,now()		),
						('Hỏi về Postma'	,	1		,   '1'			,   '5'		,'2022-08-06'),
						('Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2023-04-06'),
						('Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2022-04-06'),
						('Hỏi về C++'		,	8		,   '1'			,   '8'		,'2022-08-07'),
						('Hỏi về SQL'		,	4		,   '2'			,   '9'		,now()		),
						('Hỏi về Python'	,	7		,   '1'			,   '10'	,now()		),
						('Test'				,	7		,   '1'			,   '10'	,'2022-04-07');

-- Thêm bảng Answers
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUE 				('Trả lời 01'	,   1			,	TRUE		),
					('Trả lời 02'	,   1			,	TRUE		),
                    ('Trả lời 03'	,   1			,	FALSE		),
                    ('Trả lời 04'	,   2			,	TRUE		),
                    ('Trả lời 05'	,   2			,	TRUE		),
                    ('Trả lời 06'	,   3			,	TRUE		),
                    ('Trả lời 07'	,   4			,	FALSE		),
                    ('Trả lời 08'	,   5			,	FALSE		),
                    ('Trả lời 09'	,   6			,	TRUE		),
                    ('Trả lời 10'	,   6			,	FALSE		),
                    ('Trả lời 11'	,   7			,	TRUE		),
                    ('Trả lời 12'	,   8			,	FALSE		),
                    ('Trả lời 13'	,   9			,	FALSE		),
                    ('Trả lời 14'	,   10			,	TRUE		),
                    ('Trả lời 15'	,   10			,	TRUE		);
                                        
	
-- Thêm bảng Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUE 				('VTIQ001'		, 'Đề thi C#'			,	1			,	120		,   1			,'2017-04-05'),
					('VTIQ002'		, 'Đề thi PHP'			,	10			,	60		,   '1'			,'2022-04-05'),
                    ('VTIQ003'		, 'Đề thi C++'			,	9			,	120		,   '2'			,'2022-04-07'),
                    ('VTIQ004'		, 'Đề thi Java'			,	6			,	60		,   '3'			,'2017-04-08'),
                    ('VTIQ005'		, 'Đề thi Ruby'			,	5			,	120		,   '4'			,'2022-04-10'),
                    ('VTIQ006'		, 'Đề thi Postman'		,	3			,	60		,   '6'			,'2022-04-05'),
                    ('VTIQ007'		, 'Đề thi SQL'			,	2			,	30		,   '7'			,'2022-04-05'),
                    ('VTIQ008'		, 'Đề thi Python'		,	8			,	60		,   '8'			,'2022-04-07'),
                    ('VTIQ009'		, 'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2022-04-07'),
                    ('VTIQ010'		, 'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2022-04-08');
                    
-- Thêm bảng ExamQuestion
INSERT INTO ExamQuestion(ExamID		,QuestionID	) 
VALUE 					(	1		,	1		),
						(	2		,	1		),
						(	2		,	3		),
						(	2		,	4		),
						(	3		,	4		),
						(	3		,	5		),
						(	4		,	6		),
						(	4		,	1		),
						(	5		,	3		),
						(	5		,	4		),
						(	5		,	7		),
						(	6		,	8		),
						(	7		,	10		),
						(	8		,	9		),
						(	8		,	3		),
						(	9		,	1		),
						(	10		,	7		); 



                        
