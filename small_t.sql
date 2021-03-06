/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (100) CODE, MAX(CDATE) AS maxt, MIN(CDATE) AS mt, DATEDIFF(week, MIN(CDATE), MAX(CDATE)) AS diff
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] 
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Code 
  WHERE Variant.OptionCode = '7YKG67309AW01F'
  GROUP BY CODE


  SELECT OptionCode, MAX(diff) AS Small_t
  FROM (
  SELECT CODE, OptionCode, MAX(CDATE) AS maxt, MIN(CDATE) AS mt, DATEDIFF(week, MIN(CDATE), MAX(CDATE)) AS diff
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] 
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Code 
  GROUP BY CODE, OptionCode
  ) AS t
  WHERE OptionCode = '7YKG67309AW01F'
  GROUP BY OptionCode