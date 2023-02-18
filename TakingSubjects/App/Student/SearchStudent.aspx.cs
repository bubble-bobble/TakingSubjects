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

namespace TakingSubjects.App.Student
{
    public partial class SearchStudent : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private UserBusiness _user_business = new UserBusiness();
        private const string ACCESS = "Student.SearchStudent";
        #endregion

        #region PAGE_LOAD MEETHOD
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

        #region BIND DATA
        protected void BindStudentInfo(string rut)
        {
            List<StoredProcedureGetStudentInfoAboutSubjectsTakenByRutResult> list = _user_business.GetStudentInfoByRut(rut, (int)UserRoles.Student);
            GvStudent.DataSource = list;
            GvStudent.DataBind();
        }
        #endregion

        #region FORM METHODS
        protected string GetStudentRut()
        {
            string rut = TxtRut.Text.Trim();
            return rut;
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            Page.Validate("Rut");
            if (Page.IsValid)
            {
                BindStudentInfo(GetStudentRut());
            }
        }

        protected void BtnClearForm_Click(object sender, EventArgs e)
        {
            ClearForm();
        }
        #endregion

        #region UTILITIES
        protected void ClearForm()
        {
            TxtRut.Text = string.Empty;
        }
        #endregion
    }
}