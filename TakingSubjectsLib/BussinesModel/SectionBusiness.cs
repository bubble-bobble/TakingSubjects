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
    public class SectionBusiness
    {
        #region INSERTION QUERIES
        public bool TransactionInsertNewSection(TblSection section, out string message)
        {
            bool inserted = false;
            message = string.Empty;
            if (section != null)
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
                            _context.TblSection.InsertOnSubmit(section);
                            _context.SubmitChanges();
                            if (section.sectionId > 0)
                            {
                                _context.Transaction.Commit();
                                inserted = true;
                                message = "Sección registrada correctamente.";
                            }
                            else
                            {
                                _context.Transaction.Rollback();
                                message = "No se ha podido registrar la sección";
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
