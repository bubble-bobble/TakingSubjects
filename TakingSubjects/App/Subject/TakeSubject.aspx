<%@ Page Title="Toma de asignatura" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TakeSubject.aspx.cs" Inherits="TakingSubjects.App.Subject.TakeSubject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <asp:UpdatePanel ID="UpSubjectsToTake" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="BtnRebindTable" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Listado de asignaturas para tomar
                        </div>
                        <div class="panel-body">
                            <asp:GridView ID="GvSubjectsToTake" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-bordered"
                                DataKeyNames="SECTION_ID"
                                OnRowCommand="GvSubjectsToTake_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="SUBJECT_NAME" HeaderText="Nombre asignatura" />
                                    <asp:BoundField DataField="SECTION_NAME" HeaderText="Nombre sección" />
                                    <asp:BoundField DataField="CLASSROOM_NAME" HeaderText="Nombre sala" />
                                    <asp:BoundField DataField="TOTAL_REGISTERED" HeaderText="Total inscritos" />
                                    <asp:TemplateField HeaderText="Inscripción">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LnkTake" runat="server"
                                                Text="Tomar asignatura"
                                                CssClass="btn btn-success"
                                                CommandName="TakeSubject"
                                                CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    No hay asignaturas para tomar para tomar.
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
                    <asp:Button ID="BtnRebindTable" runat="server"
                        Text="Aceptar"
                        CssClass="btn btn-success"
                        OnClick="BtnRebindTable_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
