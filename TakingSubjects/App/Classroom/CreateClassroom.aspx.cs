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
    public partial class CreateClassroom : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private ClassroomBusiness _classroom_business = new ClassroomBusiness();
        private const string ACCESS = "Classroom.CreateClassroom";
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
        protected TblClassroom GetClassroomData()
        {
            TblClassroom classroom = new TblClassroom()
            {
                classroomId = -1,
                classroomName = TxtName.Text.Trim(),
                classroomType = DdlType.SelectedValue,
                capacity = Convert.ToInt32(TxtCapacity.Text)
            };
            return classroom;
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            Page.Validate("Classroom");
            if (Page.IsValid)
            {
                if (_classroom_business.TransactionInsertNewClassroom(GetClassroomData(), out string operationMessage))
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
            TxtName.Text = string.Empty;
            DdlType.SelectedValue = "-1";
            TxtCapacity.Text = string.Empty;
        }
        #endregion
    }
}