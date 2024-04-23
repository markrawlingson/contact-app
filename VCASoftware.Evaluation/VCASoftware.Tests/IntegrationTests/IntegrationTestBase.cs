using Bogus;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;
using System.Net.Http.Json;
using VCASoftware.Evaluation.Areas.Identity.Data;

namespace VCASoftware.Tests.IntegrationTests
{
    public class IntegrationTestBase : IClassFixture<WebApplicationFactory<Program>>, IDisposable
    {
        protected readonly HttpClient _client;
        protected readonly UserManager<ApplicationUser> _userManager;
        protected readonly IServiceScope _scope;

        protected Faker Faker { get; private set; }

        public IntegrationTestBase(
            WebApplicationFactory<Program> factory)
        {
            _client = factory.CreateClient();

            // Create a test server scope to resolve scoped services
            _scope = factory.Services.CreateScope();
            var serviceProvider = _scope.ServiceProvider;

            // Resolve UserManager from the service collection of the application within the scope
            _userManager = serviceProvider.GetRequiredService<UserManager<ApplicationUser>>();

            Faker = new Faker();
        }

        public async Task<bool> UserExists(string email)
        {
            return await _userManager.FindByEmailAsync(email) != null;
        }

        public async Task RegisterTestUser(string email, string password)
        {
            if (!await UserExists(email))
            {
                var user = new ApplicationUser { UserName = email, Email = email };
                var result = await _userManager.CreateAsync(user, password);
                if (!result.Succeeded)
                {
                    // Handle user creation failure
                    throw new Exception($"Failed to create test user: {result.Errors}");
                }
            }
        }

        public void Dispose()
        {
            _scope.Dispose();
            _client.Dispose();
        }
    }
}
