<%@ Page Title="Mi perfil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyProfile.aspx.cs" Inherits="TakingSubjects.App.Profile.MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpMyProfile" runat="server">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Mi perfil
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label for="LblName">Nombre</label>
                                <asp:Label ID="LblName" runat="server"
                                    CssClass="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="LblLastName">Apellido</label>
                                <asp:Label ID="LblLastName" runat="server"
                                    CssClass="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="LblRut">Rut</label>
                                <asp:Label ID="LblRut" runat="server"
                                    CssClass="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="LblPhone">Teléfono</label>
                                <asp:Label ID="LblPhone" runat="server"
                                    CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
