/****** Script for SelectTopNRows command from SSMS  ******/
Select OptionCode, TTSales = ISNULL(sum(TotalSales), 0)
from (Select CODE, TotalSales
From (
SELECT [CODE], TotalSales=Sum(isnull(cast(totalqty as float),0)) 
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
  Group by CODE)t) AS Sales
INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Sales.Code
Where OptionCode='7KAK12590YK06M'
Group by OptionCode





