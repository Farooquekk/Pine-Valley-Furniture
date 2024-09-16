# Pine Valley Furniture 🪑🏡

Welcome to the **Pine Valley Furniture Database Management System**! This project is designed to manage the business operations of Pine Valley Furniture, including customer orders, products, raw materials, vendors, and more. It demonstrates a complete database solution for an e-commerce or retail furniture store.

This README file provides an overview of the database structure, important queries, and instructions on how to interact with the system.

## 🌟 Features

- **Customer Management**: Store and manage customer details like name, address, and postal code.
- **Product Management**: Keep track of furniture products, including descriptions, materials, and prices.
- **Order Processing**: Manage customer orders and items purchased.
- **Raw Material Tracking**: Record the raw materials used in furniture production and their associated costs.
- **Vendor Management**: Manage vendors supplying raw materials.
- **Advanced Queries**: Fetch and manipulate data with detailed SQL queries.
- **Database Views**: Use views to combine and simplify complex data.

## 🏗️ Database Structure

This system consists of **9 tables** and **1 view**, which together capture the core business operations of Pine Valley Furniture.

### 1. `productline` Table
Manages different furniture categories.

| Column             | Description                             |
|--------------------|-----------------------------------------|
| `productlineid`     | Unique product line identifier (PK)     |
| `productlinename`   | Name of the product line                |

### 2. `product` Table
Stores furniture product information, including its details and associated product line.

| Column               | Description                                  |
|----------------------|----------------------------------------------|
| `productid`          | Unique product identifier (PK)               |
| `productdescription` | Short description of the product             |
| `productfinish`      | Material or finish of the product            |
| `productstandardprice`| Standard price of the product               |
| `productlineid`      | Foreign key to the product line              |

### 3. `orders` Table
Captures customer orders, with date and customer information.

| Column             | Description                            |
|--------------------|----------------------------------------|
| `orderid`          | Unique order identifier (PK)           |
| `orderdate`        | Date of the order                      |
| `customerid`       | Foreign key linking to `customer` table|

### 4. `customer` Table
Stores customer information, such as name, address, and postal code.

| Column               | Description                          |
|----------------------|--------------------------------------|
| `customerid`         | Unique customer identifier (PK)      |
| `customername`       | Customer's full name                 |
| `customeraddress`    | Address of the customer              |
| `customerpostalcode` | Postal code of the customer          |

### 5. `orderlineitem` Table
Helper table for managing multiple products in a single order (M-to-M relationship).

| Column             | Description                            |
|--------------------|----------------------------------------|
| `orderlineitemid`   | Unique identifier for the order line (PK)|
| `orderquantity`     | Quantity of the product ordered       |
| `customerid`        | Foreign key linking to `customer`     |
| `orderid`           | Foreign key linking to `orders`       |

### 6. `rawmaterial` Table
Stores raw materials used in furniture manufacturing, including cost and unit of measure.

| Column                | Description                                |
|-----------------------|--------------------------------------------|
| `rawmaterialid`       | Unique raw material identifier (PK)        |
| `unitofmeasure`       | Unit of measure for the raw material       |
| `materialname`        | Name of the raw material                   |
| `materialstandardcost`| Standard cost of the material              |
| `productid`           | Foreign key linking to `product`           |

### 7. `vendor` Table
Stores vendor information from whom the raw materials are purchased.

| Column          | Description                              |
|-----------------|------------------------------------------|
| `vendorid`      | Unique vendor identifier (PK)            |
| `vendorname`    | Name of the vendor                       |
| `vendoraddress` | Address of the vendor                    |

### 8. `supply` Table
Helper table linking raw materials and their vendors.

| Column           | Description                             |
|------------------|-----------------------------------------|
| `supplyid`       | Unique supply identifier (PK)           |
| `supplyunitprice`| Price of the supplied material per unit |
| `rawmaterialid`  | Foreign key linking to `rawmaterial`    |
| `vendorid`       | Foreign key linking to `vendor`         |

### 9. `usedquantity` Table
Helper table for tracking the amount of raw material used in manufacturing each product.

| Column           | Description                             |
|------------------|-----------------------------------------|
| `usedquantityid` | Unique identifier for the record (PK)   |
| `usedquantity`   | Quantity of raw material used           |
| `rawmaterialid`  | Foreign key linking to `rawmaterial`    |
| `productid`      | Foreign key linking to `product`        |

### View: `Product_RawMaterial_Vendor_View`
A view that combines data from `product`, `usedquantity`, `rawmaterial`, `supply`, and `vendor` tables to give a comprehensive overview of which vendors supply raw materials used in which products.

```sql
CREATE VIEW Product_RawMaterial_Vendor_View AS
SELECT product.productid, productdescription, productfinish, productstandardprice, materialname, materialstandardcost, vendorname
FROM product
JOIN usedquantity ON product.productid = usedquantity.productid
JOIN rawmaterial ON usedquantity.rawmaterialid = rawmaterial.rawmaterialid
JOIN supply ON rawmaterial.rawmaterialid = supply.rawmaterialid
JOIN vendor ON supply.vendorid = vendor.vendorid;
```

## 🚀 Important SQL Queries

### 1. Retrieve Order Details for March 24, 2024
To retrieve the order details of customers who placed orders on **24th March 2024**:

```sql
SELECT * FROM orders 
JOIN customer ON customer.customerid = orders.customerid
WHERE date(orders.orderdate) = '2024-03-24';
```

### 2. Delete Orders from March 20, 2024
To delete order details for orders placed on **20th March 2024**:

```sql
DELETE FROM orderlineitem 
WHERE orderid IN (SELECT orderid FROM orders WHERE orderdate = '2024-03-20');

DELETE FROM orders 
WHERE orderdate = '2024-03-20';
```

### 3. Select All from `Product_RawMaterial_Vendor_View`
To get all the data from the view that shows product, raw material, and vendor details:

```sql
SELECT * FROM Product_RawMaterial_Vendor_View;
```

## 🛠️ Additional Operations

### Inserting Data into Tables
The database comes pre-populated with sample data, but you can insert new records as needed. Here's an example of inserting a new customer:

```sql
INSERT INTO customer (customername, customeraddress, customerpostalcode)
VALUES ('John Doe', '123 Pine Street', 'ZIP123');
```

### Deleting Products
If you need to delete a product (e.g., a specific product by `productid`):

```sql
DELETE FROM product WHERE productid = 5;
```

## 📝 License
Feel free to use this project as you see fit for personal, educational, or commercial purposes.

Enjoy managing **Pine Valley Furniture's** database! 😄
