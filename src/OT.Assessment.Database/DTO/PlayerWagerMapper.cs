using OT.Assessment.Database.Tables;
using OT.Assessment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OT.Assessment.Database.DTO
{
    public static class PlayerWagerMapper
    {
        public static PlayerWagers MapTo(Wagers wagers)
        {
            return new PlayerWagers
            {
                WagerId = wagers.WagerId,
                Theme=wagers.Theme,
                Provider=wagers.Provider,
                GameName=wagers.GameName,
                TransactionId = wagers.TransactionId,
                BrandId=wagers.BrandId,
                AccountId = wagers.AccountId,
                UserName = wagers.UserName,
                ExternalReferenceId = wagers.ExternalReferenceId,
                TransactionTypeId = wagers.TransactionTypeId,
                Amount = wagers.Amount,
                DateCreated = wagers.DateCreated,
                NumberOfBets = wagers.NumberOfBets,
                CountryCode = wagers.CountryCode,
                SessionData = wagers.SessionData,
                Duration = wagers.Duration
            };
        }

        public static List<PlayerWagers> ListMapTo(IEnumerable<Wagers> wagers)
        {
            return wagers.ToList().ConvertAll(new Converter<Wagers, PlayerWagers>(MapTo));
        }
    }
}
