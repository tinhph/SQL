use queryexercises;
/* 1. FAIL_ (group by typeProduct) Hiển thị danh sách các mặt hàng theo typeProduct------*/

select productId, productName, typeProduct, price, rating
from products;

/* 2.OK Lấy danh sách tổng tiền các mặt hàng theo rating------*/

select sum(price) total, rating
from products
group by rating;

/* OK_3. Lấy danh sách tổng tiền các mặt hàng theo rating mà tổng tiền >3000---*/

select sum(price) total, rating
from products
group by rating
having total > 3000;

/* OK 4. Hiển thị productName, price, quanlity, các đơn hàng đã order có typeProduct là food--*/

select orderId, productName, price, quantity
from products
join orders 
on products.productId = orders.productId
where typeProduct = 'food';

/* 5. OK Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có productName là IphoneX--*/
/*--Expected results is IphoneX	9600	8  */

select orderId, productName, price, quantity, price*quantity totalPrice
from products
join orders 
on products.productId = orders.productId
where productName = 'IphoneX';

/*6.OK Hiển thị productName, totalPrice, quanlity các đơn hàng đã order có typeProduct là electronic--*/

select orderId, productName, price, quantity, price*quantity totalPrice
from products
join orders 
on products.productId = orders.productId
where typeProduct = 'electronic';

/*7. OK_ Hiển thị chi tiết đơn hàng và tổng tiền cho mỗi đơn hàng--*/

select orderId, productName, typeProduct, price,quantity, quantity*price as totalPrice
from orders
join products
on products.productId = orders.productId
order by orderId;


/*8. FAIL_ electronic and food need group (do not group by productName) Hiển thị danh sách số lượng mặt hàng đã order, tổng tiền mặt hàng đã được order theo từng mặt hàng*/

select productName, typeProduct, sum(quantity) totalProduct, sum(price*quantity) as totalPrice
from products
join orders on products.productId = orders.productId
group by productName; 

/*9. Hiển thị danh sách các mặt hàng, tổng số tiền của mặt hàng đó theo typeProduct được order trong tháng 1*/

select productName, typeProduct,  sum(quantity) as totalProduct, sum(price*quantity) as totalPrice
from products
join orders
on products.productId = orders.productId
where month(orderDate) = 1
group by productName;
 
/*10. FAIL Loại mặt hàng nào được order nhiều nhất  ?--*/

select products.productId, productName, typeProduct, max(quantityOrder) maxQuantityOrder
from(select productId, count(orders.productId) as quantityOrder
from orders
group by orders.productId) as tb
join products on products.productId = tb.productId;

/*11.OK but group by typeProduct and sum total Quantity Hiển thị các mặt hàng đã được order trong khoảng tháng 2 đến tháng 3--*/

select productName, typeProduct, sum(quantity) as totalQuantity
from products
join orders
on products.productId = orders.productId
where (month(orderDate) >=2 and month(orderDate) <=3)
group by productName;
