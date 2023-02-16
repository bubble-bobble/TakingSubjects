using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakingSubjectsLib.BussinesModel;
using TakingSubjectsLib.DataModel;
using TakingSubjectsLib.Dtos;

namespace TakingSubjects.App.Section
{
    public partial class CreateSection : System.Web.UI.Page
    {
        #region PRIVATE FIELDS
        private SubjectBusiness _subject_business = new SubjectBusiness();
        private ClassroomBusiness _classroom_business = new ClassroomBusiness();
        private SectionBusiness _section_business = new SectionBusiness();
        private const string ACCESS = "Section.CreateSection";
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

        #region BIND DATA
        public List<SimplifiedSubjectDto> BindAllSubjects()
        {
            return _subject_business.GetAllSubjectsForDdl();
        }

        public List<SimplifiedClassroomDto> BindAllClassrooms()
        {
            return _classroom_business.GetAllClassroomsForDdl();
        }
        #endregion

        #region FORMS METHOD
        protected TblSection GetSectionData()
        {
            TblSection section = new TblSection()
            {
                sectionId = -1,
                sectionName = TxtName.Text.Trim(),
                quota = Convert.ToInt32(TxtQuota.Text),
                totalRegistered = 0,
                subjectId = Convert.ToInt32(DdlSubject.SelectedValue),
                classroomId = Convert.ToInt32(DdlClassroom.SelectedValue)
            };
            return section;
        }
        #endregion

        #region CONTROL METHODS
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            Page.Validate("Section");
            if (Page.IsValid)
            {
                int classroomId = Convert.ToInt32(DdlClassroom.SelectedValue);
                int quota = Convert.ToInt32(TxtQuota.Text);
                if (_classroom_business.VerifyClassroomCapacityById(classroomId) >= quota)
                {
                    if (_section_business.TransactionInsertNewSection(GetSectionData(), out string operationMessage))
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
                else
                {
                    ImgOperation.ImageUrl = "~/Resources/warning.svg";
                    ImgOperation.Visible = true;
                    LtlMessage.Text = "La capacidad de la sala no alcanza para el cupo ingresado.";
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
            TxtQuota.Text = string.Empty;
            DdlSubject.SelectedValue = "-1";
            DdlClassroom.SelectedValue = "-1";
        }
        #endregion
    }
}