create database demo;
use demo;
drop table products;
create table Products(
	id int primary key auto_increment,
    productCode int,
    productName varchar(20),
    productPrice int,
    productAmount int,
    productDescription varchar(50),
    productStatus bit
);

insert into Products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
values	(1, 'sua chua', 100, 10, 'ngon', 1),
		(2, 'banh mi', 150, 12, 'ngon vl', 1),
        (3, 'sua tuoi', 280, 20, 'ok', 1),
        (4, 'kem oc que', 90, 11, 'ok', 0),
        (5, 'bim bim', 120, 20, 'good', 1);


show indexes from products;
create unique index product_code on Products(productCode);
explain select * from products where productCode = 3;
create unique index find_product on Products (productName, productPrice);
drop index find_product on Products;
alter table products drop index find_product;
explain select * from products where productName = 'kem oc que' or productPrice = 100;

create view product_view as
select productCode, productName, productPrice, productStatus
from products;

select * from product_view;
drop view product_view;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter $$
create procedure getInfoProduct(
	in pro_Name varchar(20)
)
begin
	select * from products where productName = pro_Name;
end $$
delimiter ;

call getInfoProduct('sua chua');

-- Tạo store procedure thêm một sản phẩm mới
drop procedure addProduct;
delimiter $$
create procedure addProduct(
	in prod_code int,
	prod_name varchar(20),
    prod_price int,
    prod_amount int,
    prod_des varchar(50),
    prod_status bit
)
begin
	insert into products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
    values(prod_code, prod_name,prod_price, prod_amount, prod_des, prod_status);
end $$
delimiter ;

call addProduct(6,'kem',100,10,'ok',1);

-- Tạo store procedure sửa thông tin sản phẩm theo id
drop procedure updateProduct;
delimiter $$
create procedure updateProduct(
	in prod_id int,
    prod_code int,
	prod_name varchar(20),
    prod_price int,
    prod_amount int,
    prod_des varchar(50),
    prod_status bit
)
begin
	update Products
	set productCode = prod_code, productName = prod_name, productPrice = prod_price,
    productAmount = prod_amount, productDescription = prod_des, productStatus = prod_status
	where id = prod_id;
end $$
delimiter ;

call updateProduct(2, 10, 'kem', 100, 12, 'mo ta 1', 1);

-- Tạo store procedure xoá sản phẩm theo id
drop procedure deleteProduct;
delimiter $$
create procedure deleteProduct(
	in prod_id int
)
begin
	delete from Products where id = prod_id;
end $$
delimiter ;

call deleteProduct(2);
