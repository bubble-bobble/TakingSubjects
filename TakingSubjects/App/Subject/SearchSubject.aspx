<%@ Page Title="Buscar asignaturas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchSubject.aspx.cs" Inherits="TakingSubjects.App.Subject.SearchSubject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpSearchSubject" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Formulario de búsqueda de asignaturas
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
                                    ValidationGroup="Name"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="BtnSearch" runat="server"
                                    Text="Buscar"
                                    CssClass="btn btn-success"
                                    OnClick="BtnSearch_Click" />
                            </div>
                            <asp:GridView ID="GvSubjects" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-bordered">
                                <Columns>
                                    <asp:BoundField DataField="SUBJECT_NAME" HeaderText="Nombre asignatura" />
                                    <asp:BoundField DataField="SECTION_NAME" HeaderText="Nombre sección" />
                                    <asp:BoundField DataField="CLASSROOM_NAME" HeaderText="Sala de clases" />
                                </Columns>
                                <EmptyDataTemplate>
                                    El nombre de la asignatura no se encuentra en los registros.
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
