﻿using OT.Assessment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OT.Assessment.Messaging.Producer.Interface
{
    public interface IProducerService
    {
        Task PublishToWagerQueueAsync(AddCasinoWagerRequest  addCasinoWager);
    }
}
