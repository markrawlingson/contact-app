using System.Linq.Expressions;

namespace VCASoftware.Evaluation.Repositories;

public interface IRepository<TEntity> where TEntity : class
{
    Task<TEntity> GetAsync(int id);
    Task<IEnumerable<TEntity>> GetAll();
    Task<IEnumerable<TEntity>> FindAsync(Expression<Func<TEntity, bool>> predicate);

    void Add(TEntity entity);
    void AddRange(IEnumerable<TEntity> entities);

    void Update(TEntity entity);

    void Remove(TEntity entity);
    void RemoveRange(IEnumerable<TEntity> entities);

}
