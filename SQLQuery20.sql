/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT OptionCode, ProductHierarchyLevel02, ProductHierarchyLevel03, ProductHierarchyLevel04, ProductHierarchyLevel05, SeasonCode, KOLEKSİYON, [KULLANIM-eski], [MODEL TASARIMI], [OZEL KOLEKSIYON], SEZONU
  FROM [KOTON_DB].[dbo].[LU_Model_New] AS Model
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.ItemCode = Model.ItemCode

WHERE OptionCode='6KAM65328LW03P' OR OptionCode='6KAM65328LW18P'








SELECT TOP (1000) [ItemCode]
      ,[OptionCode]
      ,[SkuCode]
      ,[SizeCode]
      ,[SizeName]
      ,[F6]
      ,[F7]
  FROM [KOTON_DB].[dbo].[LU_Variant_New] A
  where OptionCode='6KAM65328LW03P'