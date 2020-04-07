

select fe3.*, sales.STORE_CHANNEL
from RB_FE3 as fe3 
left join (SELECT distinct [STORENAME]
      ,[STORE_CHANNEL]      
  FROM [KOTON_DB].[dbo].[FA_Sales_AllChannels_Weekly_SKU_Based_Koton]) as sales on sales.STORENAME=fe3.storename
where rating is not null and (sales.STORE_CHANNEL=2 or sales.STORE_CHANNEL=11) 