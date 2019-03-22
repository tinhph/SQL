
USE queryexercises;

/* 1. Hiển thị danh sách các mặt hàng theo typeProduct------*/

SELECT COUNT(productId) totalProduct, typeProduct from products group by(typeProduct);

/* 2. Lấy danh sách tổng tiền các mặt hàng theo rating------*/
SELECT SUM(price) as sumPrice, rating from products  group by (rating);

/* 3. Lấy danh sách tổng tiền các mặt hàng theo rating mà tổng tiền >3000---*/

SELECT SUM(price) as sumPrice, rating from products  group by (rating) having sumPrice >3000 ;

/* 4. Hiển thị productName, price, quantity, các đơn hàng đã order có typeProduct là food--*/
SELECT products.productName, products.price, orders.quantity
from products inner join orders on products.productId = orders.productId
where products.typeProduct ='food';

/* 5. Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có productName là IphoneX--*/
SELECT products.productName, sum(products.price * orders.quantity) as totalPrice, sum(orders.quantity) as totalQuantity
from products inner join orders on products.productId = orders.productId
group by(products.productName)
having products.productName = 'IphoneX';

/*6. Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có typeProduct là electronic--*/

SELECT products.productName, sum(products.price * orders.quantity) as totalPrice, sum(orders.quantity) as total
from products inner join orders on products.productId = orders.productId
where products.typeProduct = 'electronic'
group by(products.productName);

/*7. Hiển thị chi tiết đơn hàng và tổng tiền cho mỗi mặt hàng--*/
select orders.orderId,products.typeProduct, products.productName,
(products.price * orders.quantity) as totalPrice from orders INNER join products 
on products.productId = orders.productId;

/*8. Hiển thị danh sách số lượng mặt hàng đã order, tổng tiền mặt hàng đã được order theo từng loại*/

select products.typeProduct, sum(products.price * orders.quantity) as totalPrice,
sum(orders.quantity) as totalQuantity from orders INNER join products 
on products.productId = orders.productId
group by products.typeProduct;

/*9. Hiển thị danh sách tổng số mặt hàng, tổng số tiền của mặt hàng đó theo typeProduct được order trong tháng 1*/
SELECT products.typeProduct, 
sum(products.price * orders.quantity) as totalPrice
from products inner join orders on products.productId = orders.productId
WHERE MONTH(orders.orderDate) = 1
GROUP BY products.typeProduct;

/*10. Loại mặt hàng nào được order nhiều nhất  ?--*/


select s.typeProduct, max(s.totalQuantity) as maxQuantity from
(select products.typeProduct, sum(orders.quantity) as totalQuantity from orders inner join products
on products.productId = orders.productId
group by products.typeProduct 
order by totalQuantity desc) s;

/*--cach 2*/
select products.typeProduct, sum(orders.quantity) as totalQuantity from orders inner join products
on products.productId = orders.productId
group by products.typeProduct 
order by totalQuantity desc
limit 1;

/*11. Hiển thị các mặt hàng đã được order trong khoảng tháng 2 đến tháng 3--*/

select orders.productId, products.typeProduct, products.productName,
 sum(orders.quantity) as totalQuantity,month(orders.orderDate) as month from products inner join orders
on products.productId = orders.productId 
where month(orders.orderDate) between 2 and 3
group by products.typeProduct;
