using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TakingSubjectsLib.BusinessModel.Enums;
using TakingSubjectsLib.DataModel;
using TakingSubjectsLib.Utilities;

namespace TakingSubjectsLib.BussinesModel
{
    public class UserBusiness
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

        #region USER SEARCH QUERIES
        public bool UserExistByRut(string rut, out string message)
        {
            bool result = false;
            message = string.Empty;
            using (TakingSubjectsDataContext _context = new TakingSubjectsDataContext(Connector.ConnectionString))
            {
                result = _context.TblUser.Any(x => x.rut.Equals(rut) && x.roleId == Convert.ToInt32(UserRoles.Student));
                if (result)
                {
                    message = "El usuario que intentas registrar, ya existe en el sistema.";
                }
            }
            return result;
        }

        public List<StoredProcedureGetStudentInfoAboutSubjectsTakenByRutResult> GetStudentInfoByRut(string rut, int roleId)
        {
            using (TakingSubjectsProceduresDataContext _context = new TakingSubjectsProceduresDataContext(Connector.ConnectionString))
            {
                return _context.StoredProcedureGetStudentInfoAboutSubjectsTakenByRut(rut, roleId).ToList();
            }
        }
        #endregion

        #region INSERTION QUERIES
        public bool TransactionInsertNewStudent(TblUser user, out string message)
        {
            bool inserted = false;
            message = string.Empty;
            if (user != null)
            {
                using (TakingSubjectsDataContext _context = new TakingSubjectsDataContext(Connector.ConnectionString))
                {
                    if (_context.Connection.State == ConnectionState.Closed)
                    {
                        _context.Connection.Open();
                    }
                    using (_context.Transaction = _context.Connection.BeginTransaction())
                    {
                        try
                        {
                            _context.TblUser.InsertOnSubmit(user);
                            _context.SubmitChanges();
                            if (user.userId > 0)
                            {
                                _context.Transaction.Commit();
                                inserted = true;
                                message = "Alumno registrado correctamente.";
                            }
                            else
                            {
                                _context.Transaction.Rollback();
                                message = "No se ha podido registrar el alumno.";
                            }
                        }
                        catch (Exception e)
                        {
                            _context.Transaction.Rollback();
                            message = e.Message;
                        }
                    }
                    if (_context.Connection.State == ConnectionState.Open)
                    {
                        _context.Connection.Close();
                    }
                }
            }
            return inserted;
        }
        #endregion
    }
}
