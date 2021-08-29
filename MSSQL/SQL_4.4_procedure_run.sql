USE MySession
GO

--1
--EXEC Count_Students
--GO

--2
--EXEC Count_Students_Sem 1

--OR

--DECLARE @kol int;
--SET @kol=1;
--EXEC Count_Students_Sem @kol;

--3.1
--EXEC List_Students_Dir 230100, 'Физика'

--OR

--DECLARE @dir int, @title varchar(30);
--SET @dir = 230100;
--SET @title = 'Физика';
--EXEC List_Students_Dir @dir,@title;

--3.2
--DECLARE @Stud VARCHAR(60), @Group varchar(30);
--SET @Stud='Светлова Вероника';
--SET @Group ='53504/3';
--EXEC Enter_Students @Stud, @Group;

--AND

--DECLARE @Stud VARCHAR(60), @Group varchar(30);
--SET @Stud='Новая Наталья';
--SET @Group ='53504/3';
--EXEC Enter_Students @Stud, @Group;

--4.
--DECLARE @Group VARCHAR(10);
--SET @Group='13504/3';
--EXEC Next_Course @Group;
--GO
 
 --AND 

--EXEC Next_Course;
--GO

--ОБРАТНО
--DECLARE @Group VARCHAR(10);
--SET @Group='23504/3';
--EXEC Back_Course @Group;
--GO

--5.
--DECLARE @Group int;
--EXEC Number_Groups 230100, @Group OUTPUT;
--SELECT @Group;
--GO

--6.
EXEC Delete_Students_Complete;
UPDATE Students SET NumGr=CONVERT(char(1),CONVERT(int, LEFT(NumGr,1))+1)+ SUBSTRING(NumGr,2,LEN(NumGr)-1)
WHERE NumSt IN (SELECT NumSt FROM Students_complete_2);
GO

--ОБРАТНО