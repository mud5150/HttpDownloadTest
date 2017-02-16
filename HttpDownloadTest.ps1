param(
    $fileUri = "https://go.microsoft.com/fwlink/?LinkID=623231",
    $fileName = 'test.1.0.zip'
)

[double[]]$timingList = @()

$webClient = New-Object -TypeName System.Net.WebClient

for ($i=1; $i -le 5; $i++){
    $elapsedTime = Measure-Command {
        $webClient.DownloadFile($fileUri, $fileName)
    }

    $timingList += $elapsedTime.TotalSeconds
    Write-Host ("Run {0}: Downloading {1} took {2} seconds from {3}." -f $i,$fileName,$elapsedTime.TotalSeconds,$fileUri)
    Start-Sleep -Seconds 2
}

$avg = ($timingList | Measure-Object -Average).Average
$max = ($timingList | Sort-Object -Descending)[0]
Write-Host ("Avg DL Time: {0}" -f $avg)
Write-Host ("Max DL Time: {0}" -f $max)