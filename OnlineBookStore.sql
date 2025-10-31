-- Create Database
CREATE DATABASE OnlineBookstore;

USE OnlineBookstore;

-- create table Customers
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
Customer_ID INT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone INT,
City VARCHAR(50),
Country VARCHAR(50)
);

-- Show Customers table 
SELECT * FROM Customers;

-- create table Books
DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
Book_ID INT PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(100),	
Published_Year INT,
Price DOUBLE,
Stock INT
);

-- Show Books table 
SELECT * FROM Books;

-- create table Orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
Order_ID INT PRIMARY KEY,	
Customer_ID INT,
Book_ID INT,
Order_Date DATE,
Quantity INT,
Total_Amount DOUBLE,
foreign key (Customer_ID) REFERENCES Customers(Customer_ID),
foreign key (Book_ID) REFERENCES Books(Book_ID)
);

-- Show Orders table 
 SELECT * FROM Orders;


-- 1) Retrieve all books in the "Fiction" genre:
 SELECT * FROM Books
 WHERE Genre="Fiction";

-- 2) Find books published after the year 1950:
 SELECT * FROM Books
 WHERE Published_Year>1950;
 
-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE Country="Canada";

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date 
BETWEEN '2023-11-1' AND '2023-11-30'; 

-- 5) Retrieve the total stock of books available:
SELECT SUM(Stock) AS Total_Stock
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE Total_Amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT(Genre) from Books;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books
ORDER BY Stock ASC
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) AS Total_Revenue 
FROM Orders;

-- 12) Show all books written by authors whose names start with 'C'.
SELECT * FROM Books
WHERE Author LIKE 'C%';

-- 13) Retrieve books priced between $20 and $40.
SELECT * FROM Books
WHERE Price BETWEEN 20 AND 40;

-- 14) List customers whose names contain 'Smith'.
SELECT * FROM Customers
WHERE NAME LIKE '%Smith%';

-- 15) Find all books published before 1950.
SELECT * FROM Books 
WHERE Published_Year < 1950;

-- 16) Display the top 5 cheapest books.
SELECT * FROM Books
ORDER BY Price
LIMIT 5;

-- 17) Show all customers from Asian countries.
SELECT * FROM Customers
WHERE Country IN ('India','Japan','China','Bangladesh','Pakistan');

-- 18) Retrieve all orders where the quantity ordered = 10.
SELECT * FROM Orders
WHERE Quantity=10;

-- 19) List books that have a stock greater than 80.
SELECT * FROM Books
WHERE Stock>80;

-- 20) Find all customers whose email ends with '.com'.
SELECT * FROM Customers
WHERE Email LIKE "%.com";


-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold FROM Books AS b
JOIN Orders AS o
ON b.Book_ID=o.Book_ID
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(Price) AS Average_Price FROM Books
WHERE Genre="Fantasy";

-- 3) List customers who have placed at least 2 orders:
SELECT c.Customer_ID, c.Name, COUNT(o.Order_ID) AS Order_Count 
FROM Customers AS c
JOIN Orders AS o
ON c.Customer_ID=O.Customer_ID
GROUP BY c.Customer_ID
HAVING COUNT(o.Order_ID) >= 2;

-- 4) Find the most frequently ordered book:
SELECT b.Title, SUM(o.Quantity) AS Frequently_Order_Book 
FROM Books AS b
JOIN Orders AS o
ON b.Book_ID=o.Book_ID
GROUP BY b.Title
ORDER BY Frequently_Order_Book  DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
  SELECT * FROM Books
  WHERE Genre="Fantasy"
  ORDER BY Price DESC
  LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold FROM Books AS b
JOIN Orders AS o
ON b.Book_ID=o.Book_ID
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.City, o.Total_Amount FROM Customers AS c
JOIN Orders AS o
ON c.Customer_ID=o.Customer_ID
WHERE o.Total_Amount>30;

-- 8) Find the customer who spent the most on orders:
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Most_Spent FROM Customers AS c
JOIN Orders AS o
ON c.Customer_ID=o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Most_Spent DESC
LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.Title, b.Stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Stocks FROM Books AS b
LEFT JOIN orders AS o 
ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;

-- 10) Find the month with the highest total sales revenue.
SELECT MONTH(o.Order_Date) AS Month, SUM(o.Total_Amount) AS Highest_Revenue
FROM Orders AS o
GROUP BY MONTH(o.Order_Date)
ORDER BY Highest_Revenue DESC
LIMIT 1;

-- 11) Show the top 5 customers who spent the most money.
SELECT c.Name, SUM(o.Total_Amount) AS Spent_Most_Money 
FROM Customers AS c
JOIN Orders AS o
ON C.Customer_ID=O.Customer_ID
GROUP BY c.Name
ORDER BY Spent_Most_Money DESC
LIMIT 5;

-- 12) Retrieve the most popular genre based on total sales.
SELECT b.Genre, SUM(Quantity) AS Total_Sales FROM Books AS b
JOIN Orders AS o
ON b.Book_ID=o.Book_ID
GROUP BY Genre
ORDER BY Total_Sales DESC
LIMIT 1;

-- 13) Find the author whose books generated the highest revenue.
SELECT b.Author, SUM(Total_Amount) AS Highest_Revenue 
FROM Books AS b
JOIN Orders AS o
ON b.Book_ID=o.Book_ID
GROUP BY b.Author
ORDER BY Highest_Revenue DESC
LIMIT 1;

-- 14) List customers who ordered books from at least 3 different genres.
SELECT c.Customer_ID, c.Name, COUNT(DISTINCT b.Genre) AS Genres_Ordered
FROM Customers AS c
JOIN Orders AS o 
ON c.Customer_ID = o.Customer_ID
JOIN Books AS b 
ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(DISTINCT b.Genre) >= 3;

-- 15) Calculate the average order value per customer.
SELECT c.Name, AVG(o.Total_Amount) AS Avg_Order_Value  FROM Customers AS c
JOIN Orders AS o
ON c.Customer_ID=o.Customer_ID
GROUP BY c.Name;

-- 16) Identify books that were never ordered.
-- 1st Ans 
SELECT b.Book_ID, b.Title, b.Author, b.Genre, b.Published_Year, b.Price, b.Stock FROM Books AS b
LEFT JOIN Orders AS o
ON b.Book_ID=o.Book_ID
WHERE o.Book_ID IS NULL;

-- 2nd Ans 
SELECT * FROM Books 
WHERE Book_ID NOT IN (SELECT DISTINCT Book_ID FROM Orders);

-- 17) Find the year with the maximum number of books published.
SELECT Published_Year, COUNT(Title) AS  Max_Published_Book FROM Books
GROUP BY  Published_Year
ORDER BY Max_Published_Book DESC
LIMIT 1;

-- 18) Show the customer who placed the earliest order.
-- 1st Ans 
SELECT c.Name,o.Order_Date FROM Customers AS c
JOIN Orders AS o
ON c.Customer_ID=o.Customer_ID
ORDER BY o.Order_Date
LIMIT 1;

-- 2nd Ans 
SELECT c.Customer_ID, c.Name, MIN(o.Order_Date) AS First_Order
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY First_Order ASC LIMIT 1;

-- 19) Retrieve the book that generated the maximum revenue.
SELECT b.Title, SUM(o.Total_Amount) AS Revenue
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Title
ORDER BY Revenue DESC LIMIT 1;

-- 20) Calculate the average quantity of books ordered per order.
SELECT Order_Date, AVG(Quantity) AS Avg_Quantity_Books 
FROM Orders 
GROUP BY Order_Date;
