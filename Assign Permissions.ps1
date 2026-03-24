# Base folder path
$basePath = "C:\Shared"

# List of folders / groups
$folders = @(
    "Executive",
    "Finance",
    "HR",
    "Marketing",
    "Operations",
    "Sales",
    "Security",
    "Technology",
    "All Employees",
    "Helpdesk"
)

# Special groups
$helpdeskGroup = "Helpdesk"
$executiveGroup = "Executive"

foreach ($folder in $folders) {
    $fullPath = Join-Path $basePath $folder

    # Create SMB Share
    if (-not (Get-SmbShare -Name $folder -ErrorAction SilentlyContinue)) {
        New-SmbShare -Name $folder -Path $fullPath -FullAccess "Administrators"
    }

    # Remove default permissions (optional cleanup)
    Revoke-SmbShareAccess -Name $folder -AccountName "Everyone" -Force -ErrorAction SilentlyContinue

    # Grant folder-specific group access (Read + Change)
    Grant-SmbShareAccess -Name $folder -AccountName $folder -AccessRight Change -Force

    # Grant Helpdesk Full Control to all folders
    Grant-SmbShareAccess -Name $folder -AccountName $helpdeskGroup -AccessRight Full -Force

    # Grant Executive Read + Change to all folders
    Grant-SmbShareAccess -Name $folder -AccountName $executiveGroup -AccessRight Change -Force
}