USE MySession
GO

--3.1 Направления подготовки 
SELECT Title 
	FROM Directions
GO

--3.2 Номера групп по направлениям подготовки 
SELECT NumGr 
	FROM Groups, Directions 
		WHERE Groups.NumDir = Directions.NumDir
GO

--3.3 ФИО студентов
SELECT FIO 
	FROM Students 
GO

--3.4 Получили оценки студенты
SELECT DISTINCT Students.NumSt, Students.FIO, Balls.Ball 
	FROM Students, Balls 
		WHERE (Balls.Ball) > 0 AND Students.NumSt = Balls.NumSt
GO

--3.5 с DISTINCT Включены в учебный план 
SELECT DISTINCT Uplans.NumDir 
	FROM Uplans
GO

--3.5 без DISTINCT Включены в учебный план 
SELECT Uplans.NumDir 
	FROM Uplans, Directions 
		WHERE Uplans.NumDir = Directions.NumDir 
			GROUP BY Uplans.NumDir 
				HAVING COUNT(Uplans.NumDir) > 1
GO

--3.6 Семестры
SELECT DISTINCT Semestr 
	FROM Uplans
GO

--3.7 Студенты 13504/1
SELECT FIO, NumGr 
	FROM Students 
		WHERE Students.NumGr = '13504/1'
GO

--3.8 Направления для студентов 13504/1 и 1 семестра
SELECT DISTINCT NAME 
	FROM Disciplines, Uplans, Directions 
		WHERE Uplans.Semestr = '1' AND Directions.NumDir = '230100' AND Uplans.NumDisc = Disciplines.NumDisc
GO

--3.9 Номера групп с кол-во студентов 
SELECT NumGr, COUNT(NumSt) 
	FROM Students 
		GROUP BY NumGr 
GO

--3.10 Студенты сдавшие экз
SELECT Students.NumGr, COUNT(DISTINCT Balls.NumSt) 
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt
			GROUP BY Students.NumGr
GO

--3.11 Студенты сдавшие > 1 экз
SELECT NumGr, COUNT(DISTINCT Balls.NumSt)
	FROM Balls, Students
		WHERE Balls.NumSt = Students.NumSt AND Balls.NumSt IN (SELECT Balls.NumSt FROM Balls GROUP BY Balls.NumSt HAVING count(*)>1) 
			GROUP BY NumGr 
GO

--4.1 ФИО студентов, сдавшие экз
SELECT DISTINCT FIO 
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt
GO

--4.2 Названия дисциплин, по которым студенты сдавали экзамен 
SELECT DISTINCT NAME 
	FROM Disciplines, Uplans, Balls
		WHERE Balls.IdDisc = Uplans.IdDisc AND Uplans.NumDisc = Disciplines.NumDisc
GO

--4.3 Названия дисциплин, направления 230100
SELECT DISTINCT NAME 
	FROM Disciplines, Uplans
		WHERE Disciplines.NumDisc = Uplans.NumDisc AND Uplans.NumDir = 230100
GO

--4.4 ФИО, которые сдали > 1 экз
SELECT FIO
	FROM Balls, Students
		WHERE Balls.NumSt = Students.NumSt AND Balls.NumSt IN 
			(SELECT Balls.NumSt 
				FROM Balls 
					GROUP BY Balls.NumSt 
						HAVING count(*) > 1) 
			GROUP BY FIO
GO

--4.5 ФИО, получившие мин. балл
SELECT FIO, Ball
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt AND Balls.Ball = 3
GO

--4.6 ФИО, получившие макс. балл
SELECT DISTINCT FIO, Ball, COUNT(Ball)
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt AND Balls.Ball = 5
			GROUP BY FIO, Ball
GO

--4.7 Номера групп, где есть > 1 студента сдавшего экзамен по Физике в 1 семестре....
SELECT NumGr, FIO, Ball
	FROM Students, Balls, Disciplines, Uplans
		WHERE Students.NumSt = Balls.NumSt AND Balls.IdDisc = Uplans.IdDisc AND Uplans.NumDisc = Disciplines.NumDisc AND Uplans.Semestr = 1
			GROUP BY NumGr, FIO, Ball 
GO

--4.8 ФИО, где сумма балов > 9
SELECT FIO, SUM(Ball) 
	FROM Students, Balls
		WHERE Students.NumSt = Balls.NumSt
			GROUP BY FIO HAVING SUM(Ball) > 9
GO

--4.9 Семестры, по которым сдавших экз > 1
SELECT Semestr, COUNT(*)
	FROM Uplans, Balls
		WHERE Balls.IdDisc = Uplans.IdDisc
			GROUP BY Semestr HAVING COUNT(*) > 1
GO

--4.10 ФИО, сдавших более 1 предмета    ЧЕМ ЭТО ОТЛИЧАЕТСЯ ОТ 4.4??????
SELECT FIO
	FROM Balls, Students, Disciplines, Uplans
		WHERE Balls.NumSt = Students.NumSt AND Disciplines.NumDisc = Uplans.NumDisc AND Uplans.IdDisc = Balls.IdDisc 
			--(SELECT Balls.NumSt 
			--	FROM Balls 
			--		GROUP BY Balls.NumSt 
			--			HAVING count(*) > 1) 
			GROUP BY FIO HAVING COUNT(DISTINCT Uplans.NumDisc) > 1
GO
