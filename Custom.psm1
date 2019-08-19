Function EnableCapsRemapToCtrl {
    Write-Output "Remapping Caps Lock to Left Ctrl"
    $hexified = "00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00".Split(",") | % { "0x$_"};
    $kbLayout = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout';
    If (!(Test-Path $kbLayout)) {
		New-Item -Path $kbLayout -Force | Out-Null
    }
    Set-ItemProperty -Path $kbLayout -Name "Scancode Map" -Type Binary -Value ([byte[]]$hexified)
}

Function DisableCapsRemapToCtrl {
    Write-Output "Restoring Caps Lock to Caps Lock"
    $kbLayout = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout';
    Remove-ItemProperty -Path $kbLayout -Name "Scancode Map" -ErrorAction SilentlyContinue
}

Function InstallUsefulMsftSoftware {
    Write-Output "Installing Photos and Get Started"
	Get-AppxPackage -AllUsers "Microsoft.Windows.Photos" | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppxPackage -AllUsers "Microsoft.Getstarted" | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
}

Function UninstallUsefulMsftSoftware {
    Write-Output "Uninstalling Photos and Get Started"
	Get-AppxPackage "Microsoft.Windows.Photos" | Remove-AppxPackage
	Get-AppxPackage "Microsoft.Getstarted" | Remove-AppxPackage
}