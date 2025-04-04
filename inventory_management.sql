create database inventory1;
use inventory1;
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    QuantityInStock INT DEFAULT 0,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    SupplierID INT,
    DateAdded TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE Provider (
    ProviderID INT PRIMARY KEY AUTO_INCREMENT,
    ProviderName VARCHAR(100) NOT NULL,
    ContactPerson VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50)
);
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50),
    DateJoined TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2),
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    DeliveryDate DATE,
    DeliveryStatus VARCHAR(50) DEFAULT 'Pending',
    ShipperName VARCHAR(100),
    TrackingNumber VARCHAR(100),
    DeliveryAddress TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    TotalPrice DECIMAL(10, 2) AS (Quantity * UnitPrice) STORED,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE DeliveryDetails (
    DeliveryID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    DeliveryDate DATE,
    DeliveryStatus VARCHAR(50) DEFAULT 'Pending',
    ShipperName VARCHAR(100),
    TrackingNumber VARCHAR(100),
    EstimatedArrivalDate DATE,
    ActualDeliveryDate DATE,
    DeliveryAddress TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
CREATE TABLE Location (
    LocationID INT PRIMARY KEY AUTO_INCREMENT,
    LocationName VARCHAR(100) NOT NULL,
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50)
);


CREATE TABLE Transfer (
    TransferID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    FromLocationID INT NOT NULL,
    ToLocationID INT NOT NULL,
    Quantity INT NOT NULL,
    TransferDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50) DEFAULT 'In Transit',
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (FromLocationID) REFERENCES Location(LocationID),
    FOREIGN KEY (ToLocationID) REFERENCES Location(LocationID)
);


INSERT INTO Product (ProductName, Category, QuantityInStock, UnitPrice, SupplierID) VALUES
('Laptop', 'Electronics', 50, 50000.00, 1),
('Mouse', 'Electronics', 200, 500.00, 2),
('Keyboard', 'Electronics', 150, 800.00, 2),
('Monitor', 'Electronics', 75, 10000.00, 1),
('Printer', 'Electronics', 40, 7000.00, 3),
('Desk', 'Furniture', 30, 4000.00, 3),
('Office Chair', 'Furniture', 25, 3500.00, 3),
('Pen Drive', 'Accessories', 300, 350.00, 2),
('Hard Disk', 'Accessories', 60, 4500.00, 1),
('Webcam', 'Electronics', 90, 1200.00, 2);
INSERT INTO Provider (ProviderName, ContactPerson, Phone, Email, Address, City, State, ZipCode, Country) VALUES
('TechWorld Ltd.', 'Rajesh Kumar', '9876543210', 'rajesh@techworld.com', '123 Tech Street', 'Chennai', 'Tamil Nadu', '600001', 'India'),
('GadgetZone Pvt. Ltd.', 'Anjali Sharma', '9876500000', 'anjali@gadgetzone.com', '45 Gizmo Lane', 'Bangalore', 'Karnataka', '560001', 'India'),
('FurniCorp', 'Manoj Das', '9988776655', 'manoj@furnicorp.com', '78 Comfort Avenue', 'Hyderabad', 'Telangana', '500001', 'India');

INSERT INTO Customer (CustomerName, Phone, Email, Address, City, State, ZipCode, Country) VALUES
('Ravi Kumar', '9000012345', 'ravi@email.com', '12 North Street', 'Delhi', 'Delhi', '110001', 'India'),
('Meena Joshi', '9123456789', 'meena@email.com', '67 South Street', 'Mumbai', 'Maharashtra', '400001', 'India'),
('Amit Patel', '9333345678', 'amit@email.com', '88 Green Park', 'Ahmedabad', 'Gujarat', '380001', 'India'),
('Sneha Rao', '9445566778', 'sneha@email.com', '32 Lake Road', 'Bangalore', 'Karnataka', '560002', 'India'),
('John Abraham', '9556677889', 'john@email.com', '21 MG Road', 'Chennai', 'Tamil Nadu', '600002', 'India');

