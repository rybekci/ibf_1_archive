select dset.*, Rat.ratio 
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
      ,[ratio]
  FROM [KOTON_DB].[dbo].[Ratio_table_gruouped_new]
  ) AS Rat ON dset.OptionCode=Rat.OptionCode