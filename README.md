# SQL-Analytics-on-an-Online-Bookstore
📚 Online Bookstore Database (SQL Project) A relational SQL database for managing an online bookstore with Customers, Books, and Orders. Includes schema design, sample data, and 40+ queries (basic &amp; advanced) to analyze sales, revenue, inventory, and customer behavior.

---

## 🗂️ Key Features
- Normalized schema with **primary & foreign keys**  
- 500+ sample records across customers, books, and orders  
- **Basic queries**: filter by genre, year, price, country, etc.  
- **Advanced queries**: top customers, best-selling books, revenue trends, stock tracking, books never ordered  

---

## 📊 Entity-Relationship Diagram
```
Customers (Customer_ID PK) ───< Orders (Order_ID PK, FK: Customer_ID, Book_ID ) >─── Books (Book_ID PK)
```

## 🚀 How to Use
1. Import the SQL scripts into MySQL/MariaDB.  
2. Load the CSV datasets (`Customers.csv`, `Books.csv`, `Orders.csv`).  
3. Run the queries to explore insights like **top genres, revenue, and customer behavior**.  

---

