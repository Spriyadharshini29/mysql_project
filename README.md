## 📦 Inventory Management System (MySQL)

A relational database system for managing products, customers, orders, deliveries, and transfers—built using **MySQL** with real-world structure and sample data.

---

### 📁 Features
- 10+ interconnected tables with foreign keys  
- 10+ stored procedures for easy queries  
- Sample data for products, orders, customers, and inventory  
- Handles stock, orders, deliveries, transfers, and more

---

### 🛠️ Stored Procedures
- `GetAllProducts()`  
- `GetProductsByCategory(cat)`  
- `GetLowStockItems(minQty)`  
- `GetCustomerOrders(custID)`  
- `GetInventoryByLocation(locID)`  
- `GetTopSellingProducts(limitN)`  
- And more...

---

### 📊 Sample Queries
```sql
CALL GetAllProducts();
CALL GetLowStockItems(10);
CALL GetTopSellingProducts(5);
