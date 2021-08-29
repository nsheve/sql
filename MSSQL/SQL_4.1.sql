USE Session
GO

create table Groups
(
NumGroup int IDENTITY(1,1) PRIMARY KEY,
NumSt int,
Quantity int CHECK (Quantity BETWEEN 0 AND 20)
)
GO
CREATE TABLE Students
(
NumSt int IDENTITY(1,1) PRIMARY KEY,
Fio varchar(50),
NumGroup int FOREIGN KEY REFERENCES Groups
ON DELETE SET NULL
ON UPDATE CASCADE 
)
GO
