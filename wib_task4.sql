/* 
ЗАДАЧА 
Найти топ-3 товаров по выручке и их доля в общей выручке за любой год 

Найду топ-3 за 2022. 
Решение с оконной функцией ранжирования.
Если какие-то товары наберут одинаковую сумму продаж в топе, то они также попадут в топ.
*/



SELECT rnk, itemId, summa, 
       summa * 100 / (SELECT SUM(price) 
					  FROM Purchases INNER JOIN Items USING (itemId) 
		       	      WHERE YEAR(Purchases.`date`) = 2022) AS part 
	   
FROM (SELECT itemId, SUM(price) as summa, RANK() OVER (ORDER BY SUM(price) DESC) AS rnk
	  FROM Purchases INNER JOIN Items USING(itemID)
	  WHERE YEAR(Purchases.`date`) = 2022
	  GROUP BY itemId) t1
WHERE rnk <= 3

