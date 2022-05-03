# This script will enumerate items in the supplied site recycle bin and output those items to a grid-view.
# Use the grid to search, filter, etc., and when confident in the results, use CTRL+A to select all.
# Click 'Ok' in the bottom right, to bulk restore the items you selected.
Connect-PnPOnline https://tenantsharepointname.sharepoint.com/sites/sitename -UseWebLogin
Get-PnPRecycleBinItem  |
    Select-Object Title, ID, AuthorEmail, DeletedbyEmail, DeletedDate, DirName | 
        Out-GridView -PassThru |
            ForEach-Object { Restore-PnPRecycleBinItem -Identity $_.Id.Guid -Force}
