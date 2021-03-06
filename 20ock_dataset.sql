select  dset.*, totalsk.TotalSt, firstsk.FirstSt, Rat.NGroup
from
(
select  Weeks.OptionCode, Prix.FirstPrice, MoyenneReduc = Prix.Reduc/Weeks.Weeks
from
(
select t.OptionCode, Weeks = AVG(Small_t)
From
(
SELECT CODE, OptionCode, MAX(diff) AS Small_t
  FROM (
  SELECT CODE, OptionCode, MAX(CDATE) AS maxt, MIN(CDATE) AS mt, DATEDIFF(week, MIN(CDATE), MAX(CDATE)) AS diff
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] 
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Code 
  GROUP BY CODE, OptionCode
  ) AS t
  
  GROUP BY CODE, OptionCode
  ) as t
  group by t.OptionCode
  having AVG(t.Small_t)>2
) as Weeks
Left join 
(SELECT [OptionCode]
      ,[FirstPrice]
      ,[LastPrice]
	  ,Reduc = [FirstPrice]-[LastPrice]
  FROM [KOTON_DB].[dbo].[Input_table]) AS Prix ON Weeks.OptionCode=Prix.OptionCode
  ) AS dset
  LEFT JOIN
  (
  SELECT  [OptionCode]
      , NGroup
  FROM [KOTON_DB].[dbo].[Ratio_table_gruouped_new]
  ) AS Rat ON dset.OptionCode=Rat.OptionCode
  LEFT JOIN (
  SELECT variant.OptionCode, TotalSt = sum(TRY_CAST(stock as float))
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
  inner join [KOTON_DB].[dbo].[LU_Variant_New] as variant on code=variant.SkuCode
  group by  variant.OptionCode
  ) AS totalsk ON totalsk.OptionCode=dset.OptionCode
  LEFT JOIN (
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
  ) AS firstsk ON firstsk.OptionCode=dset.OptionCode
   where dset.OptionCode = '6KAM11722LK709'