<%@ Page Title="Actualizar sala" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UpdateClassroom.aspx.cs" Inherits="TakingSubjects.App.Classroom.UpdateClassroom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpUpdateClassroom" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Formulario para actualizar una sala de clases
                        </div>
                        <div class="panel-body">
                            <asp:HiddenField ID="HfClassroomId" runat="server" />
                            <div class="form-group">
                                <asp:Label ID="LblName" runat="server"
                                    Text="Nombre" />
                                <asp:TextBox ID="TxtName" runat="server"
                                    CssClass="form-control"
                                    MaxLength="30"
                                    ReadOnly="true" />
                                <asp:RequiredFieldValidator ID="RfName" runat="server"
                                    ControlToValidate="TxtName"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Classroom"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblType" runat="server"
                                    Text="Tipo de sala" />
                                <asp:DropDownList ID="DdlType" runat="server"
                                    CssClass="form-control"
                                    Enabled="false">
                                    <asp:ListItem Text="Selecciona una opción" Value="-1" Selected="True" />
                                    <asp:ListItem Text="Sala audiovisual" Value="Adudiovisual" />
                                    <asp:ListItem Text="Laboratorio computación" Value="Laboratorio computación" />
                                    <asp:ListItem Text="Sala normal" Value="Sala normal" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RfType" runat="server"
                                    ControlToValidate="DdlType"
                                    ErrorMessage="Este campo es obligatorio"
                                    InitialValue="-1"
                                    ValidationGroup="Classroom"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LblCapacity" runat="server"
                                    Text="Capacidad" />
                                <asp:TextBox ID="TxtCapacity" runat="server"
                                    CssClass="form-control"
                                    TextMode="Number" />
                                <asp:RequiredFieldValidator ID="RfCapacity" runat="server"
                                    ControlToValidate="TxtCapacity"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Classroom"
                                    Display="Dynamic" />
                                <asp:CompareValidator ID="CpDatatypeCapacity" runat="server"
                                    ControlToValidate="TxtCapacity"
                                    ErrorMessage="Este campo solo acepta números"
                                    Operator="DataTypeCheck"
                                    Type="Integer"
                                    ValidationGroup="Classroom"
                                    Display="Dynamic" />
                                <asp:CompareValidator ID="CpGreaterThanCapacity" runat="server"
                                    ControlToValidate="TxtCapacity"
                                    ErrorMessage="Este campo debe ser un número positivo"
                                    Operator="GreaterThan"
                                    ValueToCompare="0"
                                    Type="Integer"
                                    ValidationGroup="Classroom"
                                    Display="Dynamic" />
                            </div>
                        </div>
                        <div class="panel-footer">
                            <asp:Button ID="BtnUpdate" runat="server"
                                Text="Actualizar"
                                CssClass="btn btn-success"
                                OnClick="BtnUpdate_Click" />
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
