# Steve Dower suggested that using a venv might make things faster on Azure,
# so we'll try it both ways.
# https://twitter.com/zooba/status/1078548597195497472
param([switch] $UseVenv)

Set-PSDebug -Trace 1

# None of this seems to help, alas:
# Get-MpPreference
# # https://superuser.com/a/1026449
# Set-MpPreference -DisableRealtimeMonitoring $true
# Set-MpPreference -DisableRealtimeMonitoring $false
# Get-MpPreference
# # Get-Service WinDefend | stop-service

Invoke-WebRequest -Uri "http://www.ltr-data.se/files/imdiskinst.exe" -OutFile imdiskinst.exe
.\imdiskinst.exe /fullsilent

imdisk

refreshenv

Add-MpPreference -ExclusionPath "r:\"

python -m venv r:\myenv
r:\myenv\Scripts\activate

python -m pip install -U pip

python --version
python -c "import struct; print(struct.calcsize('P') * 8, 'bits')"
pip --version

pip install -r requirements.txt