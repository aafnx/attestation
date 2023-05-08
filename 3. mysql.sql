-- 7. В подключенном MySQL репозитории создать базу данных “Друзья человека”
DROP DATABASE IF EXISTS `human_friends`;
CREATE DATABASE `human_friends`;
USE `human_friends`;

-- 8. Создать таблицы с иерархией из диаграммы в БД
CREATE TABLE Animals (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  birthday DATE NOT NULL
);

CREATE TABLE Pets (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  animal_type VARCHAR(30),
  FOREIGN KEY (id) REFERENCES Animals(id) ON DELETE CASCADE
);

CREATE TABLE Pack_Animals (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  animal_type VARCHAR(30),
  FOREIGN KEY (id) REFERENCES Animals(id) ON DELETE CASCADE
);

CREATE TABLE Dogs (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  commands VARCHAR(30),
  FOREIGN KEY (id) REFERENCES Pets(id) ON DELETE CASCADE
);

CREATE TABLE Cats (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  commands VARCHAR(30),
  FOREIGN KEY (id) REFERENCES Pets(id) ON DELETE CASCADE
);

CREATE TABLE Hamsters (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  commands VARCHAR(30),
  FOREIGN KEY (id) REFERENCES Pets(id) ON DELETE CASCADE
);

CREATE TABLE Horses (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  commands VARCHAR(30),
  FOREIGN KEY (id) REFERENCES Pack_Animals(id) ON DELETE CASCADE
);

CREATE TABLE Camels (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  commands VARCHAR(30),
  FOREIGN KEY (id) REFERENCES Pack_Animals(id) ON DELETE CASCADE
);

CREATE TABLE Donkeys (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  commands VARCHAR(30),
  FOREIGN KEY (id) REFERENCES Pack_Animals(id) ON DELETE CASCADE
);

-- 9. Заполнить низкоуровневые таблицы именами(животных),
-- командами которые они выполняют и датами рождения

INSERT INTO Animals (name, birthday) VALUES
('Murzik', '2021-06-08'),
('Barsik', '2014-02-23'),
('Liza', '2022-05-14'),
('Muni', '2009-01-02'),
('Hatiko', '2008-09-19'),
('Pushok', '2017-03-09'),
('Ananas', '2020-03-04'),
('Bani', '2021-07-28'),
('Batman', '2023-01-01'),
('Rosinant', '2001-04-05'),
('Billi', '2023-07-29'),
('Eclipse', '2010-09-08'),
('Bo', '2005-07-06'),
('Sven', '2002-01-06'),
('Stif', '2006-12-17'),
('Roll', '2013-05-18'),
('Rih', '2011-11-01'),
('Suria', '2015-08-29');

INSERT INTO Pets (id, name, animal_type) VALUES
(1, 'Murzik', 'Cat'),
(2, 'Barsik', 'Cat'),
(3, 'Liza', 'Cat'),
(4, 'Muni', 'Dog'),
(5, 'Hatiko', 'Dog'),
(6, 'Pushok', 'Dog'),
(7, 'Ananas', 'Hamster'),
(8, 'Bani', 'Hamster'),
(9, 'Batman', 'Hamster');

INSERT INTO Pack_Animals (id, name, animal_type) VALUES
(10, 'Rosinant', 'Horse'),
(11, 'Billi', 'Horse'),
(12, 'Eclipse', 'Horse'),
(13, 'Bo', 'Camel'),
(14, 'Sven', 'Camel'),
(15, 'Stif', 'Camel'),
(16, 'Roll', 'Donkey'),
(17, 'Rih', 'Donkey'),
(18, 'Suria', 'Donkey');


INSERT INTO Cats (id, name, commands) VALUES
(1, 'Murzik', 'sleep()'),
(2, 'Barsik', 'mew()'),
(3, 'Liza', 'scratch()');

INSERT INTO	Dogs (id, name, commands) VALUES
(4, 'Muni', 'bark()'),
(5, 'Hatiko', 'wait()'),
(6, 'Pushok', 'guard()');

