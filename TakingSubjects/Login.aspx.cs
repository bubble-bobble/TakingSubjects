using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.BussinesModel;
using TakingSubjectsLib.DataModel;
using TakingSubjectsLib.Utilities;

namespace TakingSubjects
{
    public partial class Login1 : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private UserBusiness _user_business = new UserBusiness();
        #endregion

        #region METHOD PAGE_LOAD
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Form.DefaultFocus = LoginApp.FindControl("UserName").ClientID;

            if (!Page.IsPostBack)
            {
                if (Session["UserData"] != null)
                {
                    Session.Remove("UserData");
                    Session["UserData"] = null;
                }
            }
        }
        #endregion

        #region LOGIN EVENT
        protected void LoginApp_Authenticate(object sender, AuthenticateEventArgs e)
        {
            TblUser user;
            string rut = LoginApp.UserName.ToUpper().Trim();
            string password = LoginApp.Password.Trim();
            if (_user_business.VerifyCredentials(rut, password, out user))
            {
                Session["UserData"] = user;
                Session["AccessData"] = _user_business.GetAccessToModules(user.roleId);
                FormsAuthentication.RedirectFromLoginPage(user.names, false);
                Response.Redirect(string.Format("~/App/Home.aspx"), true);
            }
            else
            {
                LoginApp.FailureText = "Usuario o clave incorrectos!";
                e.Authenticated = false;
            }
        }
        #endregion
    }
}