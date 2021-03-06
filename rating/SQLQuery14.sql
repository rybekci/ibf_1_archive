select t4.*, [ProductHierarchyLevel01]
      ,[ProductHierarchyLevel02]
      ,[ProductHierarchyLevel03]
      ,[ProductHierarchyLevel04]
      ,[ProductHierarchyLevel05] from (
select *, age=try_cast(LastSeen as numeric)-try_cast(Born as numeric) from(
select *
from(
select opt, isnull(rating, buyingrating) as rating, pricepoint
from(
select CONCAT(model, colour) as opt, 
try_cast(rating as integer) as rating, pricepoint, try_cast(buyingrating as integer) as buyingrating
  fROM [KOTON_DB].[dbo].[AnaVeriRaiting]) as t) as t2
  where rating is not null) as t3
  inner join rb_optionsales as os on os.optioncode = t3.opt) as t4
  left join rb_opthier as opth on opth.optioncode=t4.opt
 