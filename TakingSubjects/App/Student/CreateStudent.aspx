<%@ Page Title="Registrar alumno" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateStudent.aspx.cs" Inherits="TakingSubjects.App.Student.CreateStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpCreatestudent" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Formulario para registrar un nuevo alumno
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <asp:Label ID="LblRut" runat="server"
                                    Text="Rut" />
                                <asp:TextBox ID="TxtRut" runat="server"
                                    CssClass="form-control"
                                    MaxLength="10" />
                                <asp:RequiredFieldValidator ID="RfRut" runat="server"
                                    ControlToValidate="TxtRut"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Student"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblNames" runat="server"
                                    Text="Nombre" />
                                <asp:TextBox ID="TxtNames" runat="server"
                                    CssClass="form-control"
                                    MaxLength="30" />
                                <asp:RequiredFieldValidator ID="RfNames" runat="server"
                                    ControlToValidate="TxtNames"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Student"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblLastNames" runat="server"
                                    Text="Apellidos" />
                                <asp:TextBox ID="TxtLastNames" runat="server"
                                    CssClass="form-control"
                                    MaxLength="30" />
                                <asp:RequiredFieldValidator ID="RfLastNames" runat="server"
                                    ControlToValidate="TxtLastNames"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Student"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblPhone" runat="server"
                                    Text="Teléfono" />
                                <asp:TextBox ID="TxtPhone" runat="server"
                                    CssClass="form-control"
                                    MaxLength="12" />
                                <asp:RequiredFieldValidator ID="RfPhone" runat="server"
                                    ControlToValidate="TxtPhone"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Student"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblPassword" runat="server"
                                    Text="Contraseña" />
                                <asp:TextBox ID="TxtPassword" runat="server"
                                    TextMode="Password"
                                    CssClass="form-control"
                                    MaxLength="256" />
                                <asp:RequiredFieldValidator ID="RfPassword" runat="server"
                                    ControlToValidate="TxtPassword"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Student"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblRepeatPassword" runat="server"
                                    Text="Repetir contraseña" />
                                <asp:TextBox ID="TxtRepeatPassword" runat="server"
                                    TextMode="Password"
                                    CssClass="form-control"
                                    MaxLength="256" />
                                <asp:RequiredFieldValidator ID="RfRepeatPassword" runat="server"
                                    ControlToValidate="TxtRepeatPassword"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Student"
                                    Display="Dynamic" />
                                <asp:CompareValidator ID="CvRepeatPassword" runat="server"
                                    ControlToValidate="TxtRepeatPassword"
                                    ControlToCompare="TxtPassword"
                                    ValidationGroup="Student"
                                    ErrorMessage="Las contraseñas no coinciden"
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
                            </div>
                            <div class="text-center">
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
