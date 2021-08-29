USE Kurs
GO

--Вывести всех режесеров и фильмы, которые они сняли 
select Название, Имя, Фамилия from Producer
	left join FilmsInfo on FilmsInfo.ProducerID = Producer.ProducerID
		order by Название
go

--Вывести фильмы одного жанра и подсчитывающий общее число фильмов данного жанра
select Жанр, Название, count(Название) from FilmsInfo
	inner join Genre on Genre.GenreID = FilmsInfo.GenreID
		group by Название, Жанр
go

--Вывести сеансы в больших залах 
select Название, Цена_билета, Дата, Время from Films
	inner join FilmsInfo on FilmsInfo.FilmsInfoID = Films.FilmsIfoID
		where exists(select * from Hall where Hall.HallID = Films.HallID and Hall.Всего_мест > '40')
go

--Вывести всех актеров и режисеров из США
select Имя, Фамилия, Дата_рождения, Страна from Producer
	where Producer.Страна = 'США'
Union 
	(select Имя, Фамилия, Дата_рождения, Страна from Actors
		where Actors.Страна = 'США')
go

--Вывести того чего нет на скалде, но есть в прай-листе
select Товар from PurchasingList
	except
		select Название from Storehouse
go

--Сотрудники которые являются клиентами
select Имя, Фамилия, Отчество from Employees
intersect 
select Имя, Фамилия, Отчество from Customers
go

--Фильм на который купили билетов
select distinct Название from FilmsInfo
	join Films on Films.FilmsIfoID = FilmsInfo.FilmsInfoID
		where exists(select * from OrderItself where OrderItself.FilmID = Films.FilmID)
go 

--Клиент который не покупал билеты на фильм
select Имя, Фамилия, Отчество from Customers
	where Customers.CustomerID not in 
		(select Orders.CustomerID from Orders)
go

--Поставщики которые представлены в прайс-листе
select * from Supplier
	where SupplierID in
		(select SupplierID from PurchasingList)
go 

--Вывести ID жанров про которых нет фильмов
select GenreID from Genre
except 
select GenreID from FilmsInfo
go