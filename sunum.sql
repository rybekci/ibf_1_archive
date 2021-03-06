SELECT  OptionCode, Ratio=AVG(INVRatio), Smalltt = AVG(Small_t), Sicr=AVG(INCR),Sdec=AVG(DC),Szero=AVG(I0), SalesTot = AVG(TTSales)
INTO [KOTON_DB].[dbo].[Temporary_table]
FROM(
 SELECT Sales.CODE, Sales.OptionCode, Smallt.Small_t, Stock.TotalIncrement AS d, Stock.INCR, Stock.DC, Stock.I0, Sales.TTSales,
		(Sales.TTSales/ nullif(Smallt.Small_t , 0))/ (Stock.TotalIncrement+Stock.I0)  AS INVRatio 
FROM (
SELECT  tbl.[CODE], Variant.OptionCode, I0 = Sum(isnull(tbl.INI, 0)), INCR=Sum(isnull(tbl.INC, 0)), TotalIncrement=Sum(isnull(tbl.INC, 0)) - Sum(isnull(tbl.DEC, 0)),  DC=Sum(isnull(tbl.DEC, 0))
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
) AS Stock,
(
Select CODE, OptionCode, TTSales = ISNULL(sum(TotalSales), 0) 
    from (Select CODE, TotalSales 
    From ( 
    SELECT [CODE], TotalSales=Sum(isnull(cast(totalqty as float),0)) 
    FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] Group by CODE)t) AS Sales INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Sales.Code 
	Group by CODE, OptionCode
) AS Sales,
(
SELECT CODE, OptionCode, MAX(diff) AS Small_t
  FROM (
  SELECT CODE, OptionCode, MAX(CDATE) AS maxt, MIN(CDATE) AS mt, DATEDIFF(day, MIN(CDATE), MAX(CDATE)) AS diff
  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] 
  INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Code 
  GROUP BY CODE, OptionCode
  ) AS t
  
  GROUP BY CODE, OptionCode
) AS Smallt
WHERE Sales.CODE = Stock.CODE AND Sales.CODE = Smallt.CODE
) AS master
GROUP BY OptionCode

