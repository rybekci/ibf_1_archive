

SELECT variant.OptionCode, TotalSt = sum(TRY_CAST(stock as float))
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
  inner join [KOTON_DB].[dbo].[LU_Variant_New] as variant on code=variant.SkuCode
  group by  variant.OptionCode



select OptionCode, FirstSt = sum(TRY_CAST(FirstStock as float))
from(
select code, OptionCode, FirstStock
from
(
  SELECT variant.OptionCode
	  ,[CODE]
      ,min([CDATE]) as datea
      ,[STOCK] as FirstStock,
	  ROW_NUMBER() OVER(PARTITION BY code ORDER BY [CDATE]) Corr
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
  inner join [KOTON_DB].[dbo].[LU_Variant_New] as variant on code=variant.SkuCode
  group by  variant.OptionCode, code, [STOCK], [CDATE]
) as t
  where Corr=1
  group by code, OptionCode, FirstStock
  )t
  group by OptionCode