INSERT INTO Hamsters (id, name, commands) VALUES
(7, 'Ananas', 'eat()'),
(8, 'Bani', 'gnaw()'),
(9, 'Batman', 'run()');

INSERT INTO Horses (id, name, commands) VALUES
(10, 'Rosinant', 'attack()'),
(11, 'Billi', 'gallop()'),
(12, 'Eclipse', 'dance()');

INSERT INTO Camels (id, name, commands) VALUES
(13, 'Bo', 'drink()'),
(14, 'Sven', 'spit()'),
(15, 'Stif', 'go()');

INSERT INTO Donkeys (id, name, commands) VALUES
(16, 'Roll', 'shout()'),
(17, 'Rih', 'carry()'),
(18, 'Suria', 'eat()');



SELECT * FROM Animals, Pets, Cats
WHERE Animals.id = Pets.id AND Pets.id = Cats.id;

SELECT * FROM Animals, Pets, Dogs
WHERE Animals.id = Pets.id AND Pets.id = Dogs.id;

SELECT * FROM Animals, Pets, Hamsters
WHERE Animals.id = Pets.id AND Pets.id = Hamsters.id;

SELECT * FROM Animals, Pack_Animals, Horses
WHERE Animals.id = Pack_Animals.id AND Pack_Animals.id = Horses.id;

SELECT * FROM Animals, Pack_Animals, Camels
WHERE Animals.id = Pack_Animals.id AND Pack_Animals.id = Camels.id;

SELECT * FROM Animals, Pack_Animals, Donkeys
WHERE Animals.id = Pack_Animals.id AND Pack_Animals.id = Donkeys.id;

-- 10. Удалив из таблицы верблюдов, т.к. верблюдов решили
-- перевезти в другой питомник на зимовку.
-- Объединить таблицы лошади, и ослы в одну таблицу.


DELETE FROM Animals
WHERE Animals.id IN (SELECT id FROM Camels);

SELECT * FROM Animals a
	JOIN Pack_Animals pa
		ON a.id = pa.id;


-- 11. Создать новую таблицу “молодые животные”
-- в которую попадут все животные старше 1 года, но младше 3 лет
-- и в отдельном столбце с точностью до месяца подсчитать
-- возраст животных в новой таблице
	
DROP TABLE IF EXISTS `Young_animals`;
CREATE TABLE `Young_animals` (
	SELECT * FROM Animals a
	WHERE TIMESTAMPDIFF(YEAR, a.birthday, CURDATE()) >= 1
		AND TIMESTAMPDIFF(YEAR, a.birthday, CURDATE()) <= 3
	);

SELECT * FROM Young_animals;

-- 12. Объединить все таблицы в одну, при этом сохраняя поля,
-- указывающие на прошлую принадлежность к старым таблицам.

SELECT a.id, a.name, a.birthday, pc.animal_type, an.commands 
		FROM Animals a
	JOIN Pack_Animals pc
		ON pc.id = a.id
	JOIN
		(SELECT pa.id, pa.name, h.commands
			FROM Pack_Animals pa, Horses h
				WHERE pa.id = h.id
		UNION
		SELECT pa.id, pa.name, d.commands
			FROM Pack_Animals pa, Donkeys d
				WHERE pa.id = d.id) an
	ON an.id = a.id
UNION
	SELECT a.id, a.name, a.birthday, pc.animal_type, an.commands 
		FROM Animals a
	JOIN Pets pc
		ON pc.id = a.id
	JOIN
		(SELECT pa.id, pa.name, c.commands
			FROM Pets pa, Cats c
				WHERE pa.id = c.id
		UNION
		SELECT pa.id, pa.name, d.commands
			FROM Pets pa, Dogs d
				WHERE pa.id = d.id
		UNION
		SELECT pa.id, pa.name, h.commands
			FROM Pets pa, Hamsters h
				WHERE pa.id = h.id) an
	ON an.id = a.id;




