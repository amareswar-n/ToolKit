IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_LPAD]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_LPAD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_LPAD]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'/*
 ==========================================================
 Description:This function work for Left padding. there are 3 parameters. the first parameter 
			is for which value you want to padding, 
			2nd parameter is how many length for padding and 3rd parameter is 
			which value will used to pad 
 ==========================================================
*/
CREATE function [dbo].[ufn_LPAD]
(
	@pad_value varchar(500),
	@pad_length int,
	@pad_with varchar(10)
)
returns varchar(5000)
as
BEGIN
	Declare @value_result varchar(5000)
	select @value_result= replace(str(@pad_value,@pad_length),'' '',@pad_with) 
	return @value_result
END' 
END

GO
