using Microsoft.AspNetCore.Mvc;
using OT.Assessment.Manager.Wagers.Interface;
using OT.Assessment.Model;
namespace OT.Assessment.App.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlayerController : ControllerBase
    {
        private readonly IWagerManager _wagerManager;
        public PlayerController(IWagerManager wagerManager)
        {
            _wagerManager = wagerManager;
        }

        //POST api/player/casinowager
        [HttpPost]
        [Route("casinowager")]
        public async Task<IActionResult> AddWager(AddCasinoWagerRequest addCasinoWager) => Ok(await _wagerManager.GlobalPlayerWagerAsync(addCasinoWager));


        //GET api/player/{playerId}/casino
        [HttpGet]
        [HttpGet("{playerId}/casino")]
        public async Task<IActionResult> Wagers(Guid playerId, int page = 1, int pageSize = 10) => Ok(await _wagerManager.GetPlayerWagesAsync(playerId, page, pageSize));


        //GET api/player/topSpenders?count=10        
        [HttpGet("topSpenders")]
        public async Task<IActionResult> GetTopSpenders(int count = 10) => Ok(await _wagerManager.GetTopSpendersAsync(count));
    }
}
