/****** Script for SelectTopNRows command from SSMS  ******/

select OptionCode, Sales=sum(Sales), LastSeen=max(LastSeen), Born=min(Born), MinFiyat=min(MinFiyat), MaxFiyat=max(MaxFiyat) into RB_OptionSales
from (
select sa.*, variant.OptionCode
from(
SELECT 
      YSTOKID
      ,sum(SALES_QUANTITY) as Sales, min(calweek) as Born, max(calweek) as LastSeen, MinFiyat=min(case when SALESAMOUNT > 0 then SALESAMOUNT end), MaxFiyat=max(SALESAMOUNT)
  FROM [KOTON_DB].[dbo].[FA_Sales_AllChannels_Weekly_SKU_Based_Koton]
  group by YSTOKID) as sa
  left join [KOTON_DB].[dbo].[LU_Variant_Koton] as variant on sa.YSTOKID=variant.SkuCode) as tab
  group by OptionCode