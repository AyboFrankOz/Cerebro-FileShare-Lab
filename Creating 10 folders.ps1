# Define the path
$path = "C:\Shared"

# Create the main folder if it doesn't exist
if (!(Test-Path -Path $path)) {
    New-Item -ItemType Directory -Path $path
}

# Folder names
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

# Create the folders
foreach ($folder in $folders) {
    $fullPath = Join-Path $path $folder
    New-Item -ItemType Directory -Path $fullPath -Force
}