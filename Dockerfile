FROM mcr.microsoft.com/dotnet/aspnet:3.0 AS base
WORKDIR /app
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:3.0 AS build
WORKDIR /src
COPY ["hello.csproj", "./"]
RUN dotnet restore "./hello.csproj"
COPY . .
RUN dotnet build "hello.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "hello.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "hello.dll"]
