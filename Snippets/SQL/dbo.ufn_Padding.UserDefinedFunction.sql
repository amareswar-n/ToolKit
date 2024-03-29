IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_Padding]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_Padding]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_Padding]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ufn_Padding]
        (
			 @MyStr VARCHAR(25),
			 @LENGTH INT,
			 @PadChar CHAR(1) = NULL
        )
RETURNS VARCHAR(25)
 AS 
      BEGIN
        SET @PadChar = ISNULL(@PadChar, ''0'')

		IF ( LEN(@MyStr) > @LENGTH ) --If Generated length is more than the required
			RETURN @MyStr
		
        RETURN RIGHT(SUBSTRING(REPLICATE(''0'', @LENGTH), 1,(@LENGTH + 1) - LEN(RTRIM(@MyStr))) + RTRIM(@MyStr), @LENGTH)
         
      END

' 
END

GO
