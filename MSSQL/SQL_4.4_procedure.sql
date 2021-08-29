USE MySession
GO

--1.
--������ �������� ��������� ��� ����������. 
--������� ��������� ��� �������� ������ ���������� ���������
--CREATE PROCEDURE Count_Students AS
--	SELECT COUNT(*)	
--		FROM Students

--2.
--������ �������� ��������� c ������� ����������. 
--������� ��������� ��� �������� ���������, ������� ���� �� ���� ������� � �������� ��������
--CREATE PROCEDURE Count_Students_Sem @Count_sem AS INT
--	AS SELECT COUNT(Distinct NumSt) 
--		FROM Balls JOIN Uplans ON Uplans.IdDisc=Balls.IdDisc WHERE Semestr>=@Count_sem;
--GO

--3.1
--������� ��������� ��� ��������� ������ ��������� ���������� �����������, 
--������� ������� �� ��������� ����������
--CREATE PROCEDURE List_Students_Dir (@Dir AS INT, @Disc AS VARCHAR(30)) AS
--	SELECT Distinct Students.FIO 
--		FROM Groups JOIN Students ON Groups.NumGr=Students.NumGr JOIN Balls ON Students.NumSt=Balls.NumSt JOIN Uplans ON Uplans.IdDisc=Balls.IdDisc WHERE Groups.NumDir=@Dir 
--			and NumDisc=(SELECT NumDisc FROM Disciplines WHERE Name=@Disc);
--GO

--3.2 
--������� ��������� ��� ����� ���������� � ����� ��������
--CREATE PROCEDURE Enter_Students (@Fio AS VARCHAR(60), @Group AS VARCHAR(30)) AS
--	INSERT INTO Students (FIO, NumGr) VALUES (@Fio, @Group);
--GO

--4.
--������ �������� ��������� � �������� ����������� � ���������� �� ���������. 
--������� ��������� ��� �������� ��������� ��������� ������ �� ��������� ����
--CREATE PROCEDURE Next_Course (@Group AS VARCHAR(10)='13504/1') AS
--	UPDATE Students SET NumGr=CONVERT(char(1),CONVERT(int, LEFT(NumGr,1))+1)+ SUBSTRING(NumGr,2,LEN(NumGr)-1)
--		WHERE NumGr=@Group;
--GO

--�������
--CREATE PROCEDURE Back_Course (@Group AS VARCHAR(10)='23504/1') AS
--	UPDATE Students SET NumGr=CONVERT(char(1),CONVERT(int, LEFT(NumGr,1))-1)+ SUBSTRING(NumGr,2,LEN(NumGr)+1)
--		WHERE NumGr=@Group;
--GO

--5.
--������ �������� ��������� � �������� � ��������� �����������. 
--������� ��������� ��� ����������� ���������� ����� �� ���������� �����������.
--CREATE PROCEDURE Number_Groups (@Dir AS int, @Number AS int OUTPUT) AS
--	SELECT @Number =COUNT(NumGr)	
--		FROM Groups WHERE NumDir=@Dir;
--GO

--6.
--������ �������� ���������, ������������ ��������� �������� ���������. 
--������� ���������� ��������� ��� �������� ��������� ��������� ������ �� ��������� ����.
--CREATE PROCEDURE Delete_Students_Complete AS
--	INSERT INTO ArchiveStudents 
--		SELECT YEAR(GETDATE()), NumSt, FIO, NumGr 
--			FROM Students WHERE LEFT(NumGr,1)=6;
--				DELETE FROM Students WHERE LEFT(NumGr,1)=6;
--GO

--CREATE PROCEDURE Insert_Students_Complete AS
--	INSERT INTO Students 
--		SELECT NumSt, FIO, NumGr 
--			FROM ArchiveStudents WHERE LEFT(NumGr,1)=6;
--				DELETE FROM ArchiveStudents WHERE LEFT(NumGr,1)=6;
--GO
