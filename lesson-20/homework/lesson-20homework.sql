
-- 1. 
SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1 FROM #Sales x
    WHERE x.CustomerName = s.CustomerName
      AND MONTH(x.SaleDate) = 3 AND YEAR(x.SaleDate) = 2024
);

-- 2. 
SELECT TOP 1 Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

-- 3. 
SELECT MAX(TotalAmount) AS SecondHighestSale
FROM (
    SELECT SUM(Quantity * Price) AS TotalAmount
    FROM #Sales
    GROUP BY SaleID
) t
WHERE TotalAmount < (SELECT MAX(SUM(Quantity * Price))
                     FROM #Sales GROUP BY SaleID);

-- 4.
SELECT DATENAME(MONTH, SaleDate) AS MonthName,
       (SELECT SUM(s2.Quantity)
        FROM #Sales s2
        WHERE MONTH(s2.SaleDate) = MONTH(s1.SaleDate)
          AND YEAR(s2.SaleDate) = YEAR(s1.SaleDate)) AS TotalQty
FROM #Sales s1
GROUP BY DATENAME(MONTH, SaleDate), MONTH(SaleDate), YEAR(SaleDate)
ORDER BY MIN(SaleDate);

-- 5. 
SELECT DISTINCT a.CustomerName
FROM #Sales a
WHERE EXISTS (
    SELECT 1 FROM #Sales b
    WHERE a.CustomerName <> b.CustomerName
      AND a.Product = b.Product
);

-- 6. 
SELECT Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

-- 7.
SELECT f1.ParentID AS PID, f2.ChildID AS CHID
FROM Family f1
JOIN Family f2 ON f1.ChildID = f2.ParentID
UNION
SELECT ParentID, ChildID FROM Family
ORDER BY PID, CHID;

-- 8. 
SELECT o.*
FROM #Orders o
WHERE o.DeliveryState = 'TX'
AND EXISTS (
    SELECT 1 FROM #Orders x
    WHERE x.CustomerID = o.CustomerID
      AND x.DeliveryState = 'CA'
);

-- 9. 
UPDATE r
SET fullname = SUBSTRING(address, CHARINDEX('name=', address) + 5,
                         CHARINDEX(' age=', address) - CHARINDEX('name=', address) - 5)
FROM #residents r
WHERE fullname IS NULL
  AND address LIKE '%name=%';

-- 10.
SELECT 'Tashkent - Samarkand - Khorezm' AS Route, 500 AS Cost
UNION ALL
SELECT 'Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm', 650;

-- 11.
SELECT ID, Vals,
       DENSE_RANK() OVER (ORDER BY (SELECT NULL)) AS RankOrder
FROM #RankingPuzzle;

-- 12. 
SELECT e.*
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(x.SalesAmount)
    FROM #EmployeeSales x
    WHERE x.Department = e.Department
);

-- 13. 
SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1 FROM #EmployeeSales x
    WHERE x.SalesMonth = e.SalesMonth
      AND x.SalesAmount = (
          SELECT MAX(SalesAmount)
          FROM #EmployeeSales
          WHERE SalesMonth = e.SalesMonth
      )
      AND x.EmployeeID = e.EmployeeID
);

-- 14.
SELECT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth FROM #EmployeeSales
    WHERE SalesMonth NOT IN (
        SELECT SalesMonth FROM #EmployeeSales x
        WHERE x.EmployeeName = e.EmployeeName
    )
)
GROUP BY e.EmployeeName;

-- 15.
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 16.
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

-- 17. 
SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

-- 18. 
SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);

-- 19. 
SELECT Name
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products x
    WHERE x.Category = p.Category
);
