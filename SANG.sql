
CREATE DATABASE queryexercises;
USE queryexercises;

CREATE TABLE Products
(
  productId INT NOT NULL,
  productName VARCHAR(50) NOT NULL,
  typeProduct varchar(50) NOT NULL,
  price FLOAT NOT NULL,
  rating INT NOT NULL,
  PRIMARY KEY (productId)
);

CREATE TABLE Orders
(
  orderId INT NOT NULL,
  productId INT NOT NULL,
  quantity INT NOT NULL,
  orderDate DATE NOT NULL,
  PRIMARY KEY (orderId),
  FOREIGN KEY (productId) REFERENCES Products(productId)
);


/*--- insert data for products table--*/
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('1', 'electronic','IphoneX', 1200, 4);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('2', 'food','hotdog', 500, 3);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('3', 'food','chocola', 300, 2);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('4', 'electronic','DVD', 200, 3);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('5', 'toy','Dog toy', 100, 2);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('6', 'food','Candy', 40, 4);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('7', 'electronic','Computer', 1800, 3);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('9', 'electronic','IMac', 10000, 2);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('10', 'electronic','Printer', 4500, 1);
INSERT INTO `queryexercises`.`products` (`productId`, `typeProduct`,`productName`, `price`, `rating`) VALUES ('11', 'food','coca', 200, 1);


/*---insert data for orders tables--*/
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('1', '1', '4', '2019-03-03');
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('2', '1', '3', '2019-01-01');
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('3', '1', '1', '2019-02-04');
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('4', '2', '10', '2019-01-01');
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('5', '3', '4', '2019-02-28');
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('6', '4', '3', '2019-03-03');
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('7', '4', '2', '2019-02-02');
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('8', '5', '1', '2019-01-01');
INSERT INTO `queryexercises`.`orders` (`orderId`, `productId`, `quantity`, `orderDate`) VALUES ('9', '5', '6', '2019-04-03');

/* OK_1. Hiển thị danh sách các mặt hàng theo typeProduct------*/
select count(typeProduct) as totalProduct, typeProduct
from products
group by typeProduct;
/* 2. OK_Lấy danh sách tổng tiền các mặt hàng theo rating------*/
select sum(price) as sumPrice, rating
from Products
group by rating;
/* OK_3. Lấy danh sách tổng tiền các mặt hàng theo rating mà tổng tiền >3000---*/
select sum(price) as sumPrice, rating
from Products
group by rating
having sumPrice >3000
order by rating desc;


/* OK_4. Hiển thị productName, price, quanlity, các đơn hàng đã order có typeProduct là food--*/
select Products.productName,products.price,orders.quantity
from Products
inner join orders on products.productId = orders.productId
where typeProduct ='food';
;
/* OK_5. Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có productName là IphoneX--*/
select  Products.productName, sum(price*quantity) as totalPrice ,sum(quantity) as quantity
from Products
inner join orders on products.productId= orders.productId
where productName = 'IphoneX'
; 
/*OK_6. Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có typeProduct là electronic--*/
select productName, sum(price*quantity) as totalPrice, sum(quantity)
from Products
inner join orders on products.productId = orders.productId
where typeProduct='electronic'
group by Products.productName;


/*7(Remove column sum(Quantity). Hiển thị chi tiết đơn hàng và tổng tiền cho mỗi mặt hàng--*/
select orderId, productName, typeProduct, sum(price*quantity) as totalPrice, sum(quantity)
from orders
inner join products on products.productId = orders.productId
group by orderId;


/*8. - add column totalQuantity = sum(orders.quantity), remove column count(productName) 
Hiển thị danh sách số lượng mặt hàng đã order, tổng tiền mặt hàng đã được order theo từng loại*/
select count(productName), typeProduct, sum(price*quantity)
from orders
inner join products on products.productId = orders.productId
group by typeProduct;


/*9. set alias for column quantity * price 
Hiển thị danh sách tổng số mặt hàng, tổng số tiền của mặt hàng đó theo typeProduct được order trong tháng 1*/
select count(orderId) as totalOrder,
 products.typeProduct , 
 (quantity * price)
from products inner join orders on products.productId = orders.productId 
where month(orderDate) = 1 
group by products.typeProduct;

/*10. RESULT FAIL_Loại mặt hàng nào được order nhiều nhất  ?--*/
select sum(quantity) as totalQuantity, productId
from orders
group by productId
having max(totalQuantity);

/*11. RESULT FAIL (Electronic 4, food 1) Hiển thị các mặt hàng đã được order trong khoảng tháng 2 đến tháng 3--*/
select count(orderId) as totalOrder,
 products.typeProduct , 
 (quantity * price)
from products inner join orders on products.productId = orders.productId 
where month(orderDate) > 1 and month(orderDate) <3 
group by products.typeProduct;









