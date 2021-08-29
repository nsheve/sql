--добавление данных для тестирования запросов
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

--ЗАПРОСЫ
--Выборка данных
--Однотабличная выборка: Посчитать прибль за заданную дату
SELECT SUM(amount) FROM balance
    WHERE create_date = TO_TIMESTAMP('2021-03-02', 'YYYY-MM-DD');

--Выборка с подзапросом: Вывести наименования всех статей, в рамках которых не проводилось операций за заданный период времени.
SELECT articles.NAME FROM articles
    where (SELECT * FROM operetions 
        where articles_id = artilces.id
            AND create_date BETWEEN TO_TIMESTAMP('2021-03-02', 'YYYY-MM-DD') AND TO_TIMESTAMP('2021-03-03', 'YYYY-MM-DD'));

--Cоединение таблиц(join): Вывести операции и наименования статей, включая статьи, в рамках которых не проводились операции.
SELECT operetions.id, articles.NAME FROM operetions
    join articles on operetions.article_id = articles.id
    right outer join articles on operetions.articles_id != articles.id;

--Вывести число балансов, в которых учтены операции принадлежащие статье с заданным наименованием.
SELECT COUNT(balance_id) FROM operetions
    join articles on operetions.article_id = articles.id WHERE articles.NAME = 'Одежда';

--Вывести сумму расходов по заданной статье, агрегируя по сформированным балансам за указанный период времени.
SELECT SUM(credit) FROM operetions
    join articles on operetions.articles_id = articles.id 
        where articles.NAME = 'Одежда';

--Добавить новую статью
INSERT INTO articles (NAME) VALUES ('Одежда');

--Добавить операцию в рамках статьи из п.1
INSERT INTO operetions (articles_id, debit, credit, create_date, balance_id) 
    VALUES ((SELECT id FROM articles WHERE NAME = 'Одежда'), 150, 100, CURRENT_TIMESTAMP, 1);
    
--Сформировать баланс. Если сумма прибыли меньше некоторой суммы - транзакцию откатить.
SELECT * FROM balance
    WHERE amount < 25;
ROLLBACK;

--Удалить статью и операции, выполненные в ее рамках
DELETE FROM operetions WHERE articles_id = 2;
DELETE FROM articles WHERE id = 2;

--Удалить в рамках транзакции самый убыточный баланc
DELETE FROM balance WHERE amount = (SELECT MIN(amount) FROM balance);
COMMIT;

--Тоже самое, но, если в удаленном балансе использовались статьи, операции в рамках которых больше нигде не проводились - транзакцию откатить.


--