/* 
ЗАДАЧА 
Найти топ-3 товаров по выручке и их доля в общей выручке за любой год 

Найду топ-3 за 2022. 
Решение с использованием переменной и оконной функции ранжирования.
Если какие-то товары наберут одинаковую сумму продаж в топе, то они также попадут в топ.
*/


SET @total := (SELECT SUM(price) 
			   FROM Purchases INNER JOIN Items USING (itemId) 
		       WHERE YEAR(Purchases.`date`) = 2022)


SELECT itemId, summa, summa/@total*100 AS part, rnk
FROM (SELECT itemId, SUM(price) as summa, RANK() OVER (ORDER BY SUM(price)) AS rnk
	  FROM Purchases INNER JOIN Items USING(itemID)
	  WHERE YEAR(Purchases.`date`) = 2022
	  GROUP BY itemId) t1
WHERE rnk <= 3
		
		

