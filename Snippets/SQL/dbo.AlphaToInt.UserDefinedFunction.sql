IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AlphaToInt]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[AlphaToInt]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AlphaToInt]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[AlphaToInt](@Value varchar(10))
RETURNS int
AS
BEGIN
    DECLARE @CodeChars varchar(100) 
    SET @CodeChars = ''ABCDEFGHIJKLMNOPQRSTUVWXYZ''
    DECLARE @CodeLength int = 26
    DECLARE @Digit char(1)
    DECLARE @Result int = 0
    DECLARE @DigitValue int
    DECLARE @Index int = 0
    DECLARE @Reverse varchar(7)
    SET @Reverse = REVERSE(@Value)

    WHILE @Index < LEN(@Value)
    BEGIN
        SET @Digit = SUBSTRING(@Reverse, @Index + 1, 1)
        SET @DigitValue = (CHARINDEX(@Digit, @CodeChars) - 1) * POWER(@CodeLength, @Index)
        SET @Result = @Result + @DigitValue
        SET @Index = @Index + 1
    END 
    RETURN @Result
END' 
END

GO
