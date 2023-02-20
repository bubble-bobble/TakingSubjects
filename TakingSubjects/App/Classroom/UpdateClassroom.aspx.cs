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

namespace TakingSubjects.App.Classroom
{
    public partial class UpdateClassroom : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private ClassroomBusiness _classroom_business = new ClassroomBusiness();
        private const string ACCESS = "Classroom.UpdateClassroom";
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
                        int.TryParse(Request.QueryString["classroomId"], out int classroomId);
                        BindClassroomData(classroomId);
                    }
                }
            }
        }
        #endregion

        #region BIND DATA
        protected void BindClassroomData(int classroomId)
        {
            TblClassroom classroom = _classroom_business.GetClassroomById(classroomId);
            HfClassroomId.Value = classroom.classroomId.ToString();
            TxtName.Text = classroom.classroomName;
            DdlType.SelectedValue = classroom.classroomType;
            TxtCapacity.Text = classroom.capacity.ToString();
        }
        #endregion

        #region FORM METHODS
        protected int GetClassroomData()
        {
            int newCapacity = Convert.ToInt32(TxtCapacity.Text.Trim());
            return newCapacity;
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            Page.Validate("Classroom");
            int classroomId = Convert.ToInt32(HfClassroomId.Value);
            if (Page.IsValid)
            {
                if (_classroom_business.TransanctionUpdateClassroom(GetClassroomData(), classroomId, out string operationMessage))
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
            BtnUpdate.Enabled = false;
        }
        #endregion
    }
}