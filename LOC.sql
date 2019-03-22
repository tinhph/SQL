
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
  quantity INT NOT NULL ,
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

/* OK (please add ; end of command SQL) 1. Hiển thị danh sách các mặt hàng theo typeProduct------*/
select count(productName) totalProduct,typeProduct
from products
group by typeProduct



/* OK 2. Lấy danh sách tổng tiền các mặt hàng theo rating------*/
select sum(price),rating
from products
group by rating


/* 3. Lấy danh sách tổng tiền các mặt hàng theo rating mà tổng tiền >3000---*/
select sum(price) as totalPrice,rating
from products
group by rating
having totalPrice > 3000



/* OK 4. Hiển thị productName, price, quanlity, các đơn hàng đã order có typeProduct là food--*/
select productName,price,quantity
from products
join orders
on products.productId = orders.productId
where typeproduct ='food'



/* OK 5. Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có productName là IphoneX--*/
select orderId,productName,quantity,price*quantity as totalPrice
from products
join orders 
on products.productId = orders.productId
where productName = 'IphoneX'


/*6. OK (reset alias for column totalPrice) Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có typeProduct là electronic--*/
select productName,sum( quantity), sum(quantity)*price as totalPrice
from products
join orders
on products.productId = orders.productId
where  typeProduct = 'electronic'
group by productName


/*7. Hiển thị chi tiết đơn hàng và tổng tiền cho mỗi mặt hàng--*/
select orderId,productName,typeProduct,quantity*price as totalPrice
from products
join orders
on products.productId = orders.productId


/*8. FAIL (electroic sum is 10600) Hiển thị danh sách số lượng mặt hàng đã order, tổng tiền mặt hàng đã được order theo từng loại*/
select sum(quantity) as totalProduct,typeProduct,price*sum(quantity) as totalPrice
from products
join orders
on products.productId = orders.productId
group by typeProduct

/*9. OK (please add totalPrice column) Hiển thị danh sách tổng số mặt hàng, tổng số tiền của mặt hàng đó theo typeProduct được order trong tháng 1*/
select sum(quantity) as totalProduct,typeProduct
from products
join orders
on products.productId = orders.productId
where month(orderDate) = 1
group by typeproduct

/*10 FAIL. Loại mặt hàng nào được order nhiều nhất  ?--*/
use queryexercises
select newTable.typeProduct, max(totalQuantity) as maxQuantity from
(select products.productId,typeProduct,sum(quantity) as totalQuantity
from products
join orders
on products.productId=orders.productId
group by typeProduct) as newTable
join products
on products.productId = newTable.productId




/*11.OK Hiển thị các mặt hàng đã được order trong khoảng tháng 2 đến tháng 3--*/
select sum(quantity),typeProduct
from products
join orders
on products.productId = orders.productId
where month(orderDate) between 2 and 3
group by typeProduct









