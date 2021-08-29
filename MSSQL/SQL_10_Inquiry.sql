USE Kurs
GO

--������� ���� ��������� � ������, ������� ��� ����� 
select ��������, ���, ������� from Producer
	left join FilmsInfo on FilmsInfo.ProducerID = Producer.ProducerID
		order by ��������
go

--������� ������ ������ ����� � �������������� ����� ����� ������� ������� �����
select ����, ��������, count(��������) from FilmsInfo
	inner join Genre on Genre.GenreID = FilmsInfo.GenreID
		group by ��������, ����
go

--������� ������ � ������� ����� 
select ��������, ����_������, ����, ����� from Films
	inner join FilmsInfo on FilmsInfo.FilmsInfoID = Films.FilmsIfoID
		where exists(select * from Hall where Hall.HallID = Films.HallID and Hall.�����_���� > '40')
go

--������� ���� ������� � ��������� �� ���
select ���, �������, ����_��������, ������ from Producer
	where Producer.������ = '���'
Union 
	(select ���, �������, ����_��������, ������ from Actors
		where Actors.������ = '���')
go

--������� ���� ���� ��� �� ������, �� ���� � ����-�����
select ����� from PurchasingList
	except
		select �������� from Storehouse
go

--���������� ������� �������� ���������
select ���, �������, �������� from Employees
intersect 
select ���, �������, �������� from Customers
go

--����� �� ������� ������ �������
select distinct �������� from FilmsInfo
	join Films on Films.FilmsIfoID = FilmsInfo.FilmsInfoID
		where exists(select * from OrderItself where OrderItself.FilmID = Films.FilmID)
go 

--������ ������� �� ������� ������ �� �����
select ���, �������, �������� from Customers
	where Customers.CustomerID not in 
		(select Orders.CustomerID from Orders)
go

--���������� ������� ������������ � �����-�����
select * from Supplier
	where SupplierID in
		(select SupplierID from PurchasingList)
go 

--������� ID ������ ��� ������� ��� �������
select GenreID from Genre
except 
select GenreID from FilmsInfo
go