using VCASoftware.Evaluation.Models;

namespace VCASoftware.Evaluation.Repositories
{
    public interface ISessionRepository : IRepository<Session>
    {
        Task<string> Store(HttpContext httpContext);
    }
}
