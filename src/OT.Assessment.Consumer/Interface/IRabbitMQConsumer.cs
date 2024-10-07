namespace OT.Assessment.Consumer.Interface
{
    public interface IRabbitMQConsumer
    {
        Task ConsumeWagerQueueAsync(CancellationToken stoppingToken);
    }
}
