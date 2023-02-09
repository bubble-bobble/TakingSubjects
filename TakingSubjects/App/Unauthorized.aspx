<%@ Page Title="No autorizado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Unauthorized.aspx.cs" Inherits="TakingSubjects.App.Unauthorized" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <div class="text-center">
                <asp:Image ID="ImgUnauthorized" runat="server"
                    ImageUrl="~/Resources/unauthorized.svg"
                    Width="400"
                    Height="400" />
                <h2 class="text-center">No tienes autorización para entrar a esta sección.</h2>
            </div>
        </div>
    </div>
</asp:Content>
