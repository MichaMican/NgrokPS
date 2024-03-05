# NgrokPS
PowerShell Module to simplify Ngrok connection when working with multiple auth-tokens.

# Dependencies
- [Ngrok](https://ngrok.com/download) installed and added to PATH
- [CredentialManager](https://www.powershellgallery.com/packages/CredentialManager/2.0) Module installed

# How to install
- Download the current release from the Release page or clone the repo.
- Save folder with psm1 & psd1 (NOT ZIP PACKAGE) to you PowerShell Modules folder
> NOTE: You can create a folder in your PowerShell Modules folder and directly pull the repo there - When a new update is pushed you can simply execute a `git pull` in the foulder to update then. Make sure that the .psd1 and .psm1 files are on the top level and not wrapped in multiple folders.

## Commands 
`Connect-Ngrok` - Starts a new Ngrok tunnel  
Parameters:
- `-TargetPort` - MANDATORY - uint16 - localhost target port for the ngrok tunnel
- `-HostProfile` - OPTIONAL - string - Profile name of the hostname & token combination configured. If a profile name is choosen, which does not exist yet a setup wizard is triggered to configure the Profile (only on PS 5.X)
- `-NgrokRegion` - OPTIONAL - string - region of ngrok; DEFAULT: eu
- `-ForceProfileOverwrite` - OPTIONAL - switch - Force setup dialog for profile creation (same as if Profile is choosen, which does not exist - hence only on PS 5.X)
- `-HttpProtocol` - OPTIONAL - `http` | `https` - localhost target http protocol - DEFAULT: https