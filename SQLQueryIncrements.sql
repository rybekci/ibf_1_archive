/****** Script for SelectTopNRows command from SSMS  ******/
Select top(100) OptionCode, TTSales = ISNULL(sum(TotalSales), 0) 
    from (Select CODE, TotalSales 
    From ( 
    SELECT [CODE], TotalSales=Sum(isnull(cast(totalqty as float),0)) 
    FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] Group by CODE)t) AS Sales INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Sales.Code 
	where OptionCode = '7YKG67309AW01F'
	Group by OptionCode

 

 SELECT [CODE], TotalSales=Sum(isnull(cast(totalqty as float),0)) 
    FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] where CODE = '7YKG67309AW01F910' Group by CODE
	

SELECT  [CODE]
			,CDATE
			,STOCK
			,LAG1
		  ,CASE WHEN  cast(STOCK as float)>cast(LAG1 as float) THEN cast(STOCK as float)-cast(LAG1 as float)
				WHEN LAG1 IS NULL THEN  cast(STOCK as float) ELSE 0 END INC
		  ,CASE WHEN  cast(STOCK as float)<cast(LAG1 as float) AND cast(LAGQUANT as float) < 1 THEN cast(LAG1 as float) - cast(STOCK as float)
				ELSE 0 END DEC

	FROM(
	SELECT [CODE]
		  ,[STOCK]
		  ,CDATE
		  ,totalqty
		  ,LAG(STOCK) OVER (PARTITION BY CODE ORDER BY CDATE) AS LAG1
		  ,LAG(totalqty) OVER (PARTITION BY CODE ORDER BY CDATE) AS LAGQUANT
	  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
	  GROUP BY CODE, CDATE, STOCK, totalqty)t
	  where CODE = '7YKG67309AW01F910'
	  GROUP BY CODE, LAG1, CDATE, STOCK, totalqty, LAGQUANT


SELECT  tbl.[CODE], Variant.OptionCode, TotalIncrement=Sum(isnull(tbl.INC, 0)) - Sum(isnull(tbl.DEC, 0))
FROM(
	SELECT [CODE]
			,CDATE
			,STOCK
			,LAG1
		  ,CASE WHEN  TRY_CAST(STOCK as float)>TRY_CAST(LAG1 as float) THEN TRY_CAST(STOCK as float)-TRY_CAST(LAG1 as float)
				WHEN LAG1 IS NULL THEN  TRY_CAST(STOCK as float) ELSE 0 END INC
		  ,CASE WHEN  TRY_CAST(STOCK as float)<TRY_CAST(LAG1 as float) AND TRY_CAST(LAGQUANT as float) < 1 AND TRY_CAST(totalqty as float) < 1 THEN TRY_CAST(LAG1 as float) - TRY_CAST(STOCK as float)
				ELSE 0 END DEC

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


SELECT t.OptionCode, Invent0 = Sum(isnull(cast(t.TotalIncrement as float),0)) 
FROM(
SELECT tbl.[CODE], Variant.OptionCode, TotalIncrement=Sum(isnull(tbl.INC, 0)) 
FROM(
	SELECT [CODE]
			,CDATE
			,STOCK
			,LAG1
		  ,CASE WHEN  TRY_PARSE(STOCK as float)>TRY_PARSE(LAG1 as float) THEN TRY_PARSE(STOCK as float)-TRY_PARSE(LAG1 as float)
				WHEN LAG1 IS NULL THEN  TRY_PARSE(STOCK as float) ELSE 0 END INC
	FROM(
	SELECT [CODE]
		  ,[STOCK]
		  ,CDATE
		  ,LAG(STOCK) OVER (PARTITION BY CODE ORDER BY CDATE) AS LAG1
	  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
	  GROUP BY CODE, CDATE, STOCK)t
	  GROUP BY CODE, LAG1, CDATE, STOCK
) AS tbl
INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = tbl.Code 
GROUP BY CODE, OptionCode
) AS t
where OptionCode = '7YLK22096BW999'
GROUP BY OptionCode












SELECT  Sales.OptionCode, Sales.TTSales / Stock.Invent0 AS Ratio
FROM (
SELECT t.OptionCode, Invent0 = Sum(isnull(cast(t.TotalIncrement as float),0)) 
FROM(
SELECT tbl.[CODE], Variant.OptionCode, TotalIncrement=Sum(isnull(tbl.INC, 0)) 
FROM(
	SELECT [CODE]
			,CDATE
			,STOCK
			,LAG1
		  ,CASE WHEN  cast(STOCK as float)>cast(LAG1 as float) THEN cast(STOCK as float)-cast(LAG1 as float)
				WHEN LAG1 IS NULL THEN  cast(STOCK as float) ELSE 0 END INC
	FROM(
	SELECT [CODE]
		  ,[STOCK]
		  ,CDATE
		  ,LAG(STOCK) OVER (PARTITION BY CODE ORDER BY CDATE) AS LAG1
	  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
	  GROUP BY CODE, CDATE, STOCK)t
	  GROUP BY CODE, LAG1, CDATE, STOCK
) AS tbl
INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = tbl.Code 
GROUP BY CODE, OptionCode
) AS t
GROUP BY OptionCode
) AS Stock,
(
Select OptionCode, TTSales = ISNULL(sum(TotalSales), 0) 
    from (Select CODE, TotalSales 
    From ( 
    SELECT [CODE], TotalSales=Sum(isnull(cast(totalqty as float),0)) 
    FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] Group by CODE)t) AS Sales INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Sales.Code 
	Group by OptionCode
) AS Sales
WHERE Sales.OptionCode = Stock.OptionCode AND Sales.OptionCode = '7YKG67309AW01F'




  SELECT Stock.CODE, Sales.TotalSales/Stock.TotalIncrement AS Ratio
  FROM (SELECT  tbl.[CODE], TotalIncrement=Sum(isnull(tbl.INC, 0)) 
FROM(
	SELECT [CODE]
			,CDATE
			,STOCK
			,LAG1
		  ,CASE WHEN  cast(STOCK as float)>cast(LAG1 as float) THEN cast(STOCK as float)-cast(LAG1 as float)
				WHEN LAG1 IS NULL THEN  cast(STOCK as float) ELSE 0 END INC
	FROM(
	SELECT [CODE]
		  ,[STOCK]
		  ,CDATE
		  ,LAG(STOCK) OVER (PARTITION BY CODE ORDER BY CDATE) AS LAG1
	  FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce]
	  GROUP BY CODE, CDATE, STOCK)t
	  GROUP BY CODE, LAG1, CDATE, STOCK
) AS tbl
GROUP BY CODE
  ) AS Stock,
  (Select  *
    from (Select CODE, TotalSales 
    From ( 
    SELECT [CODE], TotalSales=Sum(isnull(cast(totalqty as float),0)) 
    FROM [KOTON_DB].[dbo].[FA_Sales_Ecommerce] Group by CODE)t) AS Sales INNER JOIN [KOTON_DB].[dbo].[LU_Variant_New] AS Variant ON Variant.SkuCode = Sales.Code 
	WHERE OptionCode = '7YKG67309AW01F'
  ) AS Sales
  WHERE Stock.CODE = Sales.CODE 
