-- 1.
SELECT r.Region, d.Distributor, ISNULL(s.Sales,0) AS Sales
FROM (SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) d
LEFT JOIN #RegionSales s
ON r.Region = s.Region AND d.Distributor = s.Distributor
ORDER BY d.Distributor, r.Region;

-- 2.
SELECT e1.name
FROM Employee e1
JOIN Employee e2 ON e1.id = e2.managerId
GROUP BY e1.id, e1.name
HAVING COUNT(e2.id) >= 5;

-- 3. 
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE YEAR(o.order_date) = 2020 AND MONTH(o.order_date) = 2
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

-- 4.
SELECT CustomerID, Vendor
FROM (
    SELECT CustomerID, Vendor,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rn
    FROM Orders
    GROUP BY CustomerID, Vendor
) x
WHERE rn = 1;

-- 5.
DECLARE @Check_Prime INT = 91, @i INT = 2, @isPrime BIT = 1;
WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i += 1;
END
IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

-- 6.
WITH LocationCount AS (
    SELECT Device_id, Locations, COUNT(*) AS signal_count
    FROM Device
    GROUP BY Device_id, Locations
),
DeviceAgg AS (
    SELECT Device_id,
           COUNT(DISTINCT Locations) AS no_of_location,
           SUM(signal_count) AS no_of_signals
    FROM LocationCount
    GROUP BY Device_id
)
SELECT da.Device_id,
       da.no_of_location,
       lc.Locations AS max_signal_location,
       da.no_of_signals
FROM DeviceAgg da
JOIN LocationCount lc
  ON da.Device_id = lc.Device_id
  AND lc.signal_count = (
        SELECT MAX(signal_count)
        FROM LocationCount x
        WHERE x.Device_id = lc.Device_id
     );

-- 7. 
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

-- 8. 
WITH WinCount AS (
    SELECT TicketID, COUNT(*) AS matched
    FROM Tickets
    WHERE Number IN (SELECT Number FROM Numbers)
    GROUP BY TicketID
)
SELECT SUM(CASE WHEN matched = (SELECT COUNT(*) FROM Numbers) THEN 100
                WHEN matched > 0 THEN 10 ELSE 0 END) AS Total_Winnings
FROM WinCount;

-- 9. 
WITH PlatformUsage AS (
    SELECT Spend_date, User_id,
           SUM(CASE WHEN Platform='Mobile' THEN Amount ELSE 0 END) AS MobileAmt,
           SUM(CASE WHEN Platform='Desktop' THEN Amount ELSE 0 END) AS DesktopAmt
    FROM Spending
    GROUP BY Spend_date, User_id
)
SELECT ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
       Spend_date, Platform,
       SUM(Total_Amount) AS Total_Amount,
       COUNT(DISTINCT User_id) AS Total_users
FROM (
    SELECT Spend_date, 'Mobile' AS Platform, User_id, MobileAmt AS Total_Amount FROM PlatformUsage WHERE MobileAmt>0
    UNION ALL
    SELECT Spend_date, 'Desktop', User_id, DesktopAmt FROM PlatformUsage WHERE DesktopAmt>0
    UNION ALL
    SELECT Spend_date, 'Both', User_id, MobileAmt+DesktopAmt FROM PlatformUsage WHERE MobileAmt>0 AND DesktopAmt>0
) t
GROUP BY Spend_date, Platform
ORDER BY Spend_date, Platform;

-- 10. 
WITH Expand AS (
    SELECT Product, 1 AS Qty, Quantity AS Remaining
    FROM Grouped
    UNION ALL
    SELECT Product, 1, Remaining - 1
    FROM Expand
    WHERE Remaining > 1
)
SELECT Product, Qty AS Quantity
FROM Expand
ORDER BY Product
OPTION (MAXRECURSION 100);
