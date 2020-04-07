SELECT top(100) tbl.[CODE], Variant.OptionCode, I0 = Sum(isnull(tbl.INI, 0)), INCR=Sum(isnull(tbl.INC, 0)), TotalIncrement=Sum(isnull(tbl.INC, 0)) - Sum(isnull(tbl.DEC, 0)),  DC=Sum(isnull(tbl.DEC, 0))
FROM(
	SELECT [CODE]
			,CDATE
			,STOCK
			,LAG1
		  ,CASE WHEN  TRY_CAST(STOCK as float)>TRY_CAST(LAG1 as float) THEN TRY_CAST(STOCK as float)-TRY_CAST(LAG1 as float)
				ELSE 0 END INC
		  ,CASE WHEN  TRY_CAST(STOCK as float)<TRY_CAST(LAG1 as float) AND TRY_CAST(LAGQUANT as float) < 1 AND TRY_CAST(totalqty as float) < 1 THEN TRY_CAST(LAG1 as float) - TRY_CAST(STOCK as float)
				ELSE 0 END DEC
		  ,Case WHEN LAG1 IS NULL THEN  TRY_CAST(STOCK as float) END INI

	FROM(
	SELECT [CODE]
		  ,[STOCK]
		  ,CDATE
		  ,totalqty
		  ,LAG(STOCK) OVER (PARTITION BY CODE ORDER BY CDATE) AS LAG1
		  ,LAG(totalqty) OVER (PARTITION BY CODE ORDER BY CDATE) AS LAGQUANT
	  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
	  GROUP BY CODE, CDATE, STOCK, totalqty)t
	  GROUP BY CODE, LAG1, CDATE, STOCK, LAGQUANT, totalqty
) AS tbl
INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = tbl.Code 
GROUP BY CODE, OptionCode
