using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TakingSubjectsLib.Utilities
{
    public static class Connector
    {
        public static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["AppConnectionString"].ConnectionString;
            }
        }
    }
}
