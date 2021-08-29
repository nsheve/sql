--���������� ������ ��� ������������ ��������
INSERT INTO balance (create_date, debit, credit, amount)
    VALUES (TO_TIMESTAMP('2021-03-02', 'YYYY-MM-DD'),100, 50, 50);
INSERT INTO balance (create_date, debit, credit, amount)
    VALUES (TO_TIMESTAMP('2021-03-03', 'YYYY-MM-DD'),140, 40, 100);

SELECT * FROM balance;

INSERT INTO operetions (article_id, debit, credit, create_date, balance_id)
    VALUES (1, 100, 50, TO_TIMESTAMP('2021-03-02', 'YYYY-MM-DD'), 1);
INSERT INTO operetions (article_id, debit, credit, create_date, balance_id)
    VALUES (2, 140, 40, TO_TIMESTAMP('2021-03-03', 'YYYY-MM-DD'), 2);

SELECT * FROM operetions;

--�������
--������� ������
--������������� �������: ��������� ������ �� �������� ����
SELECT SUM(amount) FROM balance
    WHERE create_date = TO_TIMESTAMP('2021-03-02', 'YYYY-MM-DD');

--������� � �����������: ������� ������������ ���� ������, � ������ ������� �� ����������� �������� �� �������� ������ �������.
SELECT articles.NAME FROM articles
    where (SELECT * FROM operetions 
        where articles_id = artilces.id
            AND create_date BETWEEN TO_TIMESTAMP('2021-03-02', 'YYYY-MM-DD') AND TO_TIMESTAMP('2021-03-03', 'YYYY-MM-DD'));

--C��������� ������(join): ������� �������� � ������������ ������, ������� ������, � ������ ������� �� ����������� ��������.
SELECT operetions.id, articles.NAME FROM operetions
    join articles on operetions.article_id = articles.id
    right outer join articles on operetions.articles_id != articles.id;

--������� ����� ��������, � ������� ������ �������� ������������� ������ � �������� �������������.
SELECT COUNT(balance_id) FROM operetions
    join articles on operetions.article_id = articles.id WHERE articles.NAME = '������';

--������� ����� �������� �� �������� ������, ��������� �� �������������� �������� �� ��������� ������ �������.
SELECT SUM(credit) FROM operetions
    join articles on operetions.articles_id = articles.id 
        where articles.NAME = '������';

--�������� ����� ������
INSERT INTO articles (NAME) VALUES ('������');

--�������� �������� � ������ ������ �� �.1
INSERT INTO operetions (articles_id, debit, credit, create_date, balance_id) 
    VALUES ((SELECT id FROM articles WHERE NAME = '������'), 150, 100, CURRENT_TIMESTAMP, 1);
    
--������������ ������. ���� ����� ������� ������ ��������� ����� - ���������� ��������.
SELECT * FROM balance
    WHERE amount < 25;
ROLLBACK;

--������� ������ � ��������, ����������� � �� ������
DELETE FROM operetions WHERE articles_id = 2;
DELETE FROM articles WHERE id = 2;

--������� � ������ ���������� ����� ��������� �����c
DELETE FROM balance WHERE amount = (SELECT MIN(amount) FROM balance);
COMMIT;

--���� �����, ��, ���� � ��������� ������� �������������� ������, �������� � ������ ������� ������ ����� �� ����������� - ���������� ��������.


--