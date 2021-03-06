/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Top(1000) *
FROM

(SELECT Comm.*, Variant.ItemCode, Variant.OptionCode, Variant.SizeCode
  FROM [KOTON_DB].[dbo].[FA_Transactions_Ecommerce] AS Comm
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Comm.Code
  WHERE Variant.OptionCode='8kak88101pw01a') AS Comm , [KOTON_DB].[dbo].[LU_Model_New] AS Model 

  WHERE Comm.ItemCode = Model.ItemCode
