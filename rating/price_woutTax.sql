
SELECT top(100) [YSLSN]
      ,[YSTOKID]
      ,[CALWEEK]
      ,[YITEMCODE]
      ,[YSTORE]
      ,[STORE_CHANNEL]
      ,[STORENAME]
      ,[STORE_CHANNEL_NAME]
      ,[SALES_QUANTITY]
      ,[SALESAMOUNT]
      ,[SALESAMOUNTIF]
      ,[SALESCOST]
      ,[STOK_QUANTITY], RB_Tax.ValueAddedTax, SAmountwoutTax=SALESAMOUNT/RB_Tax.ValueAddedTax
  FROM [KOTON_DB].[dbo].[FA_Sales_AllChannels_Weekly_SKU_Based_Koton]
  left join RB_Tax on RB_tax.ItemCode=YITEMCODE