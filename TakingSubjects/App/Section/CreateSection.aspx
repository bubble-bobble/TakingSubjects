<%@ Page Title="Registrar sección" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateSection.aspx.cs" Inherits="TakingSubjects.App.Section.CreateSection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpCreateSection" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Formulario para registrar una nueva sección
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <asp:Label ID="LblName" runat="server"
                                    Text="Nombre" />
                                <asp:TextBox ID="TxtName" runat="server"
                                    CssClass="form-control"
                                    MaxLength="50" />
                                <asp:RequiredFieldValidator ID="RfName" runat="server"
                                    ControlToValidate="TxtName"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Section"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblQuota" runat="server"
                                    Text="Cupo" />
                                <asp:TextBox ID="TxtQuota" runat="server"
                                    CssClass="form-control"
                                    TextMode="Number" />
                                <asp:RequiredFieldValidator ID="RfQuota" runat="server"
                                    ControlToValidate="TxtQuota"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Section"
                                    Display="Dynamic" />
                                <asp:CompareValidator ID="CpDatatypeQuota" runat="server"
                                    ControlToValidate="TxtQuota"
                                    ErrorMessage="Este campo solo acepta números"
                                    Operator="DataTypeCheck"
                                    Type="Integer"
                                    ValidationGroup="Section"
                                    Display="Dynamic" />
                                <asp:CompareValidator ID="CpGreaterThanQuota" runat="server"
                                    ControlToValidate="TxtQuota"
                                    ErrorMessage="Este campo debe ser un número positivo"
                                    Operator="GreaterThan"
                                    ValueToCompare="0"
                                    Type="Integer"
                                    ValidationGroup="Section"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblSubject" runat="server"
                                    Text="Asignatura" />
                                <asp:DropDownList ID="DdlSubject" runat="server"
                                    CssClass="form-control"
                                    SelectMethod="BindAllSubjects"
                                    DataTextField="subjectName"
                                    DataValueField="subjectId">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RfSubject" runat="server"
                                    ControlToValidate="DdlSubject"
                                    InitialValue="-1"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Section"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblClassroom" runat="server"
                                    Text="Sala de clases" />
                                <asp:DropDownList ID="DdlClassroom" runat="server"
                                    CssClass="form-control"
                                    SelectMethod="BindAllClassrooms"
                                    DataTextField="classroomName"
                                    DataValueField="classroomId">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RfClassroom" runat="server"
                                    ControlToValidate="DdlClassroom"
                                    InitialValue="-1"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Section"
                                    Display="Dynamic" />
                            </div>
                        </div>
                        <div class="panel-footer">
                            <asp:Button ID="BtnRegister" runat="server"
                                Text="Registrar"
                                CssClass="btn btn-success"
                                OnClick="BtnRegister_Click" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <div class="modal fade" id="modalOperationResult" role="dialog" aria-labelledby="modalOperationResultLabel" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Resultado operación:</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpModal" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="text-center">
                                <asp:Image ID="ImgOperation" runat="server"
                                    Width="100"
                                    Height="100"
                                    AlternateText="Resultado operación"
                                    Visible="false" />
                                <div class="text-center">
                                </div>
                                <asp:Literal ID="LtlMessage" runat="server"
                                    Visible="false" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
