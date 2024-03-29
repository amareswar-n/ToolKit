IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IntToAlpha]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[IntToAlpha]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IntToAlpha]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[IntToAlpha](@Value int)
RETURNS varchar(30)
AS
BEGIN
    DECLARE @CodeChars varchar(100) 
    SET @CodeChars = ''ABCDEFGHIJKLMNOPQRSTUVWXYZ''
    DECLARE @CodeLength int = 26
    DECLARE @Result varchar(30) = ''''
    DECLARE @Digit char(1)

    SET @Result = SUBSTRING(@CodeChars, (@Value % @CodeLength) + 1, 1)
    WHILE @Value > 0
    BEGIN
        SET @Digit = SUBSTRING(@CodeChars, ((@Value / @CodeLength) % @CodeLength) + 1, 1)
        SET @Value = @Value / @CodeLength
        IF @Value <> 0 SET @Result = @Digit + @Result
    END 

    RETURN @Result
END
' 
END

GO
