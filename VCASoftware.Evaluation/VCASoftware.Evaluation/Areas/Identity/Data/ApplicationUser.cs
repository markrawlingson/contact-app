using Microsoft.AspNetCore.Identity;

namespace VCASoftware.Evaluation.Areas.Identity.Data;

public class ApplicationUser : IdentityUser
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string ProfilePicture { get; set; }
}