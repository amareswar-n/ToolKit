IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_EmptyIntegerToNULL]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_EmptyIntegerToNULL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_EmptyIntegerToNULL]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ufn_EmptyIntegerToNULL] ( @Integer bigint)
RETURNS bigint 
AS 
BEGIN 
	SELECT  @Integer = CASE WHEN @Integer IS NULL THEN NULL 
							WHEN @Integer = 0 THEN NULL
							ELSE @Integer
					   END
	RETURN(@Integer) 
END' 
END

GO