INSERT INTO Orders (CustomerID, TotalAmount, OrderStatus) VALUES
(1, 51000.00, 'Pending'),
(2, 3500.00, 'Shipped'),
(3, 1850.00, 'Delivered'),
(4, 1200.00, 'Pending'),
(5, 4800.00, 'Cancelled');
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 50000.00),
(1, 2, 2, 500.00),
(2, 7, 1, 3500.00),
(3, 3, 1, 800.00),
(3, 8, 3, 350.00),
(4, 10, 1, 1200.00),
(5, 6, 1, 4000.00),
(5, 2, 1, 500.00),
(5, 9, 1, 300.00),
(5, 8, 1, 350.00);
INSERT INTO DeliveryDetails (OrderID, DeliveryDate, DeliveryStatus, ShipperName, TrackingNumber, EstimatedArrivalDate, ActualDeliveryDate, DeliveryAddress, City, State, ZipCode, Country) VALUES
(1, '2025-04-01', 'In Transit', 'BlueDart', 'BD123456789', '2025-04-05', NULL, '12 North Street', 'Delhi', 'Delhi', '110001', 'India'),
(2, '2025-04-02', 'Delivered', 'DTDC', 'DT987654321', '2025-04-06', '2025-04-04', '67 South Street', 'Mumbai', 'Maharashtra', '400001', 'India'),
(3, '2025-04-03', 'Delivered', 'India Post', 'IP567890123', '2025-04-07', '2025-04-06', '88 Green Park', 'Ahmedabad', 'Gujarat', '380001', 'India'),
(4, '2025-04-04', 'Pending', 'BlueDart', 'BD456789123', '2025-04-08', NULL, '32 Lake Road', 'Bangalore', 'Karnataka', '560002', 'India'),
(5, '2025-04-05', 'Cancelled', 'DTDC', 'DT321654987', '2025-04-09', NULL, '21 MG Road', 'Chennai', 'Tamil Nadu', '600002', 'India');
INSERT INTO Location (LocationName, Address, City, State, ZipCode, Country) VALUES
('Warehouse A', 'Plot 1, Industrial Area', 'Chennai', 'Tamil Nadu', '600001', 'India'),
('Warehouse B', 'Tech Park', 'Bangalore', 'Karnataka', '560001', 'India'),
('Storage C', 'Sector 5', 'Hyderabad', 'Telangana', '500001', 'India');
INSERT INTO Transfer (ProductID, FromLocationID, ToLocationID, Quantity, Status) VALUES
(1, 1, 2, 5, 'In Transit'),
(2, 2, 1, 10, 'Completed'),
(3, 3, 1, 7, 'Pending'),
(4, 1, 2, 3, 'Completed'),
(5, 2, 3, 2, 'In Transit');
INSERT INTO Inventory (ProductID, Quantity) VALUES
(1, 45),
(2, 190),
(3, 143),
(4, 72),
(5, 38),
(6, 30),
(7, 24),
(8, 295),
(9, 59),
(10, 89);
DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Product;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetProductsByCategory(IN cat VARCHAR(50))
BEGIN
    SELECT * FROM Product WHERE Category = cat;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetLowStockItems(IN minQty INT)
BEGIN
    SELECT ProductName, QuantityInStock
    FROM Product
    WHERE QuantityInStock < minQty;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetAllCustomers()
BEGIN
    SELECT * FROM Customer;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN custID INT)
BEGIN
    SELECT * FROM Orders WHERE CustomerID = custID;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetInventoryByLocation(IN locID INT)
BEGIN
    SELECT p.ProductName, i.Quantity
    FROM Inventory i
    JOIN Product p ON i.ProductID = p.ProductID
    WHERE i.LocationID = locID;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetTransferHistory()
BEGIN
    SELECT * FROM Transfer;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetOrdersByStatus(IN status VARCHAR(50))
BEGIN
    SELECT * FROM Orders WHERE OrderStatus = status;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetTopSellingProducts(IN limitN INT)
BEGIN
    SELECT p.ProductName, SUM(od.Quantity) AS TotalSold
    FROM OrderDetails od
    JOIN Product p ON od.ProductID = p.ProductID
    GROUP BY p.ProductName
    ORDER BY TotalSold DESC
    LIMIT limitN;
END//

DELIMITER ;
DELIMITER //

CREATE PROCEDURE GetPendingDeliveries()
BEGIN
    SELECT * FROM DeliveryDetails
    WHERE DeliveryStatus NOT IN ('Delivered', 'Cancelled');
END$$

DELIMITER ;

CALL GetAllProducts();
CALL GetAllCustomers();
CALL GetTransferHistory();
CALL GetPendingDeliveries();

-- Show products in a given category
CALL GetProductsByCategory('Electronics');

-- List products with stock less than 10
CALL GetLowStockItems(10);

-- Orders for a specific customer (e.g., customer ID 101)
CALL GetCustomerOrders(101);

-- Inventory for a specific location (e.g., location ID 1)
CALL GetInventoryByLocation(1);

-- Orders with a given status
CALL GetOrdersByStatus('Pending');

-- Top 5 selling products
CALL GetTopSellingProducts(5);




















