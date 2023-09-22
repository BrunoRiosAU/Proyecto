﻿<%@ Page Language="C#" Title="Gestion de Fertilizantes en Lotes" MasterPageFile="~/Master/AGlobal.Master" AutoEventWireup="true" CodeBehind="frmLotesFertis.aspx.cs" Inherits="Web.Paginas.Lotes.frmLotesFertis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <div class="container row m-2 text-center">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-sm-11 m-3 p-3 text-center backforContent">
                <div class="row rowLine">
                    <h2 class="title">Gestionar Fertilizantes en Lotes </h2>


                    <div class="row mb-4">

                        <div class="col-xl-4  col-lg-12">
                            <asp:Label CssClass="text centerText " Text="Nombre de la Granja" runat="server"></asp:Label>
                            <div class="col-lg-12">
                                <asp:Label ID="txtGranja" CssClass="text centerText " runat="server"></asp:Label>

                            </div>

                        </div>

                        <div class="col-xl-4 col-lg-12">
                            <asp:Label CssClass="text centerText " Text="Nombre del Producto" runat="server"></asp:Label>
                            <div class="col-lg-12">
                                <asp:Label ID="txtProducto" CssClass="text centerText " runat="server"></asp:Label>

                            </div>


                        </div>

                        <div class="col-xl-4 col-lg-12">
                            <asp:Label CssClass="text centerText " Text="Fecha de producción" runat="server"></asp:Label>
                            
                        <div class="col-lg-12">
                            <asp:Label ID="txtFechProd" CssClass="text centerText " runat="server"></asp:Label>

                        </div>

                        </div>

                    </div>












                <div class="row">

                    <div class="col-xl-9 col-lg-12">
                        <asp:DropDownList ID="listFertilizante" CssClass="input--style-lst" runat="server">
                        </asp:DropDownList>

                        <asp:DropDownList ID="listFertilizanteSel" Visible="false" CssClass="input--style-lst" runat="server">
                        </asp:DropDownList>
                    </div>


                    <div class="col-xl-3 col-lg-12">
                        <asp:Button ID="btnModificarCantidadFertiLote" CssClass="btnE btn--radius btn--green  align-self-center btn--srch" Visible="false" runat="server" Text="Modificar cantidad" OnClick="btnModificarCantidadFertiLote_Click" />
                        <asp:Button CssClass="btnE btn--radius btn--green align-self-center btn--srch" ID="btnBuscarFertilizante" runat="server" Text="Buscar" OnClick="btnBuscarFertilizante_Click" />
                    </div>
                </div>
                <div class="row">
                    <div class=" col-xl-9 col-lg-12">
                        <asp:TextBox ID="txtCantidadFerti" CssClass="input--style-tex" runat="server" placeholder="Cantidad de fertilizante" MaxLength="10" onkeypress="if(event.keyCode<48 || event.keyCode>57)event.returnValue=false;"></asp:TextBox>
                    </div>
                    <div class="col-xl-3 col-lg-12">
                        <asp:Button ID="btnCancelar" CssClass="btnE btn--radius btn--red align-self-center btn--srch" Visible="false" runat="server" Text="Cancelar" OnClick="btnCancelar_Click" />
                        <asp:Button ID="btnSelect" CssClass="btnE btn--radius btn--blue  align-self-center btn--srch" runat="server" Text="Añadir al Lote" OnClick="btnSelectFertilizante_Click" />
                    </div>
                </div>
                <div class="rowLine">
                </div>

                <div class="col-12">
                    <asp:TextBox CssClass="d-inline form-control  w-50 m-2 border-0" ID="txtBuscar" runat="server" placeholder="Buscar" MaxLength="100" onkeydown="return(event.keyCode<91 || event.keyCode==189);"></asp:TextBox>
                    <asp:Button CssClass="btnE btn--radius btn--green align-self-center btn--srch" ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" />

                </div>

                <div class="col-12">
                    <asp:DropDownList ID="listOrdenarPor" CssClass="lstOrd btn--radius  align-self-center btn--srch " Width="200" AutoPostBack="true" OnSelectedIndexChanged="listOrdenarPor_SelectedIndexChanged" runat="server"></asp:DropDownList>
                    <asp:Button ID="btnLimpiar" Class="btnE btn--radius btn--blue align-self-center btn--lst" runat="server" Text="Limpiar" OnClick="btnLimpiar_Click" />
                </div>


                <div class="col-12 my-2">
                    <asp:Label CssClass="text centerText " ID="lblMensajes" runat="server"></asp:Label>




                    <asp:RegularExpressionValidator Display="Dynamic" runat="server" class="text initText"
                        ControlToValidate="txtBuscar"
                        ValidationExpression="^[a-zA-Z0-9 ]+$"
                        ErrorMessage="No es un carácter válido" />

                </div>


                <div class="col-md-12 align-self-center">
                    <div class="row align-self-center">
                        <div class="col-md-12 col-md-offset-1">
                            <div class="form-group">
                                <div class="table-responsive">
                                    <asp:GridView ID="lstLotFertSel" Width="100%" SelectedIndex="1" AutoGenerateColumns="false"
                                        CssClass="table table-bordered table-condensed table-responsive table-hover"
                                        runat="server">
                                        <AlternatingRowStyle BackColor="White" />
                                        <HeaderStyle BackColor="#6B696B" Font-Bold="true" Font-Size="Large" ForeColor="White" />
                                        <RowStyle BackColor="#f5f5f5" />
                                        <Columns>

                                            <asp:BoundField DataField="IdFertilizante"
                                                HeaderText="Id de Fertilizante"
                                                ItemStyle-CssClass="GridStl" />

                                            <asp:BoundField DataField="Nombre"
                                                HeaderText="Nombre"
                                                ItemStyle-CssClass="GridStl" />

                                            <asp:BoundField DataField="Tipo"
                                                HeaderText="Tipo"
                                                ItemStyle-CssClass="GridStl" />


                                            <asp:BoundField DataField="PH"
                                                HeaderText="pH"
                                                ItemStyle-CssClass="GridStl" />

                                            <asp:BoundField DataField="Cantidad"
                                                HeaderText="Cantidad"
                                                ItemStyle-CssClass="GridStl" />



                                            <asp:TemplateField HeaderText="Opciones del administrador"
                                                ItemStyle-CssClass="GridStl">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnBajaFerti" CssClass="btnE btn--radius btn--red" runat="server" Text="Eliminar" OnClientClick="return confirm('¿Desea eliminar este Fertilizante del Lote?')" OnClick="btnBajaFerti_Click" />
                                                    <asp:Button ID="btnModificarCantidad" CssClass="btnE btn--radius btn--yellow" runat="server" Text="Modificar cantidad" OnClick="btnModificarCantidad_Click" />
                                                    <asp:Button ID="btmModificarFerti" CssClass="btnE btn--radius btn--yellow" runat="server" Text="Modificar fertilizante" OnClick="btnModificarFerti_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                 <asp:Label runat="server" ID="lblPaginas" CssClass="text pagStyle">
                            <div class="text-center">

                                <asp:Label runat="server" ID="txtPaginas" CssClass="text pagStyle" Text="Paginas" />
                                <div class="text-center">
                                    <asp:LinkButton ID="lblPaginaAnt" CssClass="text pagTextAct" OnClick="lblPaginaAnt_Click" runat="server"></asp:LinkButton>
                                    <asp:Label ID="lblPaginaAct" CssClass="text pagText" runat="server" Text=""></asp:Label>
                                    <asp:LinkButton ID="lblPaginaSig" CssClass="text pagTextAct" OnClick="lblPaginaSig_Click" runat="server"></asp:LinkButton>
                                </div>
                            </div>
                        </asp:Label>
                </div>



                <div class="col-12">
                    <asp:Button ID="btnAtrasFrm" CssClass="btnE btn--radius btn--gray mt-1 mb-1" Visible="false" runat="server" Text="Volver" OnClick="btnAtrasFrm_Click" />
                    <asp:Button ID="btnAtrasMod" CssClass="btnE btn--radius btn--gray mt-1 mb-1" Visible="false" runat="server" Text="Volver" OnClick="btnAtrasMod_Click" />
                </div>

                <asp:TextBox ID="txtIdFertilizante" Enabled="false" Visible="false" CssClass="input--style-2" runat="server"></asp:TextBox>

            </div>
        </div>
    </div>
</asp:Content>
