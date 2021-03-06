/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) OptionCode, FirstPrice=AVG(cast(FirstSellingPriceInclVAT as float)), LastPrice=AVG(cast(LastSellingPriceInclVAT as float))
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] AS Comm 
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode=Comm.CODE
  GROUP BY  OptionCode