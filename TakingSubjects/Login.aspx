<%@ Page Title="Inicio de sesión" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TakingSubjects.Login1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title text-center">Inicio de sesión</h3>
                    </div>
                    <div class="panel-body">
                        <asp:Login ID="LoginApp" runat="server"
                            ViewStateMode="Disabled"
                            RenderOuterTable="false"
                            OnAuthenticate="LoginApp_Authenticate">
                            <LayoutTemplate>
                                <form role="form">
                                    <fieldset>
                                        <div class="form-group">
                                            <asp:Label ID="LblUsername" runat="server"
                                                Text="Usuario" />
                                            <asp:TextBox ID="UserName" runat="server"
                                                CssClass="form-control" />
                                            <asp:RequiredFieldValidator ID="RFUserName" runat="server"
                                                ControlToValidate="UserName"
                                                Display="Dynamic"
                                                ErrorMessage="El campo nombre de usuario es obligatorio" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Label ID="LblPassword" runat="server"
                                                Text="Contraseña" />
                                            <asp:TextBox ID="Password" runat="server"
                                                TextMode="Password"
                                                CssClass="form-control" />
                                            <asp:RequiredFieldValidator ID="RFPassword" runat="server"
                                                ControlToValidate="Password"
                                                Display="Dynamic"
                                                ErrorMessage="El campo contraseña es obligatorio" />
                                        </div>
                                        <asp:Button ID="BtnLogin" runat="server"
                                            CssClass="btn btn-success btn-block"
                                            CommandName="Login"
                                            Text="Acceder" />
                                        <p class="text-center">
                                            <asp:Literal ID="FailureText" runat="server" />
                                        </p>
                                    </fieldset>
                                </form>
                            </LayoutTemplate>
                        </asp:Login>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
