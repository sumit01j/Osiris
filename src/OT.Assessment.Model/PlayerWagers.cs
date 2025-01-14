﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OT.Assessment.Model
{
    public class PlayerWagers
    {
        public Guid WagerId { get; set; }
        public string? Theme { get; set; }
        public string? Provider { get; set; }
        public string? GameName { get; set; }
        public Guid? TransactionId { get; set; }
        public Guid? BrandId { get; set; }
        public Guid? AccountId { get; set; }
        public string? UserName { get; set; }
        public Guid? ExternalReferenceId { get; set; }
        public Guid? TransactionTypeId { get; set; }

        public decimal Amount { get; set; }
        public DateTime DateCreated { get; set; }

        public int NumberOfBets { get; set; }
        public string? CountryCode { get; set; }
        public string SessionData { get; set; }
        public long Duration { get; set; }
    }
}
