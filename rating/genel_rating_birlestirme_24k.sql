/****** Script for SelectTopNRows command from SSMS  ******/


select * from (
SELECT concat(Model, Colour) as Opt, try_cast(rating as integer) as rating
  FROM [KOTON_DB].[dbo].[AnaVeriRaiting]
  where division!= 'ACCESSORIES' and division!= 'TRENDS') as t
  where rating is not null
  union

  select [OPTION] as Opt, [Rating Derecesi] as rating
  FROM [KOTON_DB].[dbo].[mail_ratings]