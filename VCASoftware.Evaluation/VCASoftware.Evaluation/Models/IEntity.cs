namespace VCASoftware.Evaluation.Models
{
    public interface IEntity
    {
        public string Id { get; set; }
        public DateTime Created { get; set; }
        public DateTime LastUpdated { get; set; }
    }
}
