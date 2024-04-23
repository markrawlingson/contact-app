namespace VCASoftware.Evaluation.Models
{
    public class Session
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string Value { get; set; }
        public DateTime Expires { get; set; }
    }
}
