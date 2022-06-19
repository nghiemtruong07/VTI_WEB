create database if not exists testing_system_assignment_1 ;
use testing_system_assignment_1;

CREATE TABLE departments (
    departmentID INT NOT NULL AUTO_INCREMENT,
    departmentName VARCHAR(255),
    PRIMARY KEY (departmentID)
);

CREATE TABLE positions (
    positionID INT NOT NULL AUTO_INCREMENT,
    positionName ENUM('Dev', 'Test', 'Scrum Master', 'PM'),
    PRIMARY KEY (positionID)
);

CREATE TABLE accounts (
    accountID INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE,
    username VARCHAR(255),
    fullname VARCHAR(255),
    departmentID INT,
    positionID INT,
    createDate DATE,
    PRIMARY KEY (accountID),
    FOREIGN KEY (departmentID)
        REFERENCES departments (departmentID),
    FOREIGN KEY (positionID)
        REFERENCES positions (positionID)
);

CREATE TABLE `groups` (
    groupID INT NOT NULL AUTO_INCREMENT,
    groupName VARCHAR(255),
    creatorID INT UNIQUE,
    createDate DATE,
    PRIMARY KEY (groupID)
);
alter table `groups`
drop constraint creatorID;

CREATE TABLE groupaccount (
    groupID INT,
    accountID INT,
    joindate DATE,
    CONSTRAINT PK_groupaccount PRIMARY KEY (groupID , accountID),
    FOREIGN KEY (groupID)
        REFERENCES `groups` (groupID),
    FOREIGN KEY (accountID)
        REFERENCES accounts (accountID)
);
CREATE TABLE typequestion (
    typeID INT NOT NULL AUTO_INCREMENT,
    typeName ENUM('Easy', 'Multiple-choice'),
    PRIMARY KEY (typeID)
);

CREATE TABLE categoryquestion (
    categoryID INT NOT NULL AUTO_INCREMENT,
    categoryName VARCHAR(20),
    PRIMARY KEY (categoryID)
);

CREATE TABLE questions (
    questionID INT NOT NULL AUTO_INCREMENT,
    content TEXT,
    categoryID INT,
    typeID INT,
    creatorID INT UNIQUE,
    createDate DATE,
    PRIMARY KEY (questionID),
    FOREIGN KEY (categoryID)
        REFERENCES categoryquestion (categoryID),
    FOREIGN KEY (typeID)
        REFERENCES typequestion (typeID)
);

CREATE TABLE answer (
    answerID INT NOT NULL AUTO_INCREMENT,
    content TEXT,
    questionID INT,
    iscorrect ENUM('T', 'F'),
    PRIMARY KEY (answerID),
    FOREIGN KEY (questionID)
        REFERENCES questions (questionID)
);

CREATE TABLE exams (
    examID INT NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(20),
    title VARCHAR(50),
    categoryID INT UNIQUE,
    duration INT CHECK (duration >= 45 AND duration <= 60),
    creatorID INT,
    createDate DATE,
    PRIMARY KEY (examID),
    FOREIGN KEY (categoryID)
        REFERENCES categoryquestion (categoryID)
);
CREATE TABLE examquestion (
    examID INT,
    questionID INT,
    CONSTRAINT PK_examquestion PRIMARY KEY (examID , questionID),
    FOREIGN KEY (examID)
        REFERENCES exams (examID),
    FOREIGN KEY (questionID)
        REFERENCES questions (questionID)
);