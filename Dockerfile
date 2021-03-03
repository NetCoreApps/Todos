FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source

COPY . .
RUN dotnet restore ./src/Todos/

WORKDIR /source/src
RUN dotnet publish ./Todos.sln -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "Todos.dll"]
