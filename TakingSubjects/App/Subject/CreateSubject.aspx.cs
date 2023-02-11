using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.BusinessModel;
using TakingSubjectsLib.BussinesModel;
using TakingSubjectsLib.DataModel;

namespace TakingSubjects.App.Subject
{
    public partial class CreateSubject : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private SubjectBusiness _subject_business = new SubjectBusiness();
        private const string ACCESS = "Subject.CreateSubject";
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
                        MaxLengthDescription();
                    }
                }
            }
        }
        #endregion

        #region FORM METHODS
        protected TblSubject GetSubjectData()
        {
            TblSubject subject = new TblSubject()
            {
                subjectId = -1,
                subjectName = TxtName.Text.Trim(),
                subjectDescription = TxtDescription.Text.Trim(),
                subjectPeriod = DdlPeriod.SelectedValue
            };
            return subject;
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            Page.Validate("Subject");
            if (Page.IsValid)
            {
                if (_subject_business.TransactionInsertNewSubject(GetSubjectData(), out string operationMessage))
                {
                    ImgOperation.ImageUrl = "~/Resources/ok.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = operationMessage;
                    LtlMessage.Visible = true;
                    UpModal.Update();
                    ClearForm();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                }
                else
                {
                    ImgOperation.ImageUrl = "~/Resources/error.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = operationMessage;
                    LtlMessage.Visible = true;
                    UpModal.Update();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                }
            }
        }
        #endregion

        #region UTILITIES
        protected void ClearForm()
        {
            TxtName.Text = string.Empty;
            TxtDescription.Text = string.Empty;
            DdlPeriod.SelectedValue = "-1";
        }

        protected void MaxLengthDescription()
        {
            TxtDescription.Attributes["maxlength"] = "200";
        }
        #endregion
    }
}