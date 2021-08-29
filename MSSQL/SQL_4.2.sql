USE MySession
GO

--3.1 ����������� ���������� 
SELECT Title 
	FROM Directions
GO

--3.2 ������ ����� �� ������������ ���������� 
SELECT NumGr 
	FROM Groups, Directions 
		WHERE Groups.NumDir = Directions.NumDir
GO

--3.3 ��� ���������
SELECT FIO 
	FROM Students 
GO

--3.4 �������� ������ ��������
SELECT DISTINCT Students.NumSt, Students.FIO, Balls.Ball 
	FROM Students, Balls 
		WHERE (Balls.Ball) > 0 AND Students.NumSt = Balls.NumSt
GO

--3.5 � DISTINCT �������� � ������� ���� 
SELECT DISTINCT Uplans.NumDir 
	FROM Uplans
GO

--3.5 ��� DISTINCT �������� � ������� ���� 
SELECT Uplans.NumDir 
	FROM Uplans, Directions 
		WHERE Uplans.NumDir = Directions.NumDir 
			GROUP BY Uplans.NumDir 
				HAVING COUNT(Uplans.NumDir) > 1
GO

--3.6 ��������
SELECT DISTINCT Semestr 
	FROM Uplans
GO

--3.7 �������� 13504/1
SELECT FIO, NumGr 
	FROM Students 
		WHERE Students.NumGr = '13504/1'
GO

--3.8 ����������� ��� ��������� 13504/1 � 1 ��������
SELECT DISTINCT NAME 
	FROM Disciplines, Uplans, Directions 
		WHERE Uplans.Semestr = '1' AND Directions.NumDir = '230100' AND Uplans.NumDisc = Disciplines.NumDisc
GO

--3.9 ������ ����� � ���-�� ��������� 
SELECT NumGr, COUNT(NumSt) 
	FROM Students 
		GROUP BY NumGr 
GO

--3.10 �������� ������� ���
SELECT Students.NumGr, COUNT(DISTINCT Balls.NumSt) 
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt
			GROUP BY Students.NumGr
GO

--3.11 �������� ������� > 1 ���
SELECT NumGr, COUNT(DISTINCT Balls.NumSt)
	FROM Balls, Students
		WHERE Balls.NumSt = Students.NumSt AND Balls.NumSt IN (SELECT Balls.NumSt FROM Balls GROUP BY Balls.NumSt HAVING count(*)>1) 
			GROUP BY NumGr 
GO

--4.1 ��� ���������, ������� ���
SELECT DISTINCT FIO 
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt
GO

--4.2 �������� ���������, �� ������� �������� ������� ������� 
SELECT DISTINCT NAME 
	FROM Disciplines, Uplans, Balls
		WHERE Balls.IdDisc = Uplans.IdDisc AND Uplans.NumDisc = Disciplines.NumDisc
GO

--4.3 �������� ���������, ����������� 230100
SELECT DISTINCT NAME 
	FROM Disciplines, Uplans
		WHERE Disciplines.NumDisc = Uplans.NumDisc AND Uplans.NumDir = 230100
GO

--4.4 ���, ������� ����� > 1 ���
SELECT FIO
	FROM Balls, Students
		WHERE Balls.NumSt = Students.NumSt AND Balls.NumSt IN 
			(SELECT Balls.NumSt 
				FROM Balls 
					GROUP BY Balls.NumSt 
						HAVING count(*) > 1) 
			GROUP BY FIO
GO

--4.5 ���, ���������� ���. ����
SELECT FIO, Ball
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt AND Balls.Ball = 3
GO

--4.6 ���, ���������� ����. ����
SELECT DISTINCT FIO, Ball, COUNT(Ball)
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt AND Balls.Ball = 5
			GROUP BY FIO, Ball
GO

--4.7 ������ �����, ��� ���� > 1 �������� �������� ������� �� ������ � 1 ��������....
SELECT NumGr, FIO, Ball
	FROM Students, Balls, Disciplines, Uplans
		WHERE Students.NumSt = Balls.NumSt AND Balls.IdDisc = Uplans.IdDisc AND Uplans.NumDisc = Disciplines.NumDisc AND Uplans.Semestr = 1
			GROUP BY NumGr, FIO, Ball 
GO

--4.8 ���, ��� ����� ����� > 9
SELECT FIO, SUM(Ball) 
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt
			GROUP BY FIO HAVING SUM(Ball) > 9
GO

--4.9 ��������, �� ������� ������� ��� > 1
SELECT Semestr, COUNT(*)
	FROM Uplans, Balls
		WHERE Balls.IdDisc = Uplans.IdDisc
			GROUP BY Semestr HAVING COUNT(*) > 1
GO

--4.10 ���, ������� ����� 1 ��������    ��� ��� ���������� �� 4.4??????
SELECT FIO
	FROM Balls, Students, Disciplines, Uplans
		WHERE Balls.NumSt = Students.NumSt AND Disciplines.NumDisc = Uplans.NumDisc AND Uplans.IdDisc = Balls.IdDisc 
			--(SELECT Balls.NumSt 
			--	FROM Balls 
			--		GROUP BY Balls.NumSt 
			--			HAVING count(*) > 1) 
			GROUP BY FIO HAVING COUNT(DISTINCT Uplans.NumDisc) > 1
GO
