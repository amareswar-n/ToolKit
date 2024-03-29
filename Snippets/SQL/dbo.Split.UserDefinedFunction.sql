IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[Split]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Split]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[Split] (@strString varchar(4000), @Delimiter varchar(10))
RETURNS  @Result TABLE(Value Varchar(50))
AS
begin
    WITH StrCTE(start, stop) AS
    (
      SELECT  1, CHARINDEX(@Delimiter, @strString )
      UNION ALL
      SELECT  stop + 1, CHARINDEX( @Delimiter ,@strString  , stop + 1)
      FROM StrCTE
      WHERE stop > 0
    )
   
    insert into @Result
    SELECT   SUBSTRING(@strString , start, CASE WHEN stop > 0 THEN stop-start ELSE 4000 END) AS stringValue
    FROM StrCTE
   
    return
end   
 

' 
END

GO
