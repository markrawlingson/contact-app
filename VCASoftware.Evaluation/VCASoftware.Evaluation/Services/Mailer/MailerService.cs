using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.Extensions.Options;
using SendGrid;
using SendGrid.Helpers.Mail;
using VCASoftware.Evaluation.Helpers;

namespace VCASoftware.Evaluation.Services.Mailer
{
    /// <summary>
    /// Service for sending emails using SendGrid.
    /// </summary>
    public class MailerService : IEmailSender
    {
        private readonly ISendGridClient _sendGridClient;
        private readonly SendGridConfig _sendGridConfig;

        /// <summary>
        /// Initializes a new instance of the <see cref="MailerService"/> class.
        /// </summary>
        /// <param name="sendGridConfig">SendGrid configuration settings.</param>
        public MailerService(
            IOptions<SendGridConfig> sendGridConfig,
            ISendGridClient sendGridClient
            )
        {
            _sendGridConfig = sendGridConfig.Value;
            _sendGridClient = sendGridClient;
        }

        /// <summary>
        /// Sends an email asynchronously.
        /// </summary>
        /// <param name="email">Recipient email address.</param>
        /// <param name="subject">Email subject.</param>
        /// <param name="htmlMessage">HTML content of the email.</param>
        /// <returns>A task representing the asynchronous operation.</returns>
        public async Task SendEmailAsync(string email, string subject, string htmlMessage)
        {
            NullCheckHelper.NotNull(email, nameof(email));
            NullCheckHelper.NotNull(subject, nameof(subject));
            NullCheckHelper.NotNull(htmlMessage, nameof(htmlMessage));

            var msg = MailHelper.CreateSingleEmail(new EmailAddress(_sendGridConfig.FromEmail, _sendGridConfig.FromEmail),
                new EmailAddress(email), subject, htmlMessage, htmlMessage);

            await _sendGridClient.SendEmailAsync(msg);
        }
    }
}
