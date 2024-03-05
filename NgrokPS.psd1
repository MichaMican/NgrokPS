@{
    RootModule        = "NgrokPS.psm1"
    ModuleVersion     = "2.0.0"
    GUID              = "b1256c81-324d-43a2-b77a-8010dc087af0"
    Author            = "Michael Mican"
    Copyright         = "Copyright 2024 Michael Mican"
    Description       = "PowerShell module to use Ngrok w/ Powershellcommandlets"
    RequiredModules   = @("CredentialManager")
    FunctionsToExport = @("Connect-Ngrok")
}