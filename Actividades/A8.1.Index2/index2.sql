CREATE INDEX i1 on orderdetails (orderLineNumber);
CREATE INDEX i2 on orderdetails (quantityOrdered, orderLineNumber);
CREATE INDEX i3 on orderdetails (orderLineNumber, quantityOrdered);



EXPLAIN format=json  SELECT * FROM orderdetails force index(i3) WHERE orderLinenumber = 1 and quantityOrdered > 50;
--Sin index: 2996/302.10
--Index 1: 326/29.96
--Index 2: 66/29.96
--Index 3: 5/2.51

EXPLAIN format=json  SELECT productCode FROM orderdetails  force index(i1) WHERE orderLinenumber = 1 and quantityOrdered > 50;
--Sin index: 2996/302.10
--Index 1: 326/29.96
--Index 2: 66/14.24
--Index 3: 5/1.87

EXPLAIN format=json  SELECT orderLineNumber, count(*) FROM orderdetails   force index(i3)  WHERE orderLinenumber = 1 and quantityOrdered > 50 GROUP BY orderLineNumber;
--Sin index: 2996/302.10
--Index 1: 326/29.96
--Index 2: 66/14.24
--Index 3: 5/1.87

EXPLAIN format=json SELECT * from orderdetails
