using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.BusinessModel;
using TakingSubjectsLib.BusinessModel.Enums;
using TakingSubjectsLib.BussinesModel;
using TakingSubjectsLib.DataModel;
using TakingSubjectsLib.Utilities;

namespace TakingSubjects.App.Student
{
    public partial class CreateStudent : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private UserBussines _user_bussines = new UserBussines();
        private const string ACCESS = "Student.CreateStudent";
        #endregion

        #region METHOD PAGE_LOAD
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
                }
            }
        }
        #endregion

        #region FORM METHODS
        protected TblUser GetUserData()
        {
            TblUser user = new TblUser()
            {
                userId = -1,
                rut = TxtRut.Text.ToUpper().Trim(),
                names = TxtNames.Text.Trim(),
                lastNames = TxtLastNames.Text.Trim(),
                phone = TxtPhone.Text.Trim(),
                password = Encryption.Encrypt(TxtRepeatPassword.Text.Trim()),
                roleId = Convert.ToInt32(UserRoles.Student)
            };
            return user;
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            Page.Validate("Student");
            if (Page.IsValid)
            {
                if (_user_bussines.UserExistByRut(TxtRut.Text.ToUpper().Trim(), out string validationMessage))
                {
                    ImgOperation.ImageUrl = "~/Resources/warning.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = validationMessage;
                    LtlMessage.Visible = true;
                    UpModal.Update();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                }
                else
                {
                    if (_user_bussines.TransactionInsertNewStudent(GetUserData(), out string operationMessage))
                    {
                        ImgOperation.ImageUrl = "~/Resources/ok.svg";
                        ImgOperation.Visible = true;
                        LtlMessage.Text = operationMessage;
                        LtlMessage.Visible = true;
                        UpModal.Update();
                        ClearForm();
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                    }
                }
            }
        }
        #endregion

        #region UTILITIES
        protected void ClearForm()
        {
            TxtRut.Text = string.Empty;
            TxtNames.Text = string.Empty;
            TxtLastNames.Text = string.Empty;
            TxtPhone.Text = string.Empty;
        }
        #endregion
    }
}