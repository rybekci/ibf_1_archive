select top(100) t.OptionCode, Weeks = AVG(Small_t)
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
  