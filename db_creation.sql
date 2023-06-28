-- Создание БД
CREATE DATEBASE wib_test;

-- Создание Таблицы с Пользователями
CREATE TABLE Users (
    `userId` INT PRIMARY KEY AUTO_INCREMENT,
    `age` INT
);

-- Создание Хранимой процедуры для заполнения таблицы с Пользователями по заданным параметрам возраста и кол-ва строк
delimiter $$
CREATE PROCEDURE InsertRand2(IN NumRows INT, IN MinVal INT, IN MaxVal INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= NumRows DO
            INSERT INTO wib_test.Users2 (`age`) VALUES (MinVal + CEIL(RAND() * (MaxVal - MinVal)));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END $$
delimiter ;

-- Запуск процедуры для заполнения таблицы с 100 Пользователями в возрасте от 16 до 50 лет
CALL InsertRand(100, 16, 50);


-- Создание Таблицы с Предметами
CREATE TABLE Items (
	`itemId` INT PRIMARY KEY AUTO_INCREMENT, 
	`price`  INT
);

-- Создание Хранимой процедуры для заполнения таблицы с Предметами
delimiter $$
CREATE PROCEDURE InsertRand2(IN NumRows INT, IN MinVal INT, IN MaxVal INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= NumRows DO
            INSERT INTO wib_test.Items (`price`) VALUES (MinVal + CEIL(RAND() * (MaxVal - MinVal)));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END $$
delimiter ;

-- Запуск процедуры для заполнения таблицы с 100 Предметами с ценой от 1000 до 5000
CALL InsertRand2(100, 1000, 5000);


-- Создание Таблицы с Заказами.  
CREATE TABLE Purchases (
	`purchaseId` INT PRIMARY KEY AUTO_INCREMENT, 
	`userId` INT, 
	`itemId` INT, 
	`date` DATE,
  FOREIGN KEY (`userId`) REFERENCES `Users`(`userId`) ON DELETE CASCADE,
  FOREIGN KEY (`itemId`) REFERENCES `Items`(`itemId`) ON DELETE CASCADE				
);

INSERT INTO Purchases (`userId`, `itemId`, `date`)
SELECT userId, itemId, NULL 
FROM Users, Items
ORDER BY RAND()
LIMIT 1000

UPDATE Purchases
SET `date` = DATE_ADD(DATE(NOW()), INTERVAL FLOOR(RAND() * -730) DAY) 

