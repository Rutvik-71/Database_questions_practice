select
c.name as Customers
from Customers as c
left join Orders as o
on C.id = O.customerId
where customerId is null 