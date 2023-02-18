<%@ Page Title="Buscar salas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchClassroom.aspx.cs" Inherits="TakingSubjects.App.Classroom.SearchClassroom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpSearchClassroom" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Formulario para buscar salas
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <asp:Label ID="LblType" runat="server"
                                    Text="Tipo de sala" />
                                <asp:DropDownList ID="DdlType" runat="server"
                                    CssClass="form-control">
                                    <asp:ListItem Text="Selecciona una opción" Value="-1" Selected="True" />
                                    <asp:ListItem Text="Sala audiovisual" Value="Adudiovisual" />
                                    <asp:ListItem Text="Laboratorio computación" Value="Laboratorio computación" />
                                    <asp:ListItem Text="Sala normal" Value="Sala normal" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RfType" runat="server"
                                    ControlToValidate="DdlType"
                                    ErrorMessage="Este campo es obligatorio"
                                    InitialValue="-1"
                                    ValidationGroup="Type"
                                    Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <asp:Button ID="BtnFilter" runat="server"
                                    Text="Filtrar"
                                    CssClass="btn btn-success"
                                    OnClick="BtnFilter_Click" />
                                <asp:Button ID="BtnRemoveFilter" runat="server"
                                    Text="Quitar filtro"
                                    CssClass="btn btn-danger"
                                    OnClick="BtnRemoveFilter_Click" />
                            </div>
                            <asp:GridView ID="GvClassrooms" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-bordered"
                                DataKeyNames="classroomId"
                                OnRowCommand="GvClassrooms_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="classroomName" HeaderText="Nombre" />
                                    <asp:BoundField DataField="classroomType" HeaderText="Tipo de sala" />
                                    <asp:BoundField DataField="capacity" HeaderText="Capacidad" />
                                    <asp:TemplateField HeaderText="Información">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LnkMoreInfo" runat="server"
                                                Text="Más información"
                                                CssClass="btn btn-info"
                                                CommandName="MoreInfo"
                                                CommandArgument='<%# Container.DataItemIndex %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    No hay salas de este tipo registradas
                                </EmptyDataTemplate>
                            </asp:GridView>
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
                    <h5 class="modal-title">Información:</h5>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpModal" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView ID="GvClassroomInformation" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-bordered">
                                <Columns>
                                    <asp:BoundField DataField="CLASSROOM_NAME" HeaderText="Nombre sala" />
                                    <asp:BoundField DataField="SECTION_NAME" HeaderText="Nombre sección" />
                                    <asp:BoundField DataField="SUBJECT_NAME" HeaderText="Nombre asignatura" />
                                </Columns>
                                <EmptyDataTemplate>
                                    No hay asignaturas, ni secciones asociadas a esta sala.
                                </EmptyDataTemplate>
                            </asp:GridView>
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
