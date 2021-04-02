use om;
show columns from om.customers;
select * from om.customers;
select * from om.orders;
select * from om.order_details;
select * from om.items;
select * from orders join order_details using (order_id);
#I need to figure out how to get the total of the order
select sum(unit_price) from items where item_id in (select item_id from order_details where order_id = 29);
select order_id, count(*), sum(unit_price) as total from order_details join items using (item_id) group by order_id order by order_id;
select 16.95 + 17.00;