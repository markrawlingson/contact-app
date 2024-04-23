using VCASoftware.Evaluation.Areas.Identity.Data;

namespace VCASoftware.Evaluation.Models
{
    public class Contact : Entity
    {
        public ApplicationUser User { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string ProfilePicture { get; set; }
        public string Occupation { get; set; }
    }
}
