Select CODE, TotalSales

From (
SELECT [CODE], TotalSales=Sum(isnull(cast(totalqty as float),0)) 
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
  Group by CODE)t
where TotalSales= (select MAX(TotalSales) from (
SELECT [CODE], TotalSales=Sum(isnull(cast(totalqty as float),0)) 
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
  Group by CODE)t)
