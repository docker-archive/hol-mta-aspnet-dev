$nuGetPath = "C:\Chocolatey\bin\nuget.bat"
$msBuildPath = "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"

& $nuGetPath restore ..\ProductLaunch.sln -PackagesDirectory ..\packages

& $msBuildPath .\ProductLaunch.Web.csproj /p:OutputPath=c:\out /p:DeployOnBuild=true /p:VSToolsPath=C:\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\tools\VSToolsPath
