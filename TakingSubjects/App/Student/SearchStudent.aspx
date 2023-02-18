<%@ Page Title="Buscar alumno" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchStudent.aspx.cs" Inherits="TakingSubjects.App.Student.SearchStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpSearchStudent" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Formulario para buscar alumnos
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <asp:Label ID="LblRut" runat="server"
                                    Text="Rut" />
                                <asp:TextBox ID="TxtRut" runat="server"
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="RfRut" runat="server"
                                    ControlToValidate="Txtrut"
                                    ErrorMessage="Este campo es obligatorio"
                                    ValidationGroup="Rut"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="BtnSearch" runat="server"
                                    Text="Buscar"
                                    CssClass="btn btn-success"
                                    OnClick="BtnSearch_Click"/>
                                <asp:Button ID="BtnClearForm" runat="server"
                                    Text="Limpiar formulario"
                                    CssClass="btn btn-danger"
                                    OnClick="BtnClearForm_Click"/>
                            </div>
                            <asp:GridView ID="GvStudent" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-bordered">
                                <Columns>
                                    <asp:BoundField DataField="SUBJECT_NAME" HeaderText="Nombre asignatura" />
                                    <asp:BoundField DataField="SECTION_NAME" HeaderText="Nombre sección" />
                                    <asp:BoundField DataField="CLASSROOM_NAME" HeaderText="Nombre sala" />
                                </Columns>
                                <EmptyDataTemplate>
                                    No hay información del alumno.
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>