using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.BusinessModel;
using TakingSubjectsLib.BussinesModel;
using TakingSubjectsLib.DataModel;
using TakingSubjectsLib.Utilities;

namespace TakingSubjects.App.Profile
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private UserBusiness _user_business = new UserBusiness();
        private const string ACCESS = "Profile.ChangePassword";
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
                }
            }
        }
        #endregion

        #region FORM METHOD
        protected string GetCurrentPassword()
        {
            string currentPassword = TxtCurrentPassword.Text.Trim();
            return currentPassword;
        }

        protected string GetNewPassword()
        {
            string newPassword = TxtRepeatNewPassword.Text.Trim();
            return newPassword;
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnChangePassword_Click(object sender, EventArgs e)
        {
            Page.Validate("Password");
            if (Page.IsValid)
            {
                TblUser user = Session["UserData"] as TblUser;
                string newPasswordEnteredEncrypted = Encryption.Encrypt(GetNewPassword());
                if (CompareCurrentPassword(GetCurrentPassword(), out string operationMessageCompareCurrentPassword))
                {
                    if (CompareCurrentPasswordWithNewPassword(GetCurrentPassword(), GetNewPassword(), out string operationMessageCompareCurrentPasswordWithNewPassword))
                    {
                        ImgOperation.ImageUrl = "~/Resources/error.svg";
                        ImgOperation.Visible = true;
                        LtlMessage.Text = operationMessageCompareCurrentPasswordWithNewPassword;
                        LtlMessage.Visible = true;
                        UpModal.Update();
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                    }
                    else
                    {
                        if (_user_business.TransactionUpdatePassword(user.userId, newPasswordEnteredEncrypted, out string operationMessage))
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
                else
                {
                    ImgOperation.ImageUrl = "~/Resources/error.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = operationMessageCompareCurrentPassword;
                    LtlMessage.Visible = true;
                    UpModal.Update();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                }
            }
        }

        #endregion

        #region UTILITIES

        protected bool CompareCurrentPassword(string currentPasswordEntered, out string message)
        {
            message = string.Empty;
            string currentPasswordEnteredEncrypted = Encryption.Encrypt(currentPasswordEntered);
            TblUser user = Session["UserData"] as TblUser;
            if (currentPasswordEnteredEncrypted.Equals(user.password))
            {
                return true;
            }
            else
            {
                message = "La contraseña actual es incorrecta.";
                return false;
            }
        }

        protected bool CompareCurrentPasswordWithNewPassword(string currentPasswordEntered, string newPassword, out string message)
        {
            message = string.Empty;
            string currentPasswordEnteredEncrypted = Encryption.Encrypt(currentPasswordEntered);
            string newPasswordEnteredEncrypted = Encryption.Encrypt(newPassword);
            if (currentPasswordEnteredEncrypted.Equals(newPasswordEnteredEncrypted))
            {
                message = "La contraseña nueva no puede ser igual a tu contraseña actual.";
                return true;
            }
            else
            {
                return false;
            }
        }
        protected void ClearForm()
        {
            TxtCurrentPassword.Text = string.Empty;
            TxtNewPassword.Text = string.Empty;
            TxtRepeatNewPassword.Text = string.Empty;
        }
        #endregion
    }
}