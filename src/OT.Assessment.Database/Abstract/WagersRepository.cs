﻿using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using OT.Assessment.Database.Tables;
using OT.Assessment.Database.Helper;
using OT.Assessment.Database.Interface;
using OT.Assessment.Model;
using OT.Assessment.Database.DTO;
using System.Transactions;

namespace OT.Assessment.Database.Abstract
{
    public class WagersRepository : IWagers
    {
        private readonly ILogger<WagersRepository> _logger;
        private readonly IDatabaseConnection _databaseConnection;
        public WagersRepository(ILogger<WagersRepository> logger, IDatabaseConnection databaseConnection)
        {
            _logger = logger;
            _databaseConnection = databaseConnection;
        }
        // Get all wagers using stored procedure
        public async Task<IEnumerable<PlayerWagers>> GetAllWagersAsync()
        {
            try
            {
                using (var connection = _databaseConnection.CreateConnection())
                {
                    var wagers = await connection.QueryAsync<Wagers>("sp_GetAllWages", commandType: CommandType.StoredProcedure);
                    _logger.LogInformation($"{DateTime.Now}- {nameof(WagersRepository)} - {nameof(GetAllWagersAsync)} - {wagers.Count()} retrieved.");
                    return PlayerWagerMapper.ListMapTo(wagers);
                }
            }
            catch (SqlException ex)
            {
                _logger.LogError($"{DateTime.Now} - SQL Exception: {nameof(WagersRepository)} - {nameof(GetAllWagersAsync)} - {ex.Message}");
                throw new Exception("An error occurred while retrieving the wagers. Please try again later.");
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagersRepository)} - {nameof(GetAllWagersAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
        public async Task<AddCasinoWagerResponse> PlayerWagerAsync(AddCasinoWagerRequest addCasinoWager)
        {
            try
            {
                using (var connection = _databaseConnection.CreateConnection())
                {
                    _logger.LogInformation($"{DateTime.Now} - {nameof(WagersRepository)} - {nameof(PlayerWagerAsync)} - attempting to add new wager for {addCasinoWager.Username}.");

                    // Generate new wager (GUID)
                    var newWagerId = Guid.NewGuid();
                    object parameters = CreateCasinoWagerParameter(addCasinoWager, newWagerId);

                    // Execute the stored procedure and retrieve the same response back
                    var addWager = await connection.QuerySingleOrDefaultAsync<AddCasinoWagerResponse?>(
                        "sp_AddWager",
                        parameters,
                        commandType: CommandType.StoredProcedure
                    );

                    _logger.LogInformation($"{DateTime.Now} - {nameof(WagersRepository)} - {nameof(PlayerWagerAsync)} - wager added with ID {addWager.WagerId}.");

                    // Return the new wager
                    return addWager;
                }
            }
            catch (SqlException ex)
            {
                _logger.LogError($"{DateTime.Now} - SQL Exception: {nameof(WagersRepository)} - {nameof(PlayerWagerAsync)} - {ex.Message}");
                throw new Exception("An error occurred while adding a wager. Please try again later.");
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagersRepository)} - {nameof(PlayerWagerAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
        private static object CreateCasinoWagerParameter(AddCasinoWagerRequest addCasinoWager, Guid newWagerId)
        {
            return new
            {
                WagerId = newWagerId,
                Theme = addCasinoWager.Theme,
                ProviderName = addCasinoWager.ProviderName,
                GameName = addCasinoWager.GameName,
                Username = addCasinoWager.Username,
                TransactionType = addCasinoWager.TransactionType,
                Amount = addCasinoWager.Amount,
                CountryCode = addCasinoWager.CountryCode,
                NumberOfBets = addCasinoWager.NumberOfBets,
                SessionData = addCasinoWager.SessionData,
                Duration = addCasinoWager.Duration
            };
        }
        public async Task<PlayerWagesResponse> GetPlayerWagesAsync(Guid playerId, int page = 1, int pageSize = 10)
        {
            try
            {
                using (var connection = _databaseConnection.CreateConnection())
                {
                    PlayerWagesResponse playerWagesResponse = new PlayerWagesResponse();

                    var parameters = new
                    {
                        PlayerId = playerId,
                        Page = page,
                        PageSize = pageSize
                    };

                    var results = await connection.QueryMultipleAsync(
                                           "sp_GetPlayerWagersWithPagination",
                                           parameters,
                                           commandType: CommandType.StoredProcedure
                                       );
                    var wagers = await results.ReadAsync<ReportPlayerWager>();
                    var pagination = await results.ReadFirstAsync();

                    playerWagesResponse.data = wagers.ToList();
                    playerWagesResponse.page = pagination.Page;
                    playerWagesResponse.pageSize = pagination.PageSize;
                    playerWagesResponse.total = pagination.Total;
                    playerWagesResponse.totalPages = pagination.TotalPages;

                    _logger.LogInformation($"{DateTime.Now}- {nameof(WagersRepository)} - {nameof(GetPlayerWagesAsync)} - {wagers.Count()} retrieved.");

                    return playerWagesResponse;
                }
            }
            catch (SqlException ex)
            {
                _logger.LogError($"{DateTime.Now} - SQL Exception: {nameof(WagersRepository)} - {nameof(GetPlayerWagesAsync)} - {ex.Message}");
                throw new Exception("An error occurred while retrieving the wagers. Please try again later.");
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagersRepository)} - {nameof(GetPlayerWagesAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
        public async Task<IEnumerable<ReportGetTopSpenders>> GetTopSpendersAsync(int count = 10)
        {
            try
            {
                using (var connection = _databaseConnection.CreateConnection())
                {
                    IEnumerable<ReportGetTopSpenders> results = new List<ReportGetTopSpenders>();
                    var parameters = new
                    {
                        Count = count
                    };
                    results = await connection.QueryAsync<ReportGetTopSpenders>(
                                          "sp_GetTopSpenders",
                                          parameters,
                                          commandType: CommandType.StoredProcedure
                                      );
                    _logger.LogInformation($"{DateTime.Now}- {nameof(WagersRepository)} - {nameof(GetTopSpendersAsync)} - {results.Count()} retrieved.");

                    return results;
                }
            }
            catch (SqlException ex)
            {
                _logger.LogError($"{DateTime.Now} - SQL Exception: {nameof(WagersRepository)} - {nameof(GetTopSpendersAsync)} - {ex.Message}");
                throw new Exception("An error occurred while retrieving top players. Please try again later.");
            }
            catch (Exception ex)
            {
                _logger.LogError($"{DateTime.Now} - General Exception: {nameof(WagersRepository)} - {nameof(GetTopSpendersAsync)} - {ex.Message}");
                throw new Exception(Nofications.GeneralExceptionMessage);
            }
        }
    }
}
