
/*
ЗАДАЧА: 
- Какую сумму в среднем в месяц тратит:
- пользователи в возрастном диапазоне от 18 до 25 лет включительно
- пользователи в возрастном диапазоне от 26 до 35 лет включительно
*/


-- Решение с привязкой к календарному месяцу. (Не полный месяц влияет на средний показатель)
SELECT AVG(young) AS '18-25',  AVG(adult) AS '26-35'  
FROM (SELECT YEAR(Purchases.`date`) AS yr, 
	     MONTH(Purchases.`date`) as mnth, 
	     SUM(CASE WHEN age BETWEEN 18 AND 25 THEN price ELSE 0 END) AS young,
	     SUM(CASE WHEN age BETWEEN 26 AND 35 THEN price ELSE 0 END) AS adult
      FROM Users INNER JOIN Purchases USING (userId)
		 INNER JOIN Items USING (itemId)
      GROUP BY 1,2) t1
	   
	   
-- Решение без привязки к календарным месяцам (расчитывается средний доход за день в каждой группе и умножается на 30 дней 
SELECT young/cnt_days*30 AS '18-25',  
       adult/cnt_days*30 AS '26-35'  
FROM (SELECT SUM(CASE WHEN age BETWEEN 18 AND 25 THEN price ELSE 0 END) AS young,
	     SUM(CASE WHEN age BETWEEN 26 AND 35 THEN price ELSE 0 END) AS adult,
	     DATEDIFF(MAX(Purchases.`date`), MIN(Purchases.`date`))+1 AS cnt_days 
      FROM Users INNER JOIN Purchases USING (userId)
		 INNER JOIN Items USING (itemId))t1
			     	   
