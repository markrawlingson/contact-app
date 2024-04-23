using Bogus;

namespace VCASoftware.Tests.UnitTests
{
    public class UnitTestBase
    {
        protected Faker Faker { get; private set; }

        public UnitTestBase()
        {
            Faker = new Faker();
        }
    }
}
