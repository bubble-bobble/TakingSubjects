using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TakingSubjectsLib.BusinessModel.Enums;
using TakingSubjectsLib.DataModel;
using TakingSubjectsLib.Utilities;

namespace TakingSubjectsLib.BusinessModel
{
    public class RegistrationBusiness
    {
        #region INSERTION QUERIES
        public int TransactionInsertNewRegistration(TblRegistration registration, out string message)
        {
            int operationResult = Convert.ToInt32(RegistrationOperationResult.Failure);
            message = string.Empty;
            if (registration != null)
            {
                using (TakingSubjectsDataContext _context = new TakingSubjectsDataContext(Connector.ConnectionString))
                {
                    if (_context.TblSection.Any(x => x.sectionId == registration.sectionId && x.quota == x.totalRegistered))
                    {
                        operationResult = Convert.ToInt32(RegistrationOperationResult.FullQuota);
                        message = "La sección está llena, no puedes inscribirte en ella.";
                    }
                    else
                    {
                        if (_context.TblRegistration.Any(x => x.sectionId == registration.sectionId && x.userId == registration.userId))
                        {
                            operationResult = Convert.ToInt32(RegistrationOperationResult.AlredyRegistered);
                            message = "Ya has tomado esta asignatura, no puedes volver a inscribirte.";
                        }
                        else
                        {
                            TblSection section = _context.TblSection.FirstOrDefault(x => x.sectionId == registration.sectionId);
                            if (_context.Connection.State == ConnectionState.Closed)
                            {
                                _context.Connection.Open();
                            }
                            using (_context.Transaction = _context.Connection.BeginTransaction())
                            {
                                try
                                {
                                    section.totalRegistered++;
                                    _context.SubmitChanges();
                                    _context.TblRegistration.InsertOnSubmit(registration);
                                    _context.SubmitChanges();
                                    if (registration.registrationId > 0)
                                    {
                                        _context.Transaction.Commit();
                                        operationResult = Convert.ToInt32(RegistrationOperationResult.Success);
                                        message = "Toma de asignatura hecha correctamente.";
                                    }
                                    else
                                    {
                                        _context.Transaction.Rollback();
                                        message = "No se ha podido tomar la asignatura correctamente.";
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
                }
            }
            return operationResult;
        }
        #endregion
    }
}
