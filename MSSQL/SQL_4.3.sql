USE MySession
GO

--3.1 
SELECT DISTINCT NumDir 
	FROM Uplans
		INNER JOIN Balls ON Uplans.IdDisc = Balls.IdDisc
		INNER JOIN Students ON Balls.NumSt = Students.NumSt 
GO

--3.2
SELECT DISTINCT Name 
	FROM Disciplines
		INNER JOIN Uplans ON Disciplines.NumDisc = Uplans.NumDisc WHERE Semestr = 1
GO

--3.3
SELECT DISTINCT NumGr 
	FROM Students
		INNER JOIN Balls ON Balls.NumSt = Students.NumSt
GO

--3.4
SELECT Name, NumSt
	FROM Disciplines
		INNER JOIN Uplans ON Disciplines.NumDisc = Uplans.NumDisc 
		INNER JOIN Balls ON Uplans.IdDisc = Balls.IdDisc
GO

--3.5
SELECT Students.NumGr
	FROM Students 
			INNER JOIN Groups ON Students.NumGr = Groups.NumGr
			GROUP BY Students.NumGr, Quantity HAVING COUNT(Students.NumGr) != Groups.Quantity   
GO

--3.6
(SELECT NumGr
	FROM Balls, Students
		WHERE Balls.NumSt = Students.NumSt AND Balls.NumSt IN (SELECT Balls.NumSt FROM Balls GROUP BY Balls.NumSt HAVING count(*)>1) 
			GROUP BY NumGr)
				UNION 
				(SELECT NumGr
					FROM Students, Balls
						WHERE Students.NumSt != Balls.NumSt)
GO

--3.7
SELECT DISTINCT NAME 
	FROM Disciplines
		INNER JOIN Uplans ON Disciplines.NumDisc = Uplans.Semestr
GO

--3.8 
SELECT DISTINCT Students.NumSt 
	FROM Students
		INNER JOIN Balls ON Students.NumSt = Balls.NumSt AND Balls.Ball > 4
GO

--3.9
Select DISTINCT St.FIO, MIN(B.Ball) From Balls B
	Right Join Students St
	On St.NumSt = B.NumSt
	Group By St.FIO
GO

--3.10
(SELECT FIO, Ball
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt AND Balls.Ball = 4
			GROUP BY FIO, Ball)
				UNION 
					(SELECT FIO, Ball
						FROM Students, Balls
							WHERE Students.NumSt = Balls.NumSt AND Balls.Ball = 5
								GROUP BY FIO, Ball) 
GO

--4.1
SELECT FIO 
	FROM Students
			WHERE EXISTS 
				(SELECT NumSt
					FROM Balls 
						GROUP BY NumSt 
							HAVING COUNT(DISTINCT NumSt) < 2) 
			GROUP BY FIO
GO

--4.2
SELECT FIO
	FROM Students s
			WHERE NOT EXISTS
				(SELECT NumSt
					FROM Balls b 
						WHERE s.NumSt = b.NumSt)
GO

--4.3
SELECT FIO
	FROM Students Stud
		WHERE EXISTS
			(SELECT NumSt	
				FROM Balls Bal, Uplans Up
					WHERE Stud.NumSt = Bal.NumSt AND Bal.Ball > 2 AND Bal.IdDisc = Up.IdDisc AND Semestr = 1 AND Up.NumDisc IN (2, 4))
GO

--4.4
SELECT DISTINCT NumGr, COUNT(NumSt)
	FROM Students Stud
		WHERE NOT EXISTS
			(SELECT NumSt
				FROM Balls Bal
					WHERE Stud.NumSt = Bal.NumSt)
		GROUP BY NumGr
GO

--4.5
SELECT Name 
	FROM Disciplines Dis
		WHERE NOT EXISTS
			(SELECT Up.NumDisc
				FROM Uplans Up 
					WHERE Dis.NumDisc = Up.NumDisc AND Up.NumDir = 231000)
GO

--4.6
SELECT Name
	FROM Disciplines Dis
		WHERE NOT EXISTS
			(SELECT Up.IdDisc
				FROM Uplans Up, Balls Bal
					WHERE Up.NumDisc = Dis.NumDisc AND Up.NumDir = 231000 AND Up.IdDisc = Bal.IdDisc)
GO

--4.7
SELECT NumGr
	FROM Students Stud
		WHERE EXISTS
			(SELECT NumSt
				FROM Uplans Up, Balls Bal
					WHERE Up.NumDisc = 1 AND Bal.NumSt = Stud.NumSt AND Bal.IdDisc = Up.IdDisc)
		GROUP BY Stud.NumGr HAVING COUNT(NumGr) > 4
GO

--4.8 
SELECT NumGr 
	FROM Students Stud
		WHERE EXISTS 
			(SELECT NumSt
				FROM Uplans Up, Balls Bal
					WHERE Up.Semestr = 1 AND Bal.NumSt = Stud.NumSt AND Bal.IdDisc = Up.IdDisc)
		GROUP BY Stud.NumGr HAVING COUNT(NumGr) > 4
GO

--4.9
SELECT FIO
	FROM Students Stud
		WHERE EXISTS
			(SELECT NumSt
				FROM Balls Bal
					WHERE Bal.NumSt = Stud.NumSt AND Bal.Ball > 2
						GROUP BY NumSt HAVING COUNT(Bal.NumSt) > 1)
GO