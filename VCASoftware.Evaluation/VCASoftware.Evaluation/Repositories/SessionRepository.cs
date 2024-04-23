using Microsoft.EntityFrameworkCore;
using System.Text.Json;
using VCASoftware.Evaluation.Areas.Identity.Data;
using VCASoftware.Evaluation.Models;

namespace VCASoftware.Evaluation.Repositories
{
    public class SessionRepository : Repository<Session>, ISessionRepository
    {
        private readonly ApplicationDbContext _context;

        public SessionRepository(ApplicationDbContext context) : base(context)
        {
            _context = context;
        }

        public async Task<string> Store(HttpContext httpContext)
        {
            var packed = new Dictionary<string, object>();
            foreach (var key in httpContext.Session.Keys)
            {
                packed[key] = httpContext.Session.GetString(key);
            }

            var sessionId = Guid.NewGuid().ToString();
            _context.Sessions.Add(new Session()
            {
                Id = sessionId,
                Value = JsonSerializer.Serialize(packed),
                Expires = DateTime.Now.AddMinutes(20)
            });

            await _context.SaveChangesAsync();

            return sessionId;
        }
    }
}
