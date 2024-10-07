using Microsoft.Extensions.Configuration;
using OT.Assessment.Consumer;
using OT.Assessment.Consumer.Factory;
using OT.Assessment.Consumer.Interface;
using OT.Assessment.Database.Abstract;
using OT.Assessment.Database.Helper;
using OT.Assessment.Database.Interface;
using RabbitMQ.Client;

var host = Host.CreateDefaultBuilder(args)
    .ConfigureAppConfiguration(config =>
    {
        config.SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json")
            .Build();
    })
    .ConfigureServices((context, services) =>
    {
        //configure services
        var configuration = context.Configuration;

        services.AddLogging();
        // Register RabbitMQ connection as a singleton
        services.AddSingleton<IConnection>(sp =>
        {
            var factory = new ConnectionFactory()
            {
                HostName = configuration["RabbitMQ:Host"],
                UserName = configuration["RabbitMQ:UserName"],
                Password = configuration["RabbitMQ:Password"]
            };
            return factory.CreateConnection();
        });

        // Register RabbitMQ channels for account and wager processing as singletons        
        services.AddSingleton(sp =>
        {
            var connection = sp.GetRequiredService<IConnection>();
            return connection.CreateModel(); // Wager Channel
        });

        // Register Database Connection using Dapper and provide the connection string from appsettings.json
        services.AddSingleton<IDatabaseConnection>(sp =>
            new DatabaseConnection(configuration.GetConnectionString("DatabaseConnection")));

        // Register repository to interact with the database via Dapper
        services.AddSingleton<IWagers, WagersRepository>();

        // Register the RabbitMQ consumer service
        services.AddSingleton<IRabbitMQConsumer, RabbitMQConsumerService>();
        services.AddSingleton<IRabbitMQConsumerFactory, RabbitMQConsumerFactory>();

        // Add the background worker that will consume messages from the queues
        services.AddHostedService<Worker>();

    })
    .Build();

var logger = host.Services.GetRequiredService<ILogger<Program>>();
logger.LogInformation("Application started {time:yyyy-MM-dd HH:mm:ss}", DateTime.Now);

await host.RunAsync();

logger.LogInformation("Application ended {time:yyyy-MM-dd HH:mm:ss}", DateTime.Now);