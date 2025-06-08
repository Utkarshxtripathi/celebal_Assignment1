/* Utkarsh Tripathi Level A Task*/

/*1  List of all Customers */
SELECT * FROM customers;

/*2 customers name ends with N*/
SELECT * FROM customers
where CompanyName like '%N'; 

/*3  customers who live in berlin or london */
SELECT * FROM customers
where city='London'OR city='Berlin';

/*4  customers who live in UK or USA */
SELECT * FROM customers
where  country='UK'OR country='USA';

/*5  list of products name sorted by product name in ascending */
SELECT ProductName FROM products
ORDER BY productName asc;

/*in descending*/
SELECT ProductName FROM products
ORDER BY productName desc;

/*6 product name starts with A */
SELECT ProductName FROM products
where productname LIKE 'A%';

/*7 customer who ever order something */
SELECT DISTINCT customers.customerID  
FROM customers
INNER JOIN orders ON customers.customerID = orders.customerID;

/*  8 Customer who live in London and brought chai*/
SELECT * FROM customers c
Join orders o On c.customerID = o.customerID
Join [Order Details] od On o.orderID = od.orderID
Inner join products p On od.productID = p.productID
WHERE c.city='London' AND p.productName='chai'

/*  9 customer who never order something */
SELECT  * FROM customers c
left Join orders o On c.customerID = o.customerID
where o.orderID IS null
  
/* 10 Customer who  brought tofu */
SELECT * FROM customers c
Join orders o On c.customerID = o.customerID
Join[Order Details] od On o.orderID = od.orderID
Inner join products p On od.productID = p.productID
Where p.productName= 'tofu'

/* 11 First order of the system */
SELECT TOP 1 * FROM [Order Details] od
Join orders o On o.orderID = od.orderID
ORDER BY OrderDate

/* 12 mmaximum profit on date */
SELECT TOP 1 orderDate , SUM(UnitPrice*Quantity - UnitPrice*Discount )  AS total FROM [Order Details] od
Join orders o On o.orderID = od.orderID
Group BY orderDate
ORDER BY total DESC

/* 13 Average quantity of items of Order */
SELECT orderID  , AVG(quantity) AS avg FROM [Order Details]
Group BY orderID

/* 14 max and min quantity of items of order */
SELECT orderID  , Min(quantity) , MAX(quantity) FROM [Order Details] 
Group BY orderID

/* 15 MANAGER'S */
SELECT   m.employeeID , m.FirstName ,COUNT(e.employeeID) AS reported_from FROM employees e
join employees m On e.reportsTo = m.employeeID
GROUP BY  m.employeeID , m.FirstName 

/* 16  sum of quatity greater than 300 */
SELECT orderID  , SUM(quantity) AS total_qua FROM [Order Details]
Group BY orderID
HAVING (SUM(quantity) >300)

/* 17 all order placed on or after 1996-12-31*/
SELECT *  FROM orders
WHere orderDate >= '1996-12-31'

/* 18 all order shipped to canada */
SELECT *  FROM orders
left Join customers c ON orders.customerID=c.customerID
WHere c.country = 'canada'

/* 19 all orders with total sales > 200 * */
SELECT orderID, Sum(unitPrice * quantity) AS total FROM [Order Details] o
Group BY orderID
HAVING (SUM(unitPrice * quantity) >200)

/* 20 all country's and sales */
SELECT c.country , SUM(unitPrice * quantity) AS sales FROM customers c
join orders o On o.customerID = c.customerID
join [Order Details] od ON o.orderID = od.orderID
GROUP BY c.country

/* 21 list of contact name and no. of order they placed */
SELECT c.contactName , COUNT(o. customerID) AS order_placed  FROM customers c
join orders o On o.customerID = c.customerID 
GROUP BY  c.contactName

/* 22 list of contact name who have placed more than three orders */
SELECT c.contactName , COUNT(o. customerID) AS order_placed  FROM customers c
join orders o On o.customerID = c.customerID 
GROUP BY c.contactName
HAVING (COUNT(o.customerID)>3)

/* 23 list of discontinued products which were ordered from 1996-01-01 and 1997-01-01 */
SELECT* FROM products p
join [Order Details] od ON od.productID = p.productID
join orders o ON o.orderID = od.orderID
Where orderDate > '1996-01-01' and orderDate < '1997-01-01' and p.discontinued=1

/* 24 emplyoee name and there supervisor name */
SELECT e. FirstName , m.FirstName  FROM employees e
join employees m ON e.reportsTo =m.employeeID

/* 25 emplyoee id and total sales conducted by that employee */
SELECT o.employeeID  , SUM(unitPrice*quantity) AS Sales FROM orders o
join [Order Details] od ON o.orderID = od.orderID
GROUP BY  o.employeeID

