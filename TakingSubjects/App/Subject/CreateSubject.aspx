<%@ Page Title="Registrar asignatura" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateSubject.aspx.cs" Inherits="TakingSubjects.App.Subject.CreateSubject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpCreateSubject" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Formulario para registrar una nueva asignatura
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
                                    ValidationGroup="Subject"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblDescription" runat="server"
                                    Text="Descripción" />
                                <asp:TextBox ID="TxtDescription" runat="server"
                                    CssClass="form-control"
                                    TextMode="MultiLine" />
                                <asp:RequiredFieldValidator ID="RfDescription" runat="server"
                                    ControlToValidate="TxtDescription"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Subject"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblPeriod" runat="server"
                                    Text="Periodo" />
                                <asp:DropDownList ID="DdlPeriod" runat="server"
                                    CssClass="form-control">
                                    <asp:ListItem Text="Seleccione una opción" Value="-1" Selected="True" />
                                    <asp:ListItem Text="Otoño - Invierno" Value="Otoño - Invierno" />
                                    <asp:ListItem Text="Primavera - Verano" Value="Primavera - Verano" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RfDdlPeriod" runat="server"
                                    ControlToValidate="DdlPeriod"
                                    InitialValue="-1"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Subject"
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

