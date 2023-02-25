using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.DataModel;

namespace TakingSubjects.App.Profile
{
    public partial class MyProfile : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private const string ACCESS = "Profile.MyProfile";
        #endregion

        #region MyRegion
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
                    BindUserdata();
                }
            }
        }
        #endregion

        #region BIND DATA
        protected void BindUserdata()
        {
            TblUser user = Session["UserData"] as TblUser;
            LblName.Text = user.names;
            LblLastName.Text = user.lastNames;
            LblRut.Text = user.rut;
            LblPhone.Text = user.phone;
        }
        #endregion
    }
}