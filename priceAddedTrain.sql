
SELECT top(1000) dset.*, Prices.FirstPrice, Prices.LastPrice
FROM (
SELECT DISTINCT  OptionCode, ProductHierarchyLevel02, ProductHierarchyLevel03, ProductHierarchyLevel04, ProductHierarchyLevel05, SeasonCode, KOLEKSİYON, [KULLANIM-eski], [MODEL TASARIMI], [OZEL KOLEKSIYON], SEZONU 
  FROM [KOTON_DB].[dbo].[LU_Model_New] AS Model 
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.ItemCode = Model.ItemCode
  ) AS dset
  INNER JOIN (
  SELECT  OptionCode, FirstPrice=AVG(cast(FirstSellingPriceInclVAT as float)), LastPrice=AVG(cast(FirstSellingPriceInclVAT as float))
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] AS Comm 
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode=Comm.CODE
  GROUP BY  OptionCode
  ) AS Prices ON Prices.OptionCode=dset.OptionCode
 