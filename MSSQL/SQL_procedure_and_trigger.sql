use Kurs
go


--�������� ���������
--���������� ����������
alter Proc insertEmployees
	@Name varchar(40),
	@Surname varchar(40),
	@Otch varchar(40),
	@Date date,
	@Dol varchar(40),
	@Zarplata money,
	@Tel varchar(40),
	@Adres varchar(40),
	@Log varchar(40),
	@Pass varchar(40)
	as
	begin 
	insert into Employees
		(���, �������, ��������, ���������������, ���������, ��������, �������, �����, �����, ������)
			values 
			 (@Name, @Surname, @Otch, @Date, @Dol, @Zarplata, @Tel, @Adres, @Log, @Pass)
	end

--�������� ��������
alter Proc deleteStorehouse @id int as
	begin 
		delete from Storehouse where StorehouseID = @id
		delete from Food where StorehouseID = @id
		delete from Storehouse_PurchasingList where StorehouseID = @id
	end

--����� ������ 
alter proc select_Films @ID int as
	select FilmsInfo.��������, FilmsInfo.������������, Films.�����, Films.����, Films.����_������, Hall.��� from Films
	inner join FilmsInfo on FilmsInfo.FilmsInfoID = Films.FilmsIfoID
	inner join Hall on Hall.HallID = Films.HallID 
		where Films.FilmID = @ID
go

--�������
--�� ������ ���������� ������ � ������� ����
create trigger stoping_Insert_Genre on Genre for insert
	as begin
		if((select GenreID from inserted) > 9) rollback
		end

alter proc checkPassword 
	@Dol varchar(40),
	@Password varchar(40) as
	select * from Employees
		where Employees.��������� = @Dol and Employees.������ = @Password
go

alter proc insertCustomers
	@Name varchar(15),
	@Surname varchar(15),
	@Otche varchar(15),
	@Email varchar(15),
	@Tel varchar(15),
	@Login varchar(15),
	@Password varchar(15) 
	as begin 
	insert into Customers
		(���, �������, ��������, email, �������, �����, ������)
			values 
				(@Name, @Surname, @Otche, @Email, @Tel, @Login, @Password)
	end

alter proc insertActor
	@Name varchar(30),
	@Surname varchar(30),
	@From varchar(30),
	@Date varchar(11)
	as begin
		insert into Actors
			(���, �������, ������, ����_��������)
				values 
					(@Name, @Surname, @From, @Date)
		end

alter proc insertHall 
	@Name varchar(40),
	@Mest int,
	@Rad int
	as begin 
	insert into Hall
		(���, �����_����, �����_�����)
			Values
				(@Name, @Mest, @Rad)
		end

alter proc insertProducer
	@Name varchar(20),
	@Surname varchar(20),
	@Date varchar(11),
	@From varchar(20)
	as begin
		insert into Producer
			(���, �������, ����_��������, ������)
				values 
					(@Name, @Surname, @Date, @From)
		end

alter proc insertStorehouse
	@Name varchar(25),
	@Kol int
	as begin
		insert into Storehouse
			(��������, ����������)
				values
					(@Name, @Kol)
		end

alter proc deleteEmployees
	@ID int
	as begin
		delete from Employees where EmployeeID = @ID
		delete from Orders where EmployeeID = @ID
		end
 
alter proc deleteInfo
	@id int
	as begin
		delete from FilmsInfo where FilmsInfoID = @id
		delete from Films where FilmsIfoID = @id
		end

alter proc deleteListPrice
	@ID int
	as begin
		delete from PurchasingList where PurchasingListID = @ID
		delete from Storehouse_PurchasingList where PurchasingListID = @ID
		end

alter proc deleteMenu
	@ID int
	as begin
		delete from Food where FoodID = @ID
		delete from OrderFood where FoodID = @ID
		end

alter proc deleteSession
	@ID int
	as begin
		delete from Films where FilmID = @ID
		delete from OrderItself where FilmID = @ID
		end

alter proc insertMenu
	@ID int,
	@Name varchar(35),
	@Money money,
	@MoneyCash money,
	@Kol int
	as begin 
		insert into Food
			(StorehouseID, ��������, ����, �������������, ����������)
				values 
					(@ID, @Name, @Money, @MoneyCash, @Kol)
		end

alter proc insertSession
	@IDF int,
	@IDH int,
	@Money int,
	@Kol int,
	@Date date,
	@Time time(0)
	as begin 
		insert into Films
			(FilmsIfoID, HallID, ����_������, ������, ����, �����)
				values 
					(@IDF, @IDH, @Money, @Kol, @Date, @Time)
		end

alter proc insertInfo
	@IDC int,
	@IDG int,
	@IDP int,
	@From varchar(20),
	@Name varchar(25),
	@Date date,
	@Time time(0),
	@Valua float
	as begin
		insert into FilmsInfo
			(MoviesSalesmanID, GenreID, ProducerID, ������, ��������, ����_�������, ������������, ������)
				values
					(@IDC, @IDG, @IDP, @From, @Name, @Date, @Time, @Valua)
		end

alter proc insertListPrice
	@IDS int,
	@Name varchar(25),
	@Kol int
	as begin 
		insert into PurchasingList
			(SupplierID, �����, ����������)
				values 
					(@IDS, @Name, @Kol)
		end