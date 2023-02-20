using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TakingSubjectsLib.BusinessModel.Enums
{
    public enum RegistrationOperationResult
    {
        Success = 1,
        Failure = 2,
        AlredyRegistered = 3,
        FullQuota = 4
    }
}
