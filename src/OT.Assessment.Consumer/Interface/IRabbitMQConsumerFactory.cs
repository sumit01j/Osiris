using RabbitMQ.Client.Events;
using RabbitMQ.Client;

namespace OT.Assessment.Consumer.Interface
{
    public interface IRabbitMQConsumerFactory
    {
        Task CreateConsumerAsync(string queueName, IModel channel, Func<BasicDeliverEventArgs, Task> messageHandler, CancellationToken stoppingToken);
    }
}
