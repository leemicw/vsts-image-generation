function Install-MSI
{
    Param
    (
        [String]$MsiUrl,
        [String]$MsiName
    )

    $exitCode = -1

    try
    {
        Write-Host "Downloading $MsiName..."
        $FilePath = "${env:Temp}\$MsiName"

        Invoke-WebRequest -Uri $MsiUrl -OutFile $FilePath

        $Arguments = ('/i', $FilePath, '/QN', '/norestart' )

        Write-Host "Starting Install $MsiName..."
        $process = Start-Process -FilePath msiexec.exe -ArgumentList $Arguments -Wait -PassThru
        $exitCode = $process.ExitCode

        if ($exitCode -eq 0 -or $exitCode -eq 3010)
        {
            Write-Host -Object 'Installation successful'
            return $exitCode
        }
        else
        {
            Write-Host -Object "Non zero exit code returned by the installation process : $exitCode."
            exit $exitCode
        }
    }
    catch
    {
        Write-Host -Object "Failed to install the MSI $MsiName"
        Write-Host -Object $_.Exception.Message
        exit -1
    }
}