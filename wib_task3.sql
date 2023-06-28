/* ЗАДАЧА В) какой товар обеспечивает дает наибольший вклад в выручку за последний год */


/* Вариант 1. Для текущего календарного года.
 * На случай, если есть несколько товаров с одинаковым доходом скрипт выведет все такие товары */

WITH item_rev AS 
	(SELECT itemId, SUM(price) AS revenue	   
	FROM Purchases INNER JOIN Items USING (itemId)	   
	WHERE YEAR(Purchases.`date`) = YEAR(NOW())
	GROUP BY itemId)

SELECT itemId
FROM item_rev
WHERE revenue = (SELECT MAX(revenue) FROM item_rev)


/* Вариант 2. За прошедшие 365 дней.
 * На случай, если есть несколько товаров с одинаковым доходом скрипт выведет все такие товары */

WITH item_rev AS 
	(SELECT itemId, SUM(price) AS revenue	   
	 FROM Purchases INNER JOIN Items USING (itemId)	   
	 WHERE Purchases.`date` >= DATE_SUB(NOW(), INTERVAL(365) DAY) 
	 GROUP BY itemId)

SELECT itemId AS 'Bestseller'
FROM item_rev
WHERE revenue = (SELECT MAX(revenue) FROM item_rev)

