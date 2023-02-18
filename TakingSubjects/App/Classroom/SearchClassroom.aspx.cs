using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.BusinessModel;
using TakingSubjectsLib.BussinesModel;
using TakingSubjectsLib.DataModel;

namespace TakingSubjects.App.Classroom
{
    public partial class SearchClassroom : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private ClassroomBusiness _classroom_business = new ClassroomBusiness();
        private const string ACCESS = "Classroom.SearchClassroom";
        #endregion

        #region PAGE_LOAD METHOD
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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
                        BindAllClassrooms();
                    }
                }
            }
        }
        #endregion

        #region BIND DATA
        protected void BindAllClassrooms()
        {
            List<TblClassroom> list = _classroom_business.GetAllClassrooms();
            GvClassrooms.DataSource = list;
            GvClassrooms.DataBind();
        }

        protected void BindClassroomsByType()
        {
            List<TblClassroom> list = _classroom_business.GetClassroomsByType(GetClassroomType());
            GvClassrooms.DataSource = list;
            GvClassrooms.DataBind();
        }
        protected void BindClassroomInformation(int classroomId)
        {
            List<StoredProcedureClassroomInformationResult> list = _classroom_business.GetClassroomInformation(classroomId);
            GvClassroomInformation.DataSource = list;
            GvClassroomInformation.DataBind();
        }
        #endregion

        #region FORMS METHOD
        protected string GetClassroomType()
        {
            string classroomType = DdlType.SelectedValue.ToString();
            return classroomType;
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnFilter_Click(object sender, EventArgs e)
        {
            Page.Validate("Type");
            if (Page.IsValid)
            {
                BindClassroomsByType();
            }
        }

        protected void BtnRemoveFilter_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void GvClassrooms_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView gridView = sender as GridView;
            int index = Convert.ToInt32(e.CommandArgument);
            int classroomId = Convert.ToInt32(gridView.DataKeys[index].Value);
            switch (e.CommandName)
            {
                case "MoreInfo":
                    BindClassroomInformation(classroomId);
                    UpModal.Update();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modalOperationResult", "$('#modalOperationResult').modal('show');", true);
                    break;
                case "Update":
                    Response.Redirect($"~/App/Classroom/UpdateClassroom.aspx?classroomId={classroomId}", true);
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region UTILITIES
        protected void ClearForm()
        {
            DdlType.SelectedValue = "-1";
            BindAllClassrooms();
        }
        #endregion
    }
}