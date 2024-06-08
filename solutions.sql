use northwind;

-- 1. Escribe una CTE que liste los nombres y cantidades de los productos con un precio unitario mayor a $50.

with ExpensiveProducts as(
	select ProductName, Unit 
    from products
    where Price > 50
)
select * from ExpensiveProducts;

-- 2. ¿Cuáles son los 5 productos más rentables?

with TotalRevenueProducts as (
	select p.ProductID, p.ProductName, sum(p.Price*od.Quantity) as TotalRevenue
	from products p
	right join orderdetails od on p.ProductID=od.ProductID
	group by p.ProductID, p.ProductName
)
select * 
from TotalRevenueProducts
order by TotalRevenue desc;

-- 3. Escribe una CTE que liste las 5 categorías principales según el número de productos que tienen.

with CategoryProducts as (
	select c.CategoryName, count(p.ProductName) as ProductCount
    from categories c
    inner join products p on c.CategoryID=p.CategoryID
    group by c.CategoryName
)
select * from CategoryProducts
order by ProductCount desc
limit 5;

-- 4. Escribe una CTE que muestre la cantidad promedio de pedidos para cada categoría de producto.


with AvgCategoryOrders as (
	select c.CategoryName,  avg(od.Quantity) as AvgOrderQuantity
    from categories c
    inner join products p on p.CategoryID=c.CategoryId
    inner join orderdetails od on od.ProductId=p.ProductId
    group by c.CategoryName
)
select * from AvgCategoryOrders
order by CategoryName asc;


-- 5. Crea una CTE para calcular el importe medio de los pedidos para cada cliente.

with AvgOrderAmount as (
	select c.CustomerID, c.CustomerName, avg(p.Price*od.Quantity) as AvgOrderAmount
    from customers c
    inner join orders o on o.CustomerID=c.CustomerID
    inner join orderdetails od on od.OrderId=O.OrderId
    inner join products p on p.ProductID=od.ProductID
    group by c.CustomerID, c.CustomerName
)
select * from AvgOrderAmount
order by AvgOrderAmount desc;

-- 6. Análisis de Ventas con CTEs. Suponiendo que tenemos la base de datos Northwind que contiene tablas como Orders, OrderDetails y Products. Crea una CTE que calcule las ventas totales para cada producto en el año 1997.


with ProductSales as (
	select p.ProductName, sum(od.Quantity) TotalSales
    from products p
    inner join orderdetails od on od.ProductId=p.ProductID
    inner join orders o on od.OrderId=o.OrderId
    where date(o.OrderDate) between '1997-01-01' and '1997-12-31'
    group by p.productName
)
select * from ProductSales
order by TotalSales desc;