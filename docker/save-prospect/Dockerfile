# escape=`
FROM dockersamples/modernize-aspnet-builder AS builder

COPY src\ProductLaunch\ C:\src
WORKDIR C:\src\ProductLaunch.MessageHandlers.SaveProspect
RUN ["powershell", ".\\build.ps1"]

# app image
FROM microsoft/windowsservercore:10.0.14393.1715
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR C:\save-prospect-handler
ENV MESSAGE_QUEUE_URL="nats://message-queue:4222"
ENTRYPOINT ["C:\\save-prospect-handler\\ProductLaunch.MessageHandlers.SaveProspect.exe"]

COPY --from=builder C:\out .