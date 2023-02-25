<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TakingSubjects.App.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpSubjectsTaken" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Repeater ID="RptSubjectsTaken" runat="server">
                        <ItemTemplate>
                            <div class="col-lg-4">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <%# Eval("SUBJECT_NAME") %>
                                    </div>
                                    <div class="panel-body">
                                        <ul>
                                            <li><b>Sección: </b><%# Eval("SECTION_NAME") %></li>
                                            <li><b>Sala: </b><%# Eval("CLASSROOM_NAME") %></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>