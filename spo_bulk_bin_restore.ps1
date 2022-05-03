# This script will enumerate items in the supplied site recycle bin and output those items to a grid-view.
# Use the grid to search, filter, etc., and when confident in the results, use CTRL+A to select all.
# Click 'Ok' in the bottom right, to bulk restore the items you selected.

# Connect to the SharePoint Online Site with the deleted content 

Connect-PnPOnline https://tenantsharepointname.sharepoint.com/sites/sitename -UseWebLogin

# Example: Connect-PnPOnline https://acmesupplyco.sharepoint.com/sites/reference will connect
# to the Stage 1 RecycleBin of that site.

# Enumerate Recycle Bin Items and sort by Author, Deleted By, Deleted on or Directory
# Output items to Grid-View for bulk processing
# Folders &  files marked for restore WILL NOT overwrite items that exist.

Get-PnPRecycleBinItem  |
    Select-Object Title, ID, AuthorEmail, DeletedbyEmail, DeletedDate, DirName | 
        Out-GridView -PassThru |
            ForEach-Object { Restore-PnPRecycleBinItem -Identity $_.Id.Guid -Force}

