﻿using OT.Assessment.Database.Tables;
using OT.Assessment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OT.Assessment.Database.Interface
{
    public interface IWagers
    {
        Task<IEnumerable<PlayerWagers>> GetAllWagersAsync();
        Task<AddCasinoWagerResponse> PlayerWagerAsync(AddCasinoWagerRequest addCasinoWager);
        Task<PlayerWagesResponse> GetPlayerWagesAsync(Guid playerId, int page = 1, int pageSize = 10);
        Task<IEnumerable<ReportGetTopSpenders>> GetTopSpendersAsync(int count = 10);
    }
}
