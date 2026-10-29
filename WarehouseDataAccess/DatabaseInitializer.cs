using DbUp;
using Microsoft.Extensions.Logging;
using System.Reflection;

namespace WarehouseDataAccess;

public static class DatabaseInitializer
{
    public static void Initialize(string? connectionString, ILogger logger)
    {
        if (string.IsNullOrWhiteSpace(connectionString))
        {
            logger.LogError("Connection string is missing.");
            return;
        }

        EnsureDatabase.For.SqlDatabase(connectionString);

        var upgrader = DeployChanges.To
            .SqlDatabase(connectionString)
            .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly()) 
            .LogToConsole()
            .Build();

        var result = upgrader.PerformUpgrade();

        if (result.Successful)
        {
            logger.LogInformation("Database and tables were built successfully.");
        }
        else
        {
            logger.LogError(result.Error, "An error occurred while building the database.");
        }
    }
}