using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TakingSubjectsLib.DataModel;
using TakingSubjectsLib.Utilities;

namespace TakingSubjectsLib.BussinesModel
{
    public class SubjectBusiness
    {
        #region INSERTION QUERIES
        public bool TransactionInsertNewSubject(TblSubject subject, out string message)
        {
            bool inserted = false;
            message = string.Empty;
            if (subject != null)
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
                            _context.TblSubject.InsertOnSubmit(subject);
                            _context.SubmitChanges();
                            if (subject.subjectId > 0)
                            {
                                _context.Transaction.Commit();
                                inserted = true;
                                message = "Asignatura registrada correctamente.";
                            }
                            else
                            {
                                _context.Transaction.Rollback();
                                message = "No se ha podido registrar la asignatura.";
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
