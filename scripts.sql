
/* ---------------------------------------------------------------------------------------------- */
/* 1) Listar todos Clientes que não tenham realizado uma compra:                                  */
/* ---------------------------------------------------------------------------------------------- */

-- 1.1) usando not exists

select * from customers c
where not exists (select 1 from orders o
                  where o.customer_id = c.customer_id)

-- 1.2) usando left join

select * from customers c
  left join orders o on c.customer_id = o.customer_id
where o.order_id is null





/* ---------------------------------------------------------------------------------------------- */
/* 2) Listar os Produtos que não tenham sido comprados:                                           */
/* ---------------------------------------------------------------------------------------------- */

-- 2.1) usando not exists

select * from products p
where not exists (select 1 from order_items oi
                  where oi.product_id = p.product_id)

-- 2.2) usando left join

select * from products p
  left join order_items oi on p.product_id = oi.product_id
where oi.order_id is null





/* ---------------------------------------------------------------------------------------------- */
/* 3) Listar os Produtos sem Estoque:                                                             */
/* ---------------------------------------------------------------------------------------------- */

-- 3.1) usando not exists

select * from products p
where not exists (select 1 from stocks s
                  where s.product_id = p.product_id)
-- incluindo ainda a possibilidade de existir estoque mas que esteja ZERADO
union
select * from products p
  inner join stocks s on p.product_id = s.product_id
where isnull(s.quantity, 0) = 0  -- aqui tratando ainda eventuais casos onde o campo possa estar NULL por algum motivo





/* ---------------------------------------------------------------------------------------------- */
/* 4) Agrupar a quantidade de vendas que uma determinada Marca por Loja:                          */
/* ---------------------------------------------------------------------------------------------- */

select b.brand_id, b.brand_name, s.store_id, s.store_name, count(1) total_orders
from orders o
  inner join stores s on o.store_id = s.store_id
  inner join order_items oi on o.order_id = oi.order_id
  inner join products p on oi.product_id = p.product_id
  inner join brands b on p.brand_id = b.brand_id
group by b.brand_id, b.brand_name, s.store_id, s.store_name





/* ---------------------------------------------------------------------------------------------- */
/* 5) Listar os Funcionarios que não estejam relacionados a um Pedido:                            */
/* ---------------------------------------------------------------------------------------------- */

-- 5.1) usando not exists

select * from staffs s
where not exists (select 1 from orders o
                  where o.staff_id = s.staff_id)

-- 5.2) usando left join

select * from staffs s
  left join orders o on s.staff_id = o.staff_id
where o.order_id is null
