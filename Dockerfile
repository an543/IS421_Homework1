#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/runtime:3.1-buster-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["IS421_Homework1_Name/IS421_Homework1_Name.csproj", "IS421_Homework1_Name/"]
RUN dotnet restore "IS421_Homework1_Name/IS421_Homework1_Name.csproj"
COPY . .
WORKDIR "/src/IS421_Homework1_Name"
RUN dotnet build "IS421_Homework1_Name.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "IS421_Homework1_Name.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "IS421_Homework1_Name.dll"]