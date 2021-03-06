/****** Script for SelectTopNRows command from SSMS  ******/
select satis.*, stor.p_latitude, stor.p_longitude 
from (
SELECT YSTORE, STORENAME, sum(SALES_QUANTITY) as TSales
  FROM [KOTON_DB].[dbo].[FA_Sales_AllChannels_Weekly_SKU_Based_Koton]
  group by STORENAME, YSTORE) as satis
  inner join LU_Stores_Koton as stor on stor.PK=satis.YSTORE