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

namespace TakingSubjects.App
{
    public partial class Home : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private SubjectBusiness _subject_business = new SubjectBusiness();
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
                GetSubjectsTaken();
            }
        }
        #endregion

        #region BIND DATA
        public void GetSubjectsTaken()
        {
            GetUserData(out int userId, out int roleId);
            List<StoredProcedureGetSubjectsTakenByUserIdResult> list = _subject_business.GetSubjectsTakenByUserId(userId, roleId);
            RptSubjectsTaken.DataSource = list;
            RptSubjectsTaken.DataBind();
        }

        protected void GetUserData(out int userId, out int roleId)
        {
            TblUser userSessionData = Session["UserData"] as TblUser;
            userId = userSessionData.userId;
            roleId = userSessionData.roleId;
        }
        #endregion
    }
}