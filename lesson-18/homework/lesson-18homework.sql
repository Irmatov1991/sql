--1
SELECT ProductID,
       SUM(Quantity) AS TotalQuantity,
       SUM(Quantity * p.Price) AS TotalRevenue
INTO #MonthlySales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE MONTH(SaleDate) = MONTH(GETDATE())
  AND YEAR(SaleDate) = YEAR(GETDATE())
GROUP BY ProductID;

SELECT * FROM #MonthlySales;


--2
CREATE VIEW vw_ProductSalesSummary AS
SELECT p.ProductID,
       p.ProductName,
       p.Category,
       SUM(s.Quantity) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;


--3
CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10,2);
    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;
    RETURN ISNULL(@TotalRevenue, 0);
END;


--4
CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT p.ProductName,
           SUM(s.Quantity) AS TotalQuantity,
           SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);


--5
CREATE FUNCTION fn_IsPrime(@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2, @isPrime BIT = 1;
    IF @Number < 2 RETURN 'No';
    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END
        SET @i += 1;
    END
    RETURN CASE WHEN @isPrime = 1 THEN 'Yes' ELSE 'No' END;
END;


--6
CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;
    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers VALUES (@i);
        SET @i += 1;
    END
    RETURN;
END;


--7
CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        CASE WHEN COUNT(DISTINCT salary) < @N THEN NULL
             ELSE (
                SELECT DISTINCT salary
                FROM Employee
                ORDER BY salary DESC
                OFFSET (@N - 1) ROWS FETCH NEXT 1 ROWS ONLY
             ) 
        END AS HighestNSalary
);


--8
SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id, accepter_id AS friend
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id, requester_id
    FROM RequestAccepted
) AS all_friends
GROUP BY id
ORDER BY num DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


--9
CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


--10
SELECT RowNumber,
       FIRST_VALUE(TestCase) OVER (ORDER BY RowNumber
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Workflow
FROM Gaps;
