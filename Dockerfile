FROM mcr.microsoft.com/dotnet/sdk:3.1-alpine as builder

WORKDIR /src

RUN set -eux; \
    \
    apk add --no-cache git; \
    git clone https://github.com/bbhxwl/TencentCloudHelper; \
    cd TencentCloudHelper; \
    dotnet publish -c release -o published;

FROM mcr.microsoft.com/dotnet/runtime:3.1-alpine as runtime

# Get api from https://console.cloud.tencent.com/cam/capi
ENV SecretId1=
ENV SecretKey1=

WORKDIR /usr/src/app/TencentCloudHelper

COPY --from=builder /src/TencentCloudHelper/published .

ENTRYPOINT [ "/usr/src/app/TencentCloudHelper/TencentCloudHelper" ]