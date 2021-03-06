/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [OptionCode]
      ,[ratio]
      ,[Groups],
	NGroup= case when ratio<=0.05 then '0-0.05'
	when 0.05<ratio and ratio<=0.1 then '0.05-0.1'
	when 0.1<ratio and ratio<=0.15  then '0.1-0.15'
	when 0.15<ratio and ratio<=0.2  then '0.15-0.2'
	when 0.2<ratio and ratio<=0.25  then '0.2-0.25'
	when 0.25<ratio and ratio<=0.3  then '0.25-0.3'
	when 0.3<ratio and ratio<=0.35  then '0.3-0.35'
	when 0.35<ratio and ratio<=0.4  then '0.35-0.4'
	when 0.4<ratio and ratio<=0.45  then '0.4-0.45'
	when 0.45<ratio and ratio<=0.5  then '0.45-0.5'
	when 0.5<ratio and ratio<=0.55 then '0.5-0.55'
	when 0.55<ratio and ratio<=0.6  then '0.55-0.6'
	when 0.6<ratio and ratio<=0.65  then '0.6-0.65'
	when 0.65<ratio and ratio<=0.7  then '0.65-0.7'
	when 0.7<ratio and ratio<=0.75  then '0.7-0.75'
	when 0.75<ratio and ratio<=0.8  then '0.75-0.8'
	when 0.8<ratio and ratio<=0.85  then '0.8-0.85'
	when 0.85<ratio and ratio<=0.9  then '0.85-0.9'
	when 0.9<ratio and ratio<=0.95  then '0.9-0.95'
	else '0.95-1'
	end
 Into [Ratio_table_gruouped_new]
  FROM [KOTON_DB].[dbo].[Ratio_table_gruouped]