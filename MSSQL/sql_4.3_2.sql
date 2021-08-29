use MySession
GO

--всех студентов с баллами + студенты без баллов
--SELECT DISTINCT Students.FIO, MIN(Balls.Ball) 
--	FROM Balls 
--		Right Join Students	On Students.NumSt = Balls.NumSt
--			GROUP BY Students.FIO
--GO

--4.3 Выбрать группы, в которых есть студенты, сдавшие все экзамены 1 семестра
--SELECT Groups.NumGr, COUNT(Groups.NumGr)
--	FROM Groups INNER JOIN Students ON Groups.NumGr = Students.NumGr
--		WHERE NOT EXISTS (SELECT * FROM Uplans WHERE Semestr = 1 AND Groups.NumDir = Uplans.NumDir AND 
--		NOT EXISTS (SELECT * FROM Balls WHERE Balls.IdDisc = Uplans.IdDisc and Students.NumSt = Balls.NumSt) )  
--				GROUP BY Groups.NumGr

--SELECT *
--	FROM Students JOIN Groups ON Groups.NumGr=Students.NumGr
--		WHERE NOT EXISTS (SELECT * FROM Uplans WHERE Semestr=1 AND Groups.NumDir=Uplans.NumDir AND 
--			NOT EXISTS (SELECT * FROM Balls WHERE Balls.IdDisc=Uplans.IdDisc and Students.NumSt=Balls.NumSt) )

SELECT DISTINCT Students.FIO, Students.NumSt from Students
		where not exists(
			SELECT * FROM Uplans
				join Balls on Uplans.IdDisc = Balls.IdDisc
					where Semestr = 1 and Balls.NumSt = Students.NumSt)
GO

SELECT * FROM Students 
	where NumSt not in
(SELECT Students.NumSt FROM Uplans
	JOIN Balls on Uplans.IdDisc = Balls.IdDisc
	JOIN Students on Balls.NumSt = Students.NumSt
		where Semestr = 1)