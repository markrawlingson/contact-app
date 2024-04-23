using Microsoft.Extensions.Options;
using Moq;
using SendGrid.Helpers.Mail;
using SendGrid;
using VCASoftware.Evaluation.Services.Mailer;
using Bogus;

namespace VCASoftware.Tests.UnitTests
{
    public class MailerServiceTests : UnitTestBase
    {
        [Fact]
        public async Task SendEmailAsync_Success()
        {
            // Arrange
            var sendGridConfig = new SendGridConfig
            {
                ApiKey = Faker.Random.String(64),
                FromEmail = Faker.Person.Email
            };

            var optionsMock = new Mock<IOptions<SendGridConfig>>();
            optionsMock.Setup(x => x.Value).Returns(sendGridConfig);

            var sendGridClientMock = new Mock<ISendGridClient>();
            var mailerService = new MailerService(optionsMock.Object, sendGridClientMock.Object);

            var email = Faker.Person.Email;
            var subject = Faker.Random.String();
            var htmlMessage = Faker.Rant.Review();

            var expectedMessage = MailHelper.CreateSingleEmail(
                new EmailAddress(sendGridConfig.FromEmail),
                new EmailAddress(email),
                subject,
                htmlMessage,
                htmlMessage
            );

            // Expectation: SendEmailAsync is called once
            sendGridClientMock
                .Setup(s => s.SendEmailAsync(
                    It.IsAny<SendGridMessage>(),
                    It.IsAny<CancellationToken>()))
                .Verifiable();

            // Act
            await mailerService.SendEmailAsync(email, subject, htmlMessage);

            // Assert
            sendGridClientMock.Verify();
        }

        [Fact]
        public async Task SendEmailAsync_NullParameters_ThrowsException()
        {
            // Arrange
            var sendGridConfig = new SendGridConfig
            {
                ApiKey = Faker.Random.String(),
                FromEmail = Faker.Person.Email
            };

            var optionsMock = new Mock<IOptions<SendGridConfig>>();
            optionsMock.Setup(x => x.Value).Returns(sendGridConfig);

            var sendGridClientMock = new Mock<ISendGridClient>();

            var mailerService = new MailerService(optionsMock.Object, sendGridClientMock.Object);

            // Act and Assert
            await Assert.ThrowsAsync<ArgumentNullException>(async () => 
                await mailerService.SendEmailAsync(null, null, null));
        }
    }
}
