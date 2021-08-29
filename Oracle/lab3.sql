--�������������
--������� �������������, ������������ ��� ������ � ����� ������/������
--���������� ��������.
create or replace view summaandarticles as
select sum(debit), sum(credit), articles_id from operetions where balance_id is null group by article_id;

select * from summaandarticlest;

--������� �������������, ������������ ��� ������� � ����� ��������, ��
--��������� ������� ��� ���� ������������.

create or replace view balanceandoper as
select balance.id, sum(case when balance.id = operetions.balance_id) from balance left join operetions on operetions.balance_id = balance.id group by balance.id;

select * from balanceandoper;

--��
--������� �������� ���������, ��������� ��� �������� ���������� �������
--� ������� �� ������.

set serveroutput on

create or replace procedure operetionsNextBalance is
cursor operBal (n in number) is
select operetions.id, debit-credit from operetions where operetions.balance_id = n;
numberC number(10);
numberB char(10);

begin

select max(id) into n from balance;
open operBal(numberC);
loop fetch c1 into v;
exit when c1%notfound;
select articles.name into numberB from articles where articles.id = v.article_id;
dbms_output.put_line(numberB || debit-credit);
end loop;
end;

exec p1;


--������� �������� ���������, ������� ��� ��������� �������1� �
--�������2�. ��� ������ ���������� �������, �������� �� �������1� �
--������� ��������� ������� �������, ��� �� �������2�. ���� � �������
--����������� �������� �� ����� �� ������ � �� �� ���������������.


create or replace procedure p2 (a1 in varchar, a2 in varchar) as

cursor c1 (aa1 in varchar, aa2 in varchar) is (select t1.balance_id from (select balance_id, article_id, sum(debit-credit) as s1 from operetions where balance_id
is not null and article_id in (select articles.id from articles where articles.name = aa1)
group by balance_id, article_id) t1 inner join (select balance_id, article_id, sum(debit-credit) as s2 from operetions where balance_id
is not null and article_id in (select articles.id from articles where articles.name = aa2)
group by balance_id, article_id) t2 on t1.balance_id = t2.balance_id where (t1.s1 - t2.s2) >=0);
v c1%rowtype;
begin
dbms_output.enable;
open c1(a1, a2);
loop fetch c1 into v;
exit when c1%notfound;
dbms_output.put_line(v.balance_id);
end loop;
end;


exec p2('dd','ss');

--������� �������� ��������� � ������� ���������� ������� � ��������
--���������� � ������, �������� �� ������� ��������� � �����������
--���������.
create or replace procedure p3 (a1 in number, a2 out number) as

begin
select min(article_id) into a2 from operetions where balance_id = a1 group by article_id having
sum(credit) = (select max (s) from (select article_id, sum(credit) as s from operetions where balance_id = a1 group by article_id));
end;


declare
n number(10);
begin
p3(21,n);
dbms_output.enable;
dbms_output.put_line(n);
end;

--��������
--������� �������, ������� �� ��������� ������� ������ � ������� ��������
--� �������� ��� ���������� �����.

create or replace trigger tbalance1 before insert on balance
for each row
begin
if (:new.create_date is null) then raise_application_error (-20000, 'Date cannot be null'); end if;
if (:new.credit = 0 and :new.debit = 0) then raise_application_error (-20001, 'Credit and debit cannot both be 0'); end if;
end;


--�������� �� �����������
--������� �������, ������� �� ��������� �������� ��������, ������� ������
--� �������.

create  trigger toperations2 on Operations for update
for each row
begin
if (select * from Operations where balance_id =  not null) 
end

--�������� �� ��������:
--������� �������, ������� ��� �������� ��������, ���� ��� ������ � �������
--���������� ����������.

create or replace trigger toperations3 before delete on operetions
for each row
begin
if (:old.balance_id is not null) then raise_application_error (-20003, 'Cannot delete the operations if it is in a balance'); end if;
end;










--��. ��. ��� ������� ����������� ����������� ���������� ������� �� �������:
--�������� ����������� ��������� �������� �������� �������, ���������
--������������� ������ � ��� ������� ��� ������� (������, ������, �������). �����������
--������ ��������� ������ ������� �������, ���������� �������������� ������ �
--������� ��������, ������������� ���� ������ �������� �������������� ���� �������.
--������������ ��������� �������� ����������. �������� ���������� � ���������
--���������� ������������ ����� ���������� ������� ��������� ���� �������� ��������,
--�������� � �������� ��������. �����, ���������� ������ �� �������, ��������������
--������� �������� � ���������. � ���� ������� ��� ������ ������ ������������ �������
--�������� �� ������ � �������� ���.

create or replace procedure pextra (time1 in date, time2 in date, st1 in number, st2 in number, st3 in number, type in number) as

summ number(10);
smallsumm number(10);

cursor c1 (stc1 in number, stc2 in number, stc3 in number) is (select id from articles where id = stc1 or id = stc2 or id = stc3);
v c1%rowtype;

begin

select sum(decode(type, 1, debit, 2, credit, 3, amount)) into summ from balance where balance.create_date between time1 and time2;

dbms_output.enable;
open c1(st1, st2, st3);
loop fetch c1 into v;
exit when c1%notfound;
select sum(decode(type, 1, operations.debit, 2, operations.credit, 3, operations.debit - operations.credit))
into smallsumm from operations inner join balance on balance.id = balance_id
where balance.create_date between time1 and time2 and article_id = v.id;
dbms_output.put_line(v.id || ' ' || round(nvl(smallsumm, 0)/nvl(summ, 1)*100, 3));
end loop;

end;


exec pextra(sysdate - 100, sysdate, 61, 62, 81, 3);