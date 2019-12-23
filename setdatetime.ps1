$culture = Get-Culture
$culture.DateTimeFormat.ShortDatePattern = 'd-MM-yyyy'
Set-Culture $culture