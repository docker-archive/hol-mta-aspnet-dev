# escape=`
FROM dockersamples/modernize-aspnet-builder AS builder

COPY src\ProductLaunch\ C:\src
WORKDIR C:\src\ProductLaunch.Web
RUN ["powershell", ".\\build.ps1"]

# app image
FROM microsoft/aspnet:windowsservercore-10.0.14393.1715
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR C:\web-app
RUN Remove-Website -Name 'Default Web Site'; `
    New-Website -Name 'web-app' -PhysicalPath 'C:\web-app' -Port 80 -Force

COPY --from=builder C:\out\_PublishedWebsites\ProductLaunch.Web .
COPY docker\web-v1\connection-strings.config .