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
    public partial class SearchSubject : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private SubjectBusiness _subject_business = new SubjectBusiness();
        private const string ACCESS = "Subject.SearchSubject";
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

        #region FORM METHODS
        protected string GetSubjectName()
        {
            string subjectName = TxtName.Text.Trim();
            return subjectName;
        }
        #endregion

        #region BIND DATA
        protected void BindSubjects()
        {
            List<StoredProcedureFindSubjectByNameResult> list = _subject_business.FindSubjectByName(GetSubjectName());
            GvSubjects.DataSource = list;
            GvSubjects.DataBind();
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            BindSubjects();
        }
        #endregion
    }
}