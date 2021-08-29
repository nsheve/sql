USE MySession;
GO

--1.
--������ �������� � ������������� ������������� ��� ������� �������� ���������, 
--�� ������� ���� �� ����� ��������� ���� �������� ������
--CREATE VIEW Disciplines_with_balls 
--	AS SELECT Distinct Name 
--		FROM Disciplines	
--			INNER JOIN Uplans ON Disciplines.NumDisc=Uplans.NumDisc INNER JOIN Balls ON Uplans.IdDisc=Balls.IdDisc;
--GO

--SELECT * FROM Disciplines_with_balls;

--2.
--������ �������� � ������������� ������������� c �������������� ����������� �������� ��� ������� ���������, 
--������� �������� ������� � ������� ������ ������ �� �����
--CREATE VIEW Students_top_and_last (Fio, Complete) AS
--	(SELECT A.Stud, 'NO' FROM (SELECT NumSt AS Stud FROM Students EXCEPT Select Distinct NumSt AS Stud FROM Balls) AS A)
--UNION
--	(SELECT NumSt, 'Five' FROM Balls WHERE Ball=5);
--GO

--SELECT * FROM Students_top_and_last;

--3.
--������ �������� � ������������� ������������� � �������������� ���������� �������, 
--����������� � ����������� ��� ������ ���������, ������� ����� ��� �������� ������� ��������

--CREATE VIEW Students_complete (Fio, Direction, Numer_of_balls) AS 
--	SELECT NumSt, NumDir, COUNT(Ball) 
--		FROM Balls JOIN Uplans ON Balls.IdDisc=Uplans.IdDisc WHERE Semestr=1 
--			GROUP BY NumSt, NumDir HAVING Count(Ball)=(SELECT COUNT( *) FROM Uplans u WHERE Uplans.NumDir=u.NumDir and semestr=1);
--GO

--SELECT * FROM Students_complete;

--4.
--������ �������� � ������������� ������������� � �������������� ��������� NOT EXISTS 
--��� ������ ������� ���������, ������� ����� ��� �������� ������ �����
--CREATE VIEW Students_complete_2 AS
--	SELECT Students.NumSt	
--		FROM Students JOIN Groups ON Groups.NumGr = Students.NumGr WHERE 
--			NOT EXISTS (SELECT * FROM Uplans WHERE (Semestr=CONVERT(int, LEFT(Students.NumGr,1))*2-1 OR
--				Semestr=CONVERT(int, LEFT(Students.NumGr,1))*2) AND Groups.NumDir=Uplans.NumDir AND		
--					NOT EXISTS (SELECT * FROM Balls WHERE Balls.IdDisc=Uplans.IdDisc and Students.NumSt=Balls.NumSt) );
--GO

--SELECT * FROM Students_complete_2;