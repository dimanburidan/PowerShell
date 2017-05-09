function myCopyFiles-Bits
{
# Set Parameters
Param (
[Parameter(Mandatory=$true)]
[String]$Source,
[Parameter(Mandatory=$true)]
[String]$Destination
)

# Read all directories located in the sorce directory
$dirs = Get-ChildItem -Name -Path $Source -Directory -Recurse
$files = Get-ChildItem -Name -Path $Source -File
# Start Bits Transfer for all items in each directory. Create Each directory if they do not exist at destination.

$exists = Test-Path $Destination
if ($exists -eq $false) {New-Item $Destination -ItemType Directory}

foreach ($f in $files)
    {
    $srcname = $source + "\" + $f.PSChildName
    $dstname = $Destination + "\" + $f.PSChildName
    Start-BitsTransfer -Source $srcname -Destination $Destination -Description "to $dstname" -DisplayName "Copying $srcname"
    }

foreach ($d in $dirs)
    {
    $srcsubdir = $Source +"\" + $d
    $dstsubdir = $Destination + "\" + $d
    
    $exists = Test-Path $dstsubdir
    if ($exists -eq $false) {New-Item $dstsubdir -ItemType Directory}
    
    $files = Get-ChildItem -Name -Path $srcsubdir -File
    foreach ($f in $files)
        {
        $srcfilename = $srcsubdir + "\" + $f.PSChildName
        $dstfilename = $dstsubdir + "\" + $f.PSChildName
        Start-BitsTransfer -Source $srcfilename -Destination $dstsubdir -Description "to $dstfilename" -DisplayName "Copying $srcfilename"
        }
   
    }

}