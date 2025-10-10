-- 1. 
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < 1000
)
SELECT * FROM Numbers
OPTION (MAXRECURSION 1000);

-- 2. 
SELECT e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID;

-- 3.
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT * FROM AvgSalary;

-- 4. 
SELECT p.ProductID, p.ProductName, ds.MaxSale
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) ds ON p.ProductID = ds.ProductID;

-- 5. 
WITH Doubles AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n * 2 FROM Doubles WHERE n * 2 < 1000000
)
SELECT * FROM Doubles
OPTION (MAXRECURSION 100);

-- 6. 
WITH EmpSales AS (
    SELECT EmployeeID, COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT e.FirstName, e.LastName, s.SaleCount
FROM Employees e
JOIN EmpSales s ON e.EmployeeID = s.EmployeeID
WHERE s.SaleCount > 5;

-- 7. 
WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;

-- 8. 
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT e.*
FROM Employees e, AvgSalary a
WHERE e.Salary > a.AvgSal;

-- 9. 
SELECT TOP 5 e.FirstName, e.LastName, d.OrderCount
FROM Employees e
JOIN (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) d ON e.EmployeeID = d.EmployeeID
ORDER BY d.OrderCount DESC;

-- 10.
SELECT p.CategoryID, SUM(s.SalesAmount) AS TotalCategorySales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.CategoryID;

-- 11. 
WITH Factorial AS (
    SELECT Number, Number AS Current, 1 AS Result
    FROM Numbers1
    UNION ALL
    SELECT f.Number, f.Current - 1, f.Result * f.Current
    FROM Factorial f
    WHERE f.Current > 1
)
SELECT Number, MAX(Result) AS Factorial
FROM Factorial
GROUP BY Number
OPTION (MAXRECURSION 100);

-- 12. 
WITH Split AS (
    SELECT Id, LEFT(String,1) AS CharPart, SUBSTRING(String,2,LEN(String)) AS Remaining
    FROM Example
    UNION ALL
    SELECT Id, LEFT(Remaining,1), SUBSTRING(Remaining,2,LEN(Remaining))
    FROM Split
    WHERE LEN(Remaining) > 0
)
SELECT Id, CharPart
FROM Split
WHERE CharPart IS NOT NULL
OPTION (MAXRECURSION 100);

-- 13.
WITH MonthlySales AS (
    SELECT FORMAT(SaleDate, 'yyyy-MM') AS Month, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
Diff AS (
    SELECT Month, TotalSales - LAG(TotalSales) OVER (ORDER BY Month) AS DiffFromPrev
    FROM MonthlySales
)
SELECT * FROM Diff;

-- 14. 
WITH QuarterlySales AS (
    SELECT EmployeeID, DATEPART(QUARTER, SaleDate) AS QuarterNum, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
)
SELECT e.FirstName, e.LastName, q.QuarterNum, q.TotalSales
FROM Employees e
JOIN QuarterlySales q ON e.EmployeeID = q.EmployeeID
WHERE q.TotalSales > 45000;

-- 15. 
WITH Fibonacci AS (
    SELECT 1 AS n, 0 AS a, 1 AS b
    UNION ALL
    SELECT n + 1, b, a + b FROM Fibonacci WHERE n < 20
)
SELECT n, a AS FibonacciNumber
FROM Fibonacci
OPTION (MAXRECURSION 0);

-- 16. 
SELECT *
FROM FindSameCharacters
WHERE LEN(Vals) > 1 AND Vals NOT LIKE '%[^' + LEFT(Vals,1) + ']%';

-- 17. 
WITH NumSeq AS (
    SELECT CAST('1' AS VARCHAR(50)) AS seq, 1 AS n
    UNION ALL
    SELECT seq + CAST(n+1 AS VARCHAR(10)), n + 1
    FROM NumSeq
    WHERE n < 5
)
SELECT * FROM NumSeq
OPTION (MAXRECURSION 10);

-- 18.
WITH Last6Months AS (
    SELECT * FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
),
EmpSales AS (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Last6Months
    GROUP BY EmployeeID
)
SELECT TOP 1 e.FirstName, e.LastName, es.TotalSales
FROM Employees e
JOIN EmpSales es ON e.EmployeeID = es.EmployeeID
ORDER BY es.TotalSales DESC;

-- 19. 
UPDATE RemoveDuplicateIntsFromNames
SET Pawan_slug_name = (
    SELECT STRING_AGG(val,'')
    FROM (
        SELECT DISTINCT value AS val
        FROM STRING_SPLIT(Pawan_slug_name,'')
        WHERE ISNUMERIC(value)=0
    ) AS t
);
