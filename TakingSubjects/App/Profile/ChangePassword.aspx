<%@ Page Title="Cambiar contraseña" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="TakingSubjects.App.Profile.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpChangePassword" runat="server">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Formulario para cambiar contraseña
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <asp:Label ID="LblCurrentPassword" runat="server"
                                    Text="Contraseña actual" />
                                <asp:TextBox ID="TxtCurrentPassword" runat="server"
                                    CssClass="form-control"
                                    TextMode="Password"
                                    MaxLength="256" />
                                <asp:RequiredFieldValidator ID="RfCurrentPassword" runat="server"
                                    ControlToValidate="TxtCurrentPassword"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Password"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblNewPassword" runat="server"
                                    Text="Nueva contraseña" />
                                <asp:TextBox ID="TxtNewPassword" runat="server"
                                    TextMode="Password"
                                    CssClass="form-control"
                                    MaxLength="256" />
                                <asp:RequiredFieldValidator ID="RfPassword" runat="server"
                                    ControlToValidate="TxtNewPassword"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Password"
                                    Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="ReNewPassword" runat="server"
                                    ControlToValidate="TxtNewPassword"
                                    ErrorMessage="La contraseña debe contener como mínimo 8 caracteres, un símbolo especial, un número y una letra mayúscula."
                                    ValidationExpression="^(?=.*[!@#$%^&*()\-_=+{}[\]|\\;:'&quot;,.<>/?])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
                                    ValidationGroup="Password"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblRepeatNewPassword" runat="server"
                                    Text="Repetir nueva contraseña" />
                                <asp:TextBox ID="TxtRepeatNewPassword" runat="server"
                                    TextMode="Password"
                                    CssClass="form-control"
                                    MaxLength="256" />
                                <asp:RequiredFieldValidator ID="RfRepeatNewPassword" runat="server"
                                    ControlToValidate="TxtRepeatNewPassword"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Password"
                                    Display="Dynamic" />
                                <asp:CompareValidator ID="CvRepeatPassword" runat="server"
                                    ControlToValidate="TxtRepeatNewPassword"
                                    ControlToCompare="TxtNewPassword"
                                    ValidationGroup="Password"
                                    ErrorMessage="Las contraseñas no coinciden"
                                    Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="ReRepeatNewPassword" runat="server"
                                    ControlToValidate="TxtRepeatNewPassword"
                                    ErrorMessage="La contraseña debe contener como mínimo 8 caracteres, un símbolo especial, un número y una letra mayúscula."
                                    ValidationExpression="^(?=.*[!@#$%^&*()\-_=+{}[\]|\\;:'&quot;,.<>/?])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
                                    ValidationGroup="Password"
                                    Display="Dynamic" />
                            </div>
                        </div>
                        <div class="panel-footer">
                            <asp:Button ID="BtnChangePassword" runat="server"
                                Text="Cambiar contraseña"
                                CssClass="btn btn-success"
                                OnClick="BtnChangePassword_Click" />
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
