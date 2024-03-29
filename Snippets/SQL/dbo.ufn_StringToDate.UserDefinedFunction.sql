IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_StringToDate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_StringToDate]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_StringToDate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'--DROP FUNCTION dbo.ufn_ConvertToDate 
--SELECT dbo.ufn_StringToDate ( ''2017-10-30'') 
CREATE FUNCTION [dbo].[ufn_StringToDate] ( @DateTime Varchar(20) ) 
RETURNS datetime 
AS 
BEGIN 
	DECLARE @Date datetime 
	SELECT @Date = TRY_CONVERT(DATETIME, @DateTime, 120) ; 
		--102);
	RETURN (@Date) 
 END' 
END

GO
