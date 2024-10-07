using Microsoft.Extensions.Logging;
using OT.Assessment.Database.Interface;
using OT.Assessment.Manager.Wagers.Interface;
using OT.Assessment.Messaging.Producer.Interface;
using OT.Assessment.Model;

namespace OT.Assessment.Manager.Wagers.Implementation
{
    public class WagerManager : IWagerManager
    {
        private readonly ILogger<WagerManager> _logger;
        private readonly IWagers _wages;
        private readonly IProducerService _producerService;

        public WagerManager(ILogger<WagerManager> logger, IWagers wages, IProducerService producerService)
        {
            _logger = logger;
            _wages = wages;
            _producerService = producerService;
        }
        public async Task<IEnumerable<PlayerWagers>> GetPlayerWagersAsync()
        {
            try
            {
                _logger.LogInformation($"{DateTime.Now} - {nameof(WagerManager)} - {nameof(GetPlayerWagersAsync)} - attempting to retrieve player wagers.");
                return await _wages.GetAllWagersAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagerManager)} - {nameof(GetPlayerWagersAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }

        public async Task<string> GlobalPlayerWagerAsync(AddCasinoWagerRequest addCasinoWager)
        {
            try
            {
                _logger.LogInformation($"{DateTime.Now} - {nameof(WagerManager)} - {nameof(GlobalPlayerWagerAsync)} - massaging switched on.");
                return await PlayerWagerAsync(addCasinoWager, true);
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagerManager)} - {nameof(GlobalPlayerWagerAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
        public async Task<AddCasinoWagerResponse> PlayerWagerAsync(AddCasinoWagerRequest addCasinoWager)
        {
            try
            {
                _logger.LogInformation($"{DateTime.Now} - {nameof(WagerManager)} - {nameof(PlayerWagerAsync)} - attempting to add player wager.");
                return await _wages.PlayerWagerAsync(addCasinoWager);
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagerManager)} - {nameof(PlayerWagerAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
        public async Task<string> PlayerWagerAsync(AddCasinoWagerRequest addCasinoWager, bool UseMassages)
        {
            try
            {
                if (UseMassages)
                {
                    await _producerService.PublishToWagerQueueAsync(addCasinoWager);
                    _logger.LogInformation($"{DateTime.Now} - {nameof(WagerManager)} - {nameof(PlayerWagerAsync)} - {Nofications.SuccessfulPublishedWagerMessage}");
                    return Nofications.SuccessfulPublishedWagerMessage;
                }
                else
                    return Nofications.MessagingIsDisabled;
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagerManager)} - {nameof(PlayerWagerAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
        public async Task<PlayerWagesResponse> GetPlayerWagesAsync(Guid playerId, int page = 1, int pageSize = 10)
        {
            try
            {
                _logger.LogInformation($"{DateTime.Now} - {nameof(WagerManager)} - {nameof(GetPlayerWagesAsync)} - attempting to get player wagers.");
                return await _wages.GetPlayerWagesAsync(playerId, page, pageSize);
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagerManager)} - {nameof(GetPlayerWagesAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
        public async Task<IEnumerable<ReportGetTopSpenders>> GetTopSpendersAsync(int count = 10)
        {
            try
            {
                _logger.LogInformation($"{DateTime.Now} - {nameof(WagerManager)} - {nameof(GetTopSpendersAsync)} - attempting to get top players.");
                return await _wages.GetTopSpendersAsync(count);
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagerManager)} - {nameof(GetTopSpendersAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
    }
}
