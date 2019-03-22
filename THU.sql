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

/* 1. FAIL (please add column totalProduct) Hiển thị danh sách các mặt hàng theo typeProduct------*/
select count(productId) typeProduct
 from Products
 group by typeProduct





/* 2. FAIL (please add column rating) Lấy danh sách tổng tiền các mặt hàng theo rating-----*/;
select sum(Price) as sumPrice
from products
group by rating



/*FAIL (please add clumn rating) 3. Lấy danh sách tổng tiền các mặt hàng theo rating mà tổng tiền >3000---*/;
select sum(Price) as sumPrice
from products 
group by rating
having sum(Price)>3000



/* OK 4. Hiển thị productName, price, quanlity, các đơn hàng đã order có typeProduct là food--*/;
select products.productName,products.price,orders.quantity
from orders
join products on products.productId=orders.productId
where typeProduct='food';
 




/*OK 5. Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có productName là IphoneX--*/;
select products.productName,sum(products.Price *orders.quantity) as totalPrice,
sum(orders.quantity)
from products 
inner join orders on products.productId=orders.productId
group by (products.productName)
having products.productName='IphoneX';

/*6.OK (Please add column totalQuantity) Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có typeProduct là electronic--*/
select products.productName,sum(products.Price *orders.quantity) as totalPrice
from products 
inner join orders on products.productId=orders.productId
where products.typeProduct='electronic'
group by products.productName;



/*7 FAIL (totalPrice is not exactly) . Hiển thị chi tiết đơn hàng và tổng tiền cho mỗi mặt hàng--*/
select products.productName,products.typeProduct,sum(products.price) as totalPrice,orders.orderId
from products
join orders on  products.productId=orders.productId
group by products.productName;


/*8 OK. Hiển thị danh sách số lượng mặt hàng đã order, tổng tiền mặt hàng đã được order theo từng loại*/;
select sum(quantity) as totalProduct,typeProduct,sum(products.price*orders.quantity) as totalPrice 
from products
join orders on products.productId=orders.productId
group by products.typeProduct;


/*9.please add column totalPrice Hiển thị danh sách tổng số mặt hàng, tổng số tiền của mặt hàng đó theo typeProduct được order trong tháng 1*/
select typeProduct,  sum(quantity) as totalProduct
from products
join orders on products.productId = orders.productId
where month(orders.orderDate) =01
group by typeProduct;


/*10. fail Loại mặt hàng nào được order nhiều nhất  ?--*/;
select products.typeProduct, sum(orders.quantity) as quantity
from orders
join products on orders.productId = products.productId
group by products.typeProduct
HAVING sum(orders.quantity) >= ALL;
/*11 OK (but group by typeProduct). Hiển thị các mặt hàng đã được order trong khoảng tháng 2 đến tháng 3--*/
select  typeProduct, sum(quantity) as totalProduct
from products
join orders on products.productId = orders.productId
where (month(orderDate) >=2 and month(orderDate) <=3)
group by productName;






