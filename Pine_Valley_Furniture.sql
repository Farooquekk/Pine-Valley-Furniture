-- 1 table
create table productline(
productlineid int auto_increment primary key,   
productlinename varchar(100)
);
-- 2 table
create table product(
productid int auto_increment primary key,
productdescription varchar (100),
productfinish varchar (100),
productstandardprice decimal,
productlineid int ,
foreign key (productlineid) references productline (productlineid)
); 
-- 3 table
create table orders( -- I can't name as order b/c it is a reserved keyword 
orderid int auto_increment primary key,
orderdate date,
customerid int,
foreign key (customerid) references customer (customerid) 
);
-- 4 table
create table customer(
customerid int auto_increment primary key,
customername varchar (100),
customeraddress varchar(100),
customerpostalcode varchar(100)
);
-- 5 table
create table orderlineitem(  -- helper table for solving (M --> M) relation 
orderlineitemid int auto_increment primary key,
orderquantity int ,
customerid int ,
orderid int,
foreign key (customerid) references customer (customerid),
foreign key (orderid) references orders (orderid)
);
-- 6 table
create table rawmaterial(
rawmaterialid int auto_increment primary key,
unitofmeasure varchar(100),
materialname varchar(100),
materialstandardcost decimal,
productid int ,
foreign key (productid) references product (productid)

); 
-- 7 table
create table vendor(
vendorid int auto_increment primary key,
vendorname varchar(100),
vendoraddress varchar(100)
);
-- 8 table 
create table supply( -- helper table 
supplyid int auto_increment primary key,
supplyunitprice decimal,
rawmaterialid int,
vendorid int,
foreign key (rawmaterialid) references rawmaterial(rawmaterialid),
foreign key (vendorid) references vendor(vendorid)
);
-- 9 table
create table usedquantity( -- helper table 
usedquantityid int auto_increment primary key,
usedquantity decimal,
rawmaterialid int ,
productid int,
foreign key (rawmaterialid) references rawmaterial(rawmaterialid),
foreign key (productid) references product(productid) 
);

insert into usedquantity(usedquantity,rawmaterialid,productid) values
(10,1,1),
(12,2,2),
(9,3,3),
(8,4,4),
(3,5,6),
(2,6,7),
(4,7,1),
(11,8,2)
;

-- inserting data in table 1
insert into productline (productlinename) values
("Modern Living Room"),
("Cozy Bedroom"),
("Elegant Dinning Room"),
("Sleek Kitchen"),
("Functional Office"),
("Relaxing Outdoor"),
("ColorFul Kids Room"),
("Organized Storage"),
("Luxury Bathroom");
-- inserting data in table 2

insert into product(productdescription,productfinish,productstandardprice,productlineid) 
values
("Sofa","Leather",900,1),
("Single Bed","Wood",2000,2),
("Double Bed","Wood",3000,3),
("Dining Table","Glass",1000,4),
("Single Bed","Wood",2000,5),
("Kitchen Kabinet","Stainless Steel",1300,6),
("Desk","Metal",200,7);

-- inserting data in table 4
-- My SQL does not support sequence it's support auto increment
insert into customer (customername,customeraddress,customerpostalcode) values
("Farooque","Jhuddo","KKM Word:02"),
("Sajjad","Jhuddo","KKM Word:02"),
("Talha","Tando Allayar","AR Word:09"),
("Rafy","TMK","MM Word:04"),
("Rohit","UK","U Word:03"),
("Fakhar","Lahore","LH Word:01"),
("Imam","Karachi","KR Word:08"),
("Babar","Peshawar","PW Word:11"),
("Saim","Multan","ML Word:17"),
("Amir","Karachi","KR Word:02");


-- inserting data in table 3
insert into orders (orderdate,customerid) values
("2024-03-20",1),
("2024-03-21",2),
("2024-03-22",3),
("2024-03-23",4),
("2024-03-24",5),
("2024-03-25",6),
("2024-03-26",7),
("2024-03-27",1),
("2024-03-28",2);

-- inserting data in table 5
insert into orderlineitem(orderquantity,customerid,orderid) values
(2,1,1),
(1,1,8),
(3,2,2),
(4,2,9),
(5,3,3),
(10,4,4),
(11,5,5),
(10,6,6),
(20,7,7);

insert into product(productdescription,productfinish,productstandardprice,productlineid) 
values
("Chair","Wood",200,5);



-- inserting into the table 6
insert into rawmaterial (unitofmeasure, materialname, materialstandardcost, productid) values
("sq.ft", "Leather", 15, 1),
("kg", "Wood", 10, 2),
("kg", "Wood", 11, 3),
("kg", "Wood", 11, 8), 
("sq.m", "Glass", 12, 4), 
("m", "Stainless Steel", 18, 6),
("kg", "Metal", 8, 7);

insert into vendor (vendorname, vendoraddress)
values
    ('Leather Supplier A', '123 Main Street karachi'),
    ('Wood Supplier B', '456 Fateh Chowk Street Hyderabad'),
    ('Glass Supplier C', '789 M.A Street Lahore'),
    ('Stainless Steel Supplier D', '101 Pine Street Islamabad'),
    ('Metal Supplier E', '202 Maple Street Multan');


insert into supply(supplyunitprice,rawmaterialid,vendorid) values
(100,1,1),
(120,2,2),
(120,3,2),
(130,4,2),
(110,5,3),
(140,6,4),
(199,7,5);



-- 1). Populate the database with at least 10 records including a record with your details
--     as the customer. --> Already Done


-- 4). Retrieve the order details for all customers who ordered on 24-03-2024 and delete
    -- the order details for the date 20-03-2024.


select * from orders join customer on customer.customerid = orders.customerid
where date(orders.orderdate) = '2024-03-24';
delete from orderlineitem where orderlineitem.orderid in (select  orderid from orders where
(orderdate) in ("2024-03-20")); 
delete from orders where (orderdate) = "2024-03-20"; 
select * from orderlineitem;
select * from supply;




create view  Product_RawMaterial_Vendor_View as
select product.productid,productdescription,productfinish,productstandardprice,materialname,materialstandardcost,
vendorname from product join usedquantity  on product.productid = usedquantity.productid
join rawmaterial  on usedquantity.rawmaterialid = rawmaterial.rawmaterialid
join supply on rawmaterial.rawmaterialid = supply.rawmaterialid
join  vendor  on supply.vendorid = vendor.vendorid;

select * from product_rawmaterial_vendor_view;





-- delete from rawmaterial where rawmaterialid>8;
select * from customer;
select * from rawmaterial;
delete from product where productid=5;
select * from product;
select * from orders;
select * from orderlineitem;
select * from vendor;