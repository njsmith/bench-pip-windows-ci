Set-PSDebug -Trace 1

mkdir scratch
$scratch = (Get-Item -Path scratch).FullName

mkdir scratch\tmp
$Env:TMPDIR = $scratch + "\tmp"
$Env:TMP = $scratch + "\tmp"
$Env:TEMP = $scratch + "\tmp"

mkdir scratch\pip-cache
$Env:PIP_CACHE_DIR = $scratch + "\pip-cache"

# Invoke-WebRequest -Uri "https://www.nuget.org/api/v2/package/python/3.7.2" -OutFile ($scratch + "\python.nupkg")
# nuget install $scratch + "\python.nupkg"

#ls "C:\Program Files (x86)\Microsoft SDKs\NuGetPackages\"

# Just see how long this takes
Invoke-WebRequest -Uri "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile asdf.exe
.\asdf.exe install -Help

# https://docs.python.org/3/using/windows.html#windows-nuget
nuget.exe install python -Source "https://api.nuget.org/v3/index.json" -ExcludeVersion -OutputDirectory scratch -Verbosity detailed -DirectDownload -NonInteractive

scratch\python\tools\python.exe -V

$toolsdir = (Get-Item -Path scratch\python\tools).FullName

$Env:PATH = ($toolsdir + ";" + $toolsdir + "\scripts" + ";" + $Env:PATH)
python -V

# This installer has no 'pip' script that I can find, or ensurepip, but it
# does have a pip module. So you *have* to use python -m pip. Weird.
python -m pip --version
python -m pip install -U pip
python -m pip --version

python -m pip install -r requirements.txt
