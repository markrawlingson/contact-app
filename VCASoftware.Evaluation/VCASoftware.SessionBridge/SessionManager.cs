using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Caching.SqlServer;
using System.Runtime.InteropServices;

namespace VCASoftware.SessionBridge
{
    public class CacheManager
    {
        private SqlServerCache? _cache;

        public void Initialize()
        {
            var options = new SqlServerCacheOptions
            {
                ConnectionString = "Server=localhost;Database=contact-app;UID=dev;PWD=!Q2w3e4r;Connection Timeout=30;",
                SchemaName = "dbo",
                TableName = "Sessions"
            };

            _cache = new SqlServerCache(options);
        }

        [ComVisible(true)]
        public string Get()
        {
            return _cache.GetString("UserId");
        }
    }
}