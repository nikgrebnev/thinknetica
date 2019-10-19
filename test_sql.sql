-- Создайте базу данных test_guru
CREATE DATABASE test_guru;

-- Таблицу categories с атрибутом title
--DROP TABLE categories;
CREATE TABLE categories (
    category_id bigserial PRIMARY KEY,
    title text
);

-- Таблицу tests в которой должны быть атрибуты title, level, внешний ключ к таблице categories
CREATE TABLE tests (
    test_id bigserial PRIMARY KEY,
    title text,
    level smallint,
    category_id bigint REFERENCES categories(category_id)
);
create index tests_i1 on tests(level);
create index tests_i2 on tests(category_id);

-- Таблицу questions в которой должен быть атрибут body и внешний ключ к таблице tests
CREATE TABLE questions (
    question_id bigserial PRIMARY KEY,
    body text,
    test_id bigint REFERENCES tests(test_id)
);
create index questions_i1 on questions(test_id);

-- Создайте 3 строки в таблице categories
insert into categories(title) values 
    ('Профессиональные'),
    ('Психологические'),
    ('Какие-то еще');

-- Создайте 5 строк в таблице tests (хотя бы 3 из них должны иметь отличное от NULL значение в атрибуте внешнего ключа к таблице categories)
insert into tests (title,level,category_id) values
    ('Test 1',1,1),
    ('Test 2',2,2),
    ('Test 3',3,3),
    ('Test 4',3,1),
    ('Test 5',2,2);
    
-- Создайте 5 строк в таблице questions
insert into questions (body,test_id) values 
    ('Question 1',1),
    ('Question 2',2),
    ('Question 3',3),
    ('Question 4',1),
    ('Question 5',2);
    
-- Выберите все тесты с уровнем 2 и 3
select * from tests where level in (2,3);

-- Выберите все вопросы для определённого теста
select * from questions where test_id=1;

-- Обновите атрибуты title и level для строки из таблицы tests с помощью одного запроса
update tests set title = 'Тест 1', level = 3 where test_id=1;

-- Удалите все вопросы для конкретного теста с помощью одного запроса
delete from questions where test_id = 2;

-- С помощью JOIN выберите названия всех тестов и названия их категорий
select t.title,c.title  from tests t, categories c where t.category_id=c.category_id;
select tests.title, categories.title from tests join categories on tests.category_id=categories.category_id;

-- С помощью JOIN выберите содержание всех вопросов (атрибут body) и названия связанных с ними тестов
select q.body, t.title  from questions q, tests t where q.test_id=t.test_id;
select body, title from questions join tests on questions.test_id = tests.test_id;
