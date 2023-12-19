INSERT INTO Users (Name) VALUES
('John Doe'),
('Jane Smith'),
('Bob Johnson'),
('Alice Brown'),
('Charlie Davis'),
('Emily White'),
('David Wilson'),
('Eva Miller'),
('Frank Martin'),
('Grace Moore');

INSERT INTO Products (Name, Price) VALUES
('Laptop', 1200.00),
('Smartphone', 800.00),
('Tablet', 400.00),
('Headphones', 100.00),
('Mouse', 20.00),
('Keyboard', 50.00),
('Printer', 150.00),
('Monitor', 300.00),
('Camera', 700.00),
('Speakers', 120.00);

INSERT INTO Orders (UserID, OrderDate) VALUES
(1, '2023-01-10'),
(1, '2023-02-15'),
(2, '2023-01-12'),
(2, '2023-02-20'),
(3, '2023-02-05'),
(4, '2023-01-25'),
(4, '2023-02-28'),
(5, '2023-02-10'),
(6, '2023-02-15'),
(7, '2023-01-20');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 2),
(3, 6, 1),
(4, 5, 4),
(5, 8, 1),
(6, 7, 2),
(6, 9, 1),
(7, 10, 3),
(8, 2, 1),
(8, 4, 2),
(9, 1, 1),
(9, 5, 2),
(9, 7, 1),
(10, 3, 2),
(10, 8, 1);

-- 1
SELECT U.Name AS UserName, COUNT(OD.Id) AS TotalProducts, SUM(P.Price * OD.Quantity) AS TotalAmount
FROM Users U
JOIN Orders O ON U.Id = O.UserID
JOIN OrderDetails OD ON O.Id = OD.OrderID
JOIN Products P ON OD.ProductID = P.Id
GROUP BY U.Name;

-- 2
SELECT O.Id AS OrderID, SUM(P.Price * OD.Quantity) AS TotalAmount
FROM Orders O
JOIN OrderDetails OD ON O.Id = OD.OrderID
JOIN Products P ON OD.ProductID = P.Id
GROUP BY O.Id;

-- 3
SELECT U.Name AS UserName, AVG(P.Price * OD.Quantity) AS AverageCheck
FROM Users U
JOIN Orders O ON U.Id = O.UserID
JOIN OrderDetails OD ON O.Id = OD.OrderID
JOIN Products P ON OD.ProductID = P.Id
GROUP BY U.Name;

-- 4
SELECT O.Id AS OrderID, P.Name AS MostExpensiveProduct
FROM Orders O
JOIN OrderDetails OD ON O.Id = OD.OrderID
JOIN Products P ON OD.ProductID = P.Id
WHERE P.Price = (SELECT MAX(Price) FROM Products WHERE Id = OD.ProductID);

-- 5
SELECT COUNT(Id) AS TotalOrders
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-01-31';

-- 6
SELECT P.Name AS ProductName, SUM(OD.Quantity) AS TotalOrders
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.Id
GROUP BY P.Name
ORDER BY TotalOrders DESC
LIMIT 3;

-- 7
SELECT U.Name AS UserName, COUNT(O.Id) AS TotalOrders
FROM Users U
JOIN Orders O ON U.Id = O.UserID
WHERE O.OrderDate BETWEEN '2023-02-01' AND '2023-02-28'
GROUP BY U.Name;

-- 8
SELECT MONTH(OrderDate) AS Month, SUM(P.Price * OD.Quantity) AS TotalSales
FROM Orders O
JOIN OrderDetails OD ON O.Id = OD.OrderID
JOIN Products P ON OD.ProductID = P.Id
GROUP BY MONTH(OrderDate);

-- 9
SELECT P.Name AS ProductName, COUNT(OD.Id) AS TotalOrders
FROM Products P
LEFT JOIN OrderDetails OD ON P.Id = OD.ProductID
GROUP BY P.Name;
