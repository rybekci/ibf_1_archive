

  select * into FA_Sales_AllChannels_Weekly_SKU_Based_Koton from (
  select * from [KOTON_DB].[dbo].[TEMMUZ_AGUSTOS]
  union
  select * from [KOTON_DB].[dbo].[EYLUL_EKIM]
  union
  select * from [KOTON_DB].[dbo].[KASIM_ARALIK]
  union
  select * from [KOTON_DB].[dbo].[OCAK_MART]
  union
  select * from [KOTON_DB].[dbo].[NISAN_HAZIRAN])t