/* 26 list of employees whose name contains letter a */
SELECT * FROM employees
where FirstName LIKE '%a%'

/* 27 list of manager who have more than   four people reporting to them */
SELECT m.FirstName FROM employees e
join employees m ON e.reportsTo =m.employeeID
GROUP BY m.FirstName
HAVING (COUNT(m.EmployeeID)>4)

/* 28 list of order and product names */
SELECT  orderID , productName FROM [Order Details] od
join products p ON od.productID = p.productID

/* 29 Best customer by total revenue */
SELECT TOP 1 c.CustomerID, SUM(od.UnitPrice * od.Quantity - od.Quantity * od.Discount) AS revenue
FROM customers c
JOIN orders ON orders.CustomerID = c.CustomerID
JOIN [Order Details] od ON od.OrderID = orders.OrderID
GROUP BY c.CustomerID
ORDER BY revenue DESC;

/*30  List of order placed by the customers who don't have the fax number */
SELECT * FROM orders
Inner join customers c ON c.CustomerID = orders.CustomerID
WHERE FAX IS NUll

/*31  List of Postal codes where tofu has been shipped */
SELECT PostalCode FROM customers c
Inner join orders ON c.CustomerID = orders.CustomerID
Inner join [Order Details] od On od.OrderID = orders.OrderID
Inner join products p ON p.ProductID = od.ProductID
WHERE ProductName = 'tofu'

/*32 List of product names shipped to france*/
SELECT productName FROM products
join [Order Details] od ON od.ProductID = products.ProductID
join orders ON  orders.OrderID = od.OrderID
join customers c ON c.CustomerID = orders.CustomerID
WHERE c.Country ='France'

/*33 List of product names  and Categories  which are supplied by Specical Biscuits Ltd.*/
SELECT CategoryName , ProductName FROM	products p
join categories c ON c.CategoryID = p.CategoryID
join Suppliers s On  s.SupplierID = p.SupplierID
WHERE s.CompanyName = 'Specialty Biscuits, Ltd.' 

/*34 List of product who have never ordered */
SELECT * FROM products p
 left join  [Order Details] od ON od.ProductID= p.ProductID
 WHERE od.OrderID IS NULL

 /* there was no product which have never order so i add one */

 INSERT INTO products(ProductName ,Discontinued) 
 values('Jalebi',0)

 SELECT * FROM products p
 left join  [Order Details] od ON od.ProductID= p.ProductID
 WHERE od.OrderID IS NULL



 /*35 list of product whose unit in stock is less then 10 and uniton order is 0 */
 SELECT *FROM products
 WHERE UnitsInStock < 10 and UnitsOnOrder = 0

 /*36  List of top 10 counties by sales */
  SELECT  TOP 10 ShipCountry ,SUM(od.UnitPrice * od.Quantity ) AS SALES FROM orders
  JOIN [Order Details] od ON orders.OrderID = od.OrderID
  GROUP BY   ShipCountry  
  ORDER BY SUM(od.UnitPrice * od.Quantity ) DESC

/*37 No. of orders each employee has taken with customer id from A to AO */
 SELECT o.EmployeeID , COUNT(EmployeeID) AS Orders FROM orders o
 WHERE (o.CustomerID >'A' and o.CustomerID < 'AO')
 GROUP BY o.EmployeeID 
      
       
/*38 order date of most expensive order */
 SELECT TOP 1 OrderDate , SUM(od.UnitPrice * od.Quantity - od.Quantity*od.Discount) AS sales FROM orders
 join [Order Details] od ON orders.OrderID = od.OrderID
 GROUP BY OrderDate 
 ORDER BY SUM(od.UnitPrice * od.Quantity - od.Quantity*od.Discount) DESC

/*39 product name total revenue from that product  */
 SELECT p.ProductName , SUM(od.UnitPrice * od.Quantity - od.Quantity*od.Discount) AS revenue  FROM products p
 join [Order Details] od ON p.ProductID = od.ProductID
 GROUP BY p.ProductName

/*40 SupplierID and number of product offered*/
    SELECT SupplierID , COUNT(SupplierID) AS Products FROM products
    GROUP BY SupplierID

/*41 TOP 10 customers based on ther business*/
  SELECT TOP 10  c.CustomerID , SUM(od.UnitPrice * od.Quantity - od.Quantity*od.Discount) AS revenue FROM customers c
  join orders ON orders.CustomerID = c.CustomerID
  join [Order Details] od ON od.OrderID = orders.OrderID
  GROUP BY c.CustomerID
  ORDER BY SUM(od.UnitPrice * od.Quantity - od.Quantity*od.Discount) DESC

/*42 Total revenue of the company */
SELECT SUM(od.UnitPrice * od.Quantity - od.Quantity * od.Discount) AS total_revenue
FROM [Order Details] od;