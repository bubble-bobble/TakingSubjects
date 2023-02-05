using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.DataModel;

namespace TakingSubjects
{
    public partial class SiteMaster : MasterPage
    {
        #region PAGE_LOAD METHOD
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["UserData"] != null)
                {
                    TblUser user = Session["UserData"] as TblUser;
                    LblName.Text = user.names;
                }
                else
                {
                    Session.Abandon();
                    FormsAuthentication.SignOut();
                    FormsAuthentication.RedirectToLoginPage();
                }
            }
        }
        #endregion

        #region FORM METHODS
        protected void LbLogOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }
        #endregion
    }
}