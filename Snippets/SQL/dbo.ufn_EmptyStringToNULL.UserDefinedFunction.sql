IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_EmptyStringToNULL]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_EmptyStringToNULL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_EmptyStringToNULL]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[ufn_EmptyStringToNULL] ( @String Varchar(100))
RETURNS VARCHAR(255)
AS 
BEGIN 
	SELECT  @String = CASE WHEN @String IS NULL THEN NULL 
							WHEN LTRIM(RTRIM(@String)) = '''' THEN NULL
							ELSE LTRIM(RTRIM(@String))
					   END
	RETURN(@String) 
END' 
END

GO
