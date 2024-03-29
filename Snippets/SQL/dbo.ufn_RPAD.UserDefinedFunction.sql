IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_RPAD]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_RPAD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_RPAD]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE function [dbo].[ufn_RPAD]
(
	@pad_value varchar(500),
	@pad_length int,
	@pad_with varchar(10)
)
returns varchar(5000)
as
BEGIN
	Declare @valueResult varchar(5000)
	select @valueResult=@pad_value+replace(replace(str(@pad_value,@pad_length),'' '',@pad_with),@pad_value,'''')
	return @valueResult
END' 
END

GO
