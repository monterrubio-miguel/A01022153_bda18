EXPLAIN
SELECT l.textdescription
FROM products p
INNER JOIN orderDetails od ON p.productCode = od.productCode
INNER JOIN productLine pl ON p.productLine = od.productLine
WHERE p.customerNumber = 112