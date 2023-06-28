/* 
 ЗАДАЧА: 
 в каком месяце года выручка от пользователей в возрастном диапазоне 35+ самая большая


ВАРИАНТ РЕШЕНИЯ: 
Если есть данные за несколько лет, то сумма дохода за месяц СЧИТАЮ КАК СРЕДНЕЕ от доходов в этот месяц в разные годы. 
Скрипт УЧИТЫВАЕТ, что суммы могут быть одинаковыми для нескольких месяцев. В таком случае будут выведены все такие месяца.
*/

WITH monthly_info AS (
	SELECT mnth, AVG(revenue) AS mon_avg_rev 
	FROM (SELECT YEAR(Purchases.`date`) AS yr, MONTHNAME(Purchases.`date`) as mnth, SUM(price) AS revenue	   
	      FROM Users INNER JOIN Purchases USING (userId)
		  	 INNER JOIN Items USING (itemId)	   
	      WHERE age >= 35
	      GROUP BY 1,2) t1 
	GROUP BY 1)

SELECT mnth AS best_month
FROM monthly_info
WHERE mon_avg_rev = (SELECT MAX(mon_avg_rev) FROM monthly_info)





