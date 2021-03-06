/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [CODE], Vari.OptionCode
      ,[CDATE]
      ,[ACTIVE_STATUS]
      ,[STOCK]
      ,[FirstSellingPriceInclVAT]
      ,[LastSellingPriceInclVAT]
      ,[COGSInclVAT]
      ,[totalqty]
      ,[totalprice]
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] 
  inner join [KOTON_DB].[dbo].[LU_Variant_New] as Vari on Vari.[SkuCode] = Code
  where code like '8KAK84026ZK01V%'
  order by CDate

  

 select optioncode, cdate, Sto=sum(TRY_CAST(stock as float)), stis = sum(TRY_CAST(totalqty as float)),
 fprice = avg(TRY_CAST([FirstSellingPriceInclVAT] as float)), price= avg(TRY_CAST(totalprice as float) / NULLIF(TRY_CAST(totalqty as float),0)),
 med = max(case when Code like '%m' and stock>0 then 1 else 0  end),
 small = max(case when Code like '%s' and stock>0 then 1 else 0  end),
 xsmall = max(case when Code like '%xs' and stock>0 then 1 else 0  end),
 large = max(case when Code like '%l' and stock>0 then 1 else 0  end),
 xlarge = max(case when Code like '%xl' and stock>0 then 1 else 0  end)
  from(
  SELECT [CODE], cdate, Vari.OptionCode
      ,[STOCK], totalqty, [FirstSellingPriceInclVAT], totalprice
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] 
  inner join [KOTON_DB].[dbo].[LU_Variant_New] as Vari on Vari.[SkuCode] = Code
  where code like '8KAK84026ZK01V%'
  )t
  group by Optioncode,cdate
