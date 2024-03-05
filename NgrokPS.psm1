function Connect-Ngrok {
    param (
        [Parameter(Mandatory = $true)]
        [uint16]
        $TargetPort,
        [Parameter(Mandatory = $false)]
        [string]
        $HostProfile = $null,
        [Parameter(Mandatory = $false)]
        [string]
        $NgrokRegion = "eu",
        [Parameter(Mandatory = $false)]
        [switch]
        $ForceProfileOverwrite = $false,
        [Parameter(Mandatory = $false)]
        [ValidateSet("http", "https")]
        [string]
        $HttpProtocol = "https"
    )

    $oldErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Stop"

    try {
        try {
            Import-Module CredentialManager
        }
        catch {
            Write-Warning "CredentialManager module not found. Please install it from the PSGallery"
            throw "CredentialManager Module not installed."
        }

        if ([string]::IsNullOrWhiteSpace($HostProfile)) {
            if ([string]::IsNullOrWhiteSpace($env:NGROKPS_DEFAULT_PROFILE)) {
                throw "No Profile provided and no value configured in NGROKPS_DEFAULT_PROFILE environment variable."
            }
            $HostProfile = $env:NGROKPS_DEFAULT_PROFILE;
        }

        $credentialTarget = "ngrokps:$($HostProfile.ToLower())"

        $authCredentials = Get-StoredCredential -Target $credentialTarget
        if ($null -eq $authCredentials -or $ForceProfileOverwrite) {
            Write-Warning "No Profile $HostProfile found. Creating..."

            if($PSVersionTable.PSVersion -gt [version]::new("6.0.0")){
                throw "Profile creation only supported with PowerShell 5.X due to CredentialManager not supporting PowerShell >6.0.0 for creating stored credentials. Please create teh Stored credentials manually or re run this command with PowerShell 5.X"
            }

            $authCredentials = Get-Credential -Message "Please set the hostname and password for the Ngrok Profile $HostProfile"
            New-StoredCredential -Target $credentialTarget -Credentials $authCredentials -Persist Enterprise
        }

        $hostName = $authCredentials.UserName
        $ngrokToken = $authCredentials.GetNetworkCredential().Password
        ngrok.exe config add-authtoken $ngrokToken
        ngrok.exe http --region=$NgrokRegion --hostname=$hostName "$($HttpProtocol)://localhost:$($TargetPort)"
    }
    catch {
        throw;
    }
    finally {
        $ErrorActionPreference = $oldErrorActionPreference
    }
}