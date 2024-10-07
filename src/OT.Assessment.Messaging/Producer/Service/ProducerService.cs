﻿using Microsoft.Extensions.Logging;
using OT.Assessment.Messaging.Producer.Interface;
using OT.Assessment.Model;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace OT.Assessment.Messaging.Producer.Service
{
    public class ProducerService : IProducerService
    {
        private readonly IConnection _rabbitMQConnection;
        private static readonly object _lockObject = new object();  // Thread lock object
        private readonly ILogger<ProducerService> _logger;
        public ProducerService(ILogger<ProducerService> logger, IConnection rabbitMQConnection)
        {
            _logger = logger;
            _rabbitMQConnection = rabbitMQConnection;
        }       
        public async Task PublishToWagerQueueAsync(AddCasinoWagerRequest addCasinoWager)
        {
            try
            {
                await Task.Run(() =>
                {
                    // Simulate concurrency by locking critical section
                    lock (_lockObject)
                    {
                        // Serialize the wager object to JSON
                        var accountJson = JsonSerializer.Serialize(addCasinoWager);
                        _logger.LogInformation($"{DateTime.Now} - {nameof(ProducerService)} - {nameof(PublishToWagerQueueAsync)} - producer for country queue initiated.");

                        // Create a channel and declare a queue
                        using var channel = _rabbitMQConnection.CreateModel();
                        channel.QueueDeclare(queue: Queues.WagerQueue, durable: false, exclusive: false, autoDelete: false, arguments: null);

                        // Send the message to the queue
                        var body = Encoding.UTF8.GetBytes(accountJson);
                        channel.BasicPublish(exchange: "", routingKey: Queues.WagerQueue, basicProperties: null, body: body);
                        _logger.LogInformation($"{DateTime.Now} - {nameof(ProducerService)} - {nameof(PublishToWagerQueueAsync)} - message wager for {addCasinoWager.Username} submitted to the queue.");

                        // Simulate some additional processing
                        Thread.Sleep(100);  // Sleep to simulate I/O operation latency
                    }
                });
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(ProducerService)} - {nameof(PublishToWagerQueueAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
    }
}
