DROP DATABASE IF EXISTS TestingSystem_1;
CREATE DATABASE TestingSystem_1;
USE TestingSystem_1;

-- Table Department
CREATE TABLE Department(
	DepartmentID 	TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
    DepartmentName VARCHAR(50) NOT NULL,
    PRIMARY KEY(DepartmentID)
); 
-- Table Position
CREATE TABLE `Position`(
	PositionID 		TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
    PositionName 	ENUM('Dev', 'Test', 'Scrum Master', 'PM'),
    PRIMARY KEY(PositionID)
);
-- Table Account
CREATE TABLE `Account`(
	AccountID 		TINYINT UNSIGNED AUTO_INCREMENT NOT NULL ,
    Email 			VARCHAR(255) UNIQUE NOT NULL,
    Username 		VARCHAR(255) NOT NULL,
    Fullname 		VARCHAR(255) NOT NULL,
    DepartmentID 	TINYINT UNSIGNED NOT NULL,
    PositionID 	TINYINT UNSIGNED NOT NULL,
	CreateDate 	DATE,
    PRIMARY KEY(AccountID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)

);
-- Table Group
CREATE TABLE `Group`(
	GroupID 	TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    GroupName 	VARCHAR(255) NOT NULL,
    CreatorID 	TINYINT UNSIGNED NOT NULL,
    CreateDate DATE NOT NULL,
    PRIMARY KEY(GroupID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);
-- Table Group Account
CREATE TABLE GroupAccount(
	GroupID 	TINYINT UNSIGNED NOT NULL,
    AccountID 	TINYINT UNSIGNED NOT NULL,
    JoinDate 	DATETIME NOT NULL,
    PRIMARY KEY(GroupID, AccountID), -- /GroupAccountID PRIMARY AUTO_INCREMENT NOT NULL,
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)

);
-- Table TypeQuestion
CREATE TABLE TypeQuestion(
	TypeID 		TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
    TypeName 	ENUM ('Essay', 'Multiple-choice'),
    PRIMARY KEY(TypeID)
);
-- Table CategoryQuestion
CREATE TABLE CategoryQuestion(
	CategoryID 		TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
    CategoryName 	VARCHAR(255) NOT NULL,
    PRIMARY KEY(CategoryID)
);

-- Table Question
CREATE TABLE Question(
	QuestionID		TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
    Content 		VARCHAR(1000),
    CategoryID 		TINYINT UNSIGNED NOT NULL,
    TypeID			TINYINT UNSIGNED NOT NULL,
    CreatorID 		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATE NOT NULL,
    PRIMARY KEY(QuestionID),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

-- Table Answer
CREATE TABLE Answer(
	AnswerID 		TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
    Content		VARCHAR(1000),
    QuestionID		TINYINT UNSIGNED NOT NULL,
    isCorrect		BOOLEAN,
    PRIMARY KEY(AnswerID),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

-- Table Exam
CREATE TABLE Exam(
	ExamID 			TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
    `Code`			VARCHAR(50) NOT NULL,
    Title			VARCHAR(50) NOT NULL,
    CategoryID		TINYINT UNSIGNED NOT NULL,
    Duration		TINYINT UNSIGNED NOT NULL,
    CreatorID		TINYINT UNSIGNED NOT NULL,
    CreateDate 	DATE NOT NULL,
    PRIMARY KEY(ExamID),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

-- Table ExamQuestion
CREATE TABLE ExamQuestion(
	ExamID 			TINYINT UNSIGNED NOT NULL,
    QuestionID		TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(ExamID, QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);


-- Add data Department
INSERT INTO Department(DepartmentName )
VALUES 					(N'Marketing'),
						(N'Sale'),
						(N'Bảo vệ'),
						(N'Nhân sự'),
						(N'Kỹ thuật'),
                        (N'Tài chính'),
                        (N'Phó giám đốc'),
                        (N'Giám đốc'),
                        (N'Thư ký'),
                        (N'Bán hàng');
-- Add data Position
INSERT INTO `Position`(PositionName)
VALUES 					(N'Dev'),
						(N'Test'),
						(N'Scrum Master'),
						(N'PM');
-- Add data Account
INSERT INTO `Account`(Email ,Username ,Fullname ,DepartmentID ,PositionID ,CreateDate 	)
VALUES 				(N'davidtran@gmail.com', N'DavidTran', N'David Tran', 1, 1, '2020-12-31' ),
					(N'tunghq@gmail.com', N'TungHQ', N'Ha Quang Tung', 2, 2, '2020-11-28' ),
					(N'khangpham@gmail.com', N'KhangPT', N'Pham Thanh Khang', 3, 3, '2022-10-09' ),
					(N'hoangnv@gmail.com', N'HoangNV', N'Nguyen Viet Hoang', 4, 4, '2021-01-30' ),
					(N'trantuan@gmail.com', N'TuanTM', N'Tran Manh Tuan', 7, 1, '2020-05-21' );
-- Add data Group
INSERT INTO `Group`(GroupName ,CreatorID ,CreateDate )
VALUES 				(N'Android', 1, '2021-01-01'),
					(N'Web', 2, '2021-02-01'),
                    (N'TTS', 3, '2023-02-03'),
                    (N'Fresher', 4, '2022-04-01'),
                    (N'Junior',5,'2020-06-22');
-- Add data GroupAccount
INSERT INTO GroupAccount(GroupID,AccountID,JoinDate)
VALUES					('1','1','2021-01-01'),
						('2','2','2021-02-01'),
						('3','3','2023-02-03'),
						('4','4','2022-04-01'),
						('5','5','2020-06-22');

-- Add data TypeQuestion
INSERT INTO TypeQuestion(TypeName)
VALUES					('Essay'),
						('Multiple-Choice');
                        
-- Add data CategoryQuestion
INSERT INTO categoryquestion(CategoryName)
VALUES						('Java'),
							('Javascript'),
							('SQL'),
							('HTML'),
							('JSREACT');
-- Add data Question
INSERT INTO Question(Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES				('Question about Java',1,'1','1',NOW()),
					('Question about Javascript',2,'1','2',NOW()),
					('Question about SQL', 3,'1','3',NOW()),
					('Question about HTML',4,'2','4',NOW()),
					('Question about JSREACT',5,'2','5',NOW());
        
-- Add data Answer
INSERT INTO Answer(Content,QuestionID,isCorrect)
VALUES			('Answer about Java','1',1),
				('Answer about Javascript','2',1),
				('Answer about SQL','3',0),
				('Answer about HTML','4',0),
				('Answer about JSREACT','5',1);
                
-- Add data Exam
INSERT INTO Exam(`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES			('EXAMS001','Java Learning',1,1,'1',NOW()),
				('EXAMS002','Javascript Learning',2,1,2,NOW()),
				('EXAMS003','SQL Learning',3,1,2,NOW()),
				('EXAMS004','HTML Learning',4,1,3,NOW()),
				('EXAMS005','JSREACT Learning',5,1,4,NOW());
        
-- Add data ExamQuestion
INSERT INTO ExamQuestion(ExamID,QuestionID)
VALUES					('1','1'),
						('2','2'),
						('3','3'),
						('4','4'),
						('5','5');
                        
