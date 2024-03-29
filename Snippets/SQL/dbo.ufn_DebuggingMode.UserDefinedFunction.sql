IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_DebuggingMode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_DebuggingMode]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_DebuggingMode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N' CREATE FUNCTION [dbo].[ufn_DebuggingMode] ()
  RETURNS BIT 
  AS
  BEGIN
  RETURN ( SELECT Value FROM [dbo].[APP_CONFIGURATION] WHERE Name = ''DebuggingMode'' ) 
  END ' 
END

GO
