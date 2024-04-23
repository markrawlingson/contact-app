using Bogus;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Testing;
using System.Net;
using VCASoftware.Evaluation.Areas.Identity.Data;

namespace VCASoftware.Tests.IntegrationTests
{
    public class LoginTests : IntegrationTestBase
    {
        public LoginTests(
            WebApplicationFactory<Program> factory) : base(factory)
        {
        }

        [Fact]
        public async Task OnGet_ReturnsLoginPage()
        {
            // Act
            var response = await _client.GetAsync("/Identity/Account/Login");

            // Assert
            response.EnsureSuccessStatusCode(); // Status Code 200-299
            Assert.Equal("text/html; charset=utf-8", response.Content.Headers?.ContentType?.ToString());
        }

        [Fact]
        public async Task OnPost_ValidCredentials_RedirectsToContacts()
        {
            // Arrange
            var email = Faker.Internet.Email();
            var password = Faker.Internet.Password();

            // Ensure the user exists
            await RegisterTestUser(email, password);

            var loginData = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("Input.Email", email),
                new KeyValuePair<string, string>("Input.Password", password),
                new KeyValuePair<string, string>("Input.RememberMe", "true")
            });

            // Act
            var response = await _client.PostAsync("/Identity/Account/Login", loginData);

            // Assert
            Assert.Equal(HttpStatusCode.Redirect, response.StatusCode);
            Assert.Equal("/contacts", response.Headers?.Location?.OriginalString);
        }

        [Fact]
        public async Task OnPost_InvalidCredentials_ReturnsLoginPageWithErrorMessage()
        {
            // Arrange
            var loginData = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("Input.Email", "invalid@email.com"),
                new KeyValuePair<string, string>("Input.Password", "invalidPassword"),
                new KeyValuePair<string, string>("Input.RememberMe", "false")
            });

            // Act
            var response = await _client.PostAsync("/Identity/Account/Login", loginData);
            var content = await response.Content.ReadAsStringAsync();

            // Assert
            response.EnsureSuccessStatusCode(); // Status Code 200-299
            Assert.Contains("Invalid login attempt.", content);
        }

        [Fact]
        public async Task OnPost_InvalidModelState_ReturnsLoginPage()
        {
            // Arrange
            var loginData = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("Input.Email", ""),
                new KeyValuePair<string, string>("Input.Password", ""),
                new KeyValuePair<string, string>("Input.RememberMe", "false")
            });

            // Act
            var response = await _client.PostAsync("/Identity/Account/Login", loginData);

            // Assert
            response.EnsureSuccessStatusCode(); // Status Code 200-299
            Assert.Equal("text/html; charset=utf-8", response.Content.Headers?.ContentType?.ToString());
        }

    }
}