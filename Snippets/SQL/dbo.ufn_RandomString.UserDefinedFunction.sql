IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_RandomString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_RandomString]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_RandomString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'--select [dbo].[ufn_RandomString]
CREATE function [dbo].[ufn_RandomString](
    @pStringLength int = 10 --set desired string length
) returns varchar(max)
/* Requires View create view dbo.MyNewID as select newid() as NewIDValue;
*/
as begin
    declare  @RandomString varchar(max);
    with
    a1 as (select 1 as N union all
           select 1 union all
           select 1 union all
           select 1 union all
           select 1 union all
           select 1 union all
           select 1 union all
           select 1 union all
           select 1 union all
           select 1),
    a2 as (select
                1 as N
           from
                a1 as a
                cross join a1 as b),
    a3 as (select
                1 as N
           from
                a2 as a
                cross join a2 as b),
    a4 as (select
                1 as N
           from
                a3 as a
                cross join a2 as b),
    Tally as (select
                row_number() over (order by N) as N
              from
                a4)
    , cteRandomString (
        RandomString
    ) as (
    select top (@pStringLength)
        substring(x,(abs(checksum((select NewIDValue from dbo.MyNewID)))%36)+1,1)
    from
        Tally cross join (select x=''0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'') a
    )
     select @RandomString = 
    replace((select
        '','' + RandomString
    from
        cteRandomString
    for xml path ('''')),'','','''');
    return (@RandomString);
end

' 
END

GO
