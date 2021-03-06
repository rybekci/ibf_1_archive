/****** Script for SelectTopNRows command from SSMS  ******/
 
  select  *
  from(  
  select  *
  from (
  SELECT DISTINCT opt.[OptionCode] as optcode
  FROM [KOTON_DB].[dbo].[FA_Sales_AllChannels_Weekly_SKU_Based_Koton] as allc
  inner join [KOTON_DB].[dbo].[LU_Option_Koton] as opt on allc.[YITEMCODE] = opt.[ItemCode]
  ) as sales
  left join [KOTON_DB].[dbo].[LU_Image_Koton] as imag on sales.optcode = imag.OptionCode) as t
  where Image1 is null 

  select  count(*)
  from(  
  select  *
  from (
  SELECT  DISTINCT opt.[OptionCode] as optcode
  FROM [KOTON_DB].[dbo].[FA_Sales_AllChannels_Weekly_SKU_Based_Koton] as allc
  inner join [KOTON_DB].[dbo].[LU_Option_Koton] as opt on allc.[YITEMCODE] = opt.[ItemCode]
  ) as sales
  left join [KOTON_DB].[dbo].[LU_Image_Koton] as imag on sales.optcode = imag.OptionCode) as t
  where Image1 is null 
  
