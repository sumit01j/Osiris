using OT.Assessment.Consumer.Factory;
using OT.Assessment.Consumer.Interface;
using OT.Assessment.Database.Interface;
using OT.Assessment.Model;
using RabbitMQ.Client;
using System.Text;
using System.Text.Json;

public class RabbitMQConsumerService : IRabbitMQConsumer, IDisposable
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<RabbitMQConsumerService> _logger;
    private readonly IRabbitMQConsumerFactory _consumerFactory;
    private readonly IConnection _connection;
    private readonly IModel _wagerChannel;

    public RabbitMQConsumerService(
        IServiceProvider serviceProvider,
        ILogger<RabbitMQConsumerService> logger,
        IRabbitMQConsumerFactory consumerFactory,
        IConnection connection,
        IModel wagerChannel)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
        _consumerFactory = consumerFactory;
        _connection = connection;
        _wagerChannel = wagerChannel;
    }


    public Task ConsumeWagerQueueAsync(CancellationToken stoppingToken)
    {
        return _consumerFactory.CreateConsumerAsync(Queues.WagerQueue, _wagerChannel, async ea =>
        {
            var body = ea.Body.ToArray();
            var message = Encoding.UTF8.GetString(body);
            _logger.LogInformation($"Message content: {message}");

            try
            {
                var wager = JsonSerializer.Deserialize<AddCasinoWagerRequest>(message);

                using (var scope = _serviceProvider.CreateScope())
                {
                    var wagerManager = scope.ServiceProvider.GetRequiredService<IWagers>();
                    await wagerManager.PlayerWagerAsync(wager);
                }

                _logger.LogInformation($"Wager for {wager.Username} saved to the database.");
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error processing message: {ex.Message}");
            }
        }, stoppingToken);
    }

    public void Dispose()
    {
        _wagerChannel?.Close();
        _connection?.Close();
    }
}
