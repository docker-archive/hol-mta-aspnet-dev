# escape=`
FROM dockersamples/modernize-aspnet-builder AS builder

COPY src\ProductLaunch\ C:\src
WORKDIR C:\src\ProductLaunch.Web
COPY docker\web-v3\*.aspx.cs .\
RUN ["powershell", ".\\build.ps1"]

# app image
FROM microsoft/aspnet:windowsservercore-10.0.14393.1715
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR C:\web-app
RUN Remove-Website -Name 'Default Web Site'; `
    New-Website -Name 'web-app' -PhysicalPath 'C:\web-app' -Port 80 -Force

ENV MESSAGE_QUEUE_URL="nats://message-queue:4222"

COPY docker\web-v3\bootstrap.ps1 .
ENTRYPOINT ["powershell", "./bootstrap.ps1"]

HEALTHCHECK CMD powershell -command `
    try { `
     $response = iwr http://localhost:80 -UseBasicParsing; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

COPY --from=builder C:\out\_PublishedWebsites\ProductLaunch.Web .