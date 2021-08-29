alter procedure addUsers
	@login varchar(50),
	@password varchar(50)
	as
	begin
	insert into Users
		(login, password)
			values 
				(@login, @password)
end

alter proc addArticles
	@name varchar(50)
	as
	begin
	insert into Articles
		(name)
			values
				(@name)
end

alter proc addBalance
	@date varchar(50),
	@debit int,
	@credit int,
	@amount int
	as 
	begin
		insert into Balance
			(create_date, debit, credit, amount)
				values
					(@date, @debit, @credit, @amount)
	end

alter proc addOperations
	@IDA int,
	@debit int,
	@credit int,
	@date varchar(50),
	@IDB int
	as
	begin
		insert into Operations
			(article_id, debit, credit, create_date, balance_id)
				values 
					(@IDA, @debit, @credit, @date, @IDB)
		update Balance
		set debit = (select SUM(debit) from Operations where balance_id = @IDB),
		credit = (select sum(credit) from Operations where balance_id = @IDB),
		amount = debit - credit 
		--where Id in (select  balance_id from Operations where article_id = @IDA) 
end

alter proc deleteArticles
	@id int 
		as begin
			delete from Operations where article_id = @id
			delete from Articles where Id = @id
end

alter proc deleteBalance
	@id int
		as begin 
			delete from Operations where balance_id = @id
			delete from Balance where Id = @id
end

create proc deleteOperations
	@id int
		as begin
			delete from Operations where ID = @id
end

