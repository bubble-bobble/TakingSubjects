using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.BusinessModel;
using TakingSubjectsLib.BusinessModel.Enums;
using TakingSubjectsLib.BussinesModel;
using TakingSubjectsLib.DataModel;

namespace TakingSubjects.App.Subject
{
    public partial class TakeSubject : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private SubjectBusiness _subject_business = new SubjectBusiness();
        private RegistrationBusiness _registration_business = new RegistrationBusiness();
        private const string ACCESS = "Subject.TakeSubject";
        #endregion

        #region PAGE_LOAD METHOD
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["UserData"] == null)
                {
                    Session.Abandon();
                    FormsAuthentication.SignOut();
                    FormsAuthentication.RedirectToLoginPage();
                }
                else
                {
                    List<StoredProcedureAccessToModulesByRoleResult> list = Session["AccessData"] as List<StoredProcedureAccessToModulesByRoleResult>;
                    if (!list.Any(x => x.NAME_MODU_OPE.Equals(ACCESS)))
                    {
                        Response.Redirect(string.Format("~/App/Unauthorized"), true);
                    }
                    else
                    {
                        BindAllSubjectsToTake();

                    }
                }
            }
        }
        #endregion

        #region BIND DATA
        protected void BindAllSubjectsToTake()
        {
            List<StoredProcedureGetAllSubjectsToTakeResult> list = _subject_business.GetAllSubjectsToTake();
            GvSubjectsToTake.DataSource = list;
            GvSubjectsToTake.DataBind();
        }
        #endregion

        #region FORM METHODS
        protected int GetUserId()
        {
            TblUser user = Session["UserData"] as TblUser;
            return user.userId;
        }

        protected TblRegistration GetregistrationData(int sectionId)
        {
            TblRegistration registration = new TblRegistration()
            {
                registrationId = -1,
                registrationDate = DateTime.Now,
                sectionId = sectionId,
                userId = GetUserId()
            };
            return registration;
        }
        #endregion

        #region CONTROL METHODS
        protected void GvSubjectsToTake_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView gridView = sender as GridView;
            int index = Convert.ToInt32(e.CommandArgument);
            int sectionId = Convert.ToInt32(gridView.DataKeys[index].Value);
            switch (e.CommandName)
            {
                case "TakeSubject":
                    ExecuteTheOperation(sectionId);
                    break;
                default:
                    break;
            }
        }

        protected void ExecuteTheOperation(int sectionId)
        {
            int operationResult = _registration_business.TransactionInsertNewRegistration(GetregistrationData(sectionId), out string operationMessage);
            switch (operationResult)
            {
                case (int)RegistrationOperationResult.Success:
                    ImgOperation.ImageUrl = "~/Resources/ok.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = operationMessage;
                    LtlMessage.Visible = true;
                    UpModal.Update();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                    break;
                case (int)RegistrationOperationResult.Failure:
                    ImgOperation.ImageUrl = "~/Resources/error.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = operationMessage;
                    LtlMessage.Visible = true;
                    UpModal.Update();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                    break;
                case (int)RegistrationOperationResult.AlredyRegistered:
                    ImgOperation.ImageUrl = "~/Resources/warning.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = operationMessage;
                    LtlMessage.Visible = true;
                    UpModal.Update();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                    break;
                case (int)RegistrationOperationResult.FullQuota:
                    ImgOperation.ImageUrl = "~/Resources/warning.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = operationMessage;
                    LtlMessage.Visible = true;
                    UpModal.Update();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                    break;
                default:
                    break;
            }
        }

        protected void BtnRebindTable_Click(object sender, EventArgs e)
        {
            BindAllSubjectsToTake();
            UpSubjectsToTake.Update();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('hide');", true);
        }
        #endregion
    }
}