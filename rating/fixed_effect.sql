/****** Script for SelectTopNRows command from SSMS  ******/
SELECT fe2.[OptionCode]
      ,[STORENAME]
	  ,[ProductHierarchyLevel01]
      ,[ProductHierarchyLevel02]
      ,[ProductHierarchyLevel03]
      ,[ProductHierarchyLevel04]
      ,[ProductHierarchyLevel05]
      ,[SatistaKalma],
	  case when (SALES_QUANTITY < 0 or SALES_QUANTITY is null) then 0 else SALES_QUANTITY end as Satis,
	  case when (STOK_QUANTITY < 0 or STOK_QUANTITY is null) then 0 else STOK_QUANTITY end as Stok,
	  case when (SALESAMOUNT < 0 or SALESAMOUNT is null) then 0 else SALESAMOUNT end as Fiyat,
	  rats.rating into RB_FE3
  FROM [KOTON_DB].[dbo].[RB_FE2] as fe2
  left join [RB_opthier] on [RB_opthier].OptionCode=fe2.OptionCode
  left join (select Opt, rating = max(rating) from(
  select * from (
SELECT concat(Model, Colour) as Opt, try_cast(rating as integer) as rating
  FROM [KOTON_DB].[dbo].[AnaVeriRaiting]
  where division!= 'ACCESSORIES' and division!= 'TRENDS') as t
  where rating is not null
  
  union

  select [OPTION] as Opt, [Rating Derecesi] as rating
  FROM [KOTON_DB].[dbo].[mail_ratings])t
  group by Opt) as rats on rats.Opt=fe2.OptionCode