# dirty dirty script to quickly take epub/pdf/mobi which are in same folder and sort same 
# book title with multiple formats into a new folder with named after the book title 
# to enable multiple format import into calbire library so that there is only one listing 
# with multiple book formats 

# you can keep adding books to the base folder and re-running it over the new books and it
# continue to sort, while leaving the original books in folders alone. But for calbire, I 
# have an import folder that is used to import folders of folders of multiple same books formats

# you can blame me - phillip if you have problems with it, but actually I dont care about 
# your issues as this is just because I am lazy and it is for my book library, but you can 
# always make it better, in time i might spend more than 10 mins on it  :)

$BookPath = "<folder to organise>"
$UserPath = Resolve-Path -Path ~
$WorkingPath = Join-Path $UserPath "Documents\Books\" $BookPath

$Books = Get-ChildItem -Path $WorkingPath -File 

foreach($Book in $Books) 
{
  $Book = $Book | Select-Object Name -ExpandProperty Name 
  $parts = $Book.split(".")
  $BookFolder = Join-Path $WorkingPath $parts[0]
  if (Test-path $BookFolder) {
    Write-Output "Skipping folder creation of: $BookFolder."        
  }
  else {     
    New-Item -Path $BookFolder -ItemType Directory | Out-Null
    Write-Output "Creating folder: $BookFolder "
  }
  if (Test-path $BookFolder) {
    Move-Item -Path "$WorkingPath\$Book" -Destination "$BookFolder\$Book" | Out-Null
    Write-Output "Moving $Book to folder: $BookFolder"
  }
}

