using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TakingSubjectsLib.DataModel;
using TakingSubjectsLib.Utilities;

namespace TakingSubjectsLib.BussinesModel
{
    public class UserBussines
    {
        #region SYSTEM ACCESS QUERY
        public bool VerifyCredentials(string rut, string password, out TblUser user)
        {
            using (TakingSubjectsDataContext _context = new TakingSubjectsDataContext(Connector.ConnectionString))
            {
                string encryptedPassword = Encryption.Encrypt(password);
                var result = _context.TblUser.Where(x => x.rut.Equals(rut) && x.password.Equals(encryptedPassword)).FirstOrDefault();
                if (result != null)
                {
                    user = result;
                    return true;
                }
                else
                {
                    user = result;
                    return false;
                }
            }
        }

        public List<StoredProcedureAccessToModulesByRoleResult> GetAccessToModules(int roleId)
        {
            using (TakingSubjectsProceduresDataContext _context = new TakingSubjectsProceduresDataContext(Connector.ConnectionString))
            {
                return _context.StoredProcedureAccessToModulesByRole(roleId).ToList();
            }
        }
        #endregion
    }
}
