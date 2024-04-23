namespace VCASoftware.Evaluation.Models
{
    public class Entity : IEntity
    {
        public string Id { get; set; }
        public DateTime Created { get; set; } = DateTime.Now;
        public DateTime LastUpdated { get; set; } = DateTime.Now;
    }
}
