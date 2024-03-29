IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_GetDropDownValue]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_GetDropDownValue]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_GetDropDownValue]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ufn_GetDropDownValue]
(
	@Id Int,
	@AttributeName Varchar(50)
	)
RETURNS Varchar(255)
AS
BEGIN
DECLARE @val Varchar(255) 
SELECT @val= Value 
	FROM [dbo].[APP_REFERENCE]
	WHERE GroupName = LTRIM(RTRIM(@AttributeName)) AND [ReferenceId] =  @Id AND ISACTIVE = 1 

	RETURN @val

END

' 
END

GO
