﻿using Clases;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.Paginas.Productos;

namespace Web.Paginas
{
    public partial class frmCatalogo : System.Web.UI.Page
    {

        #region Load
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.Session["ClienteIniciado"] != null)
            {
                this.MasterPageFile = "~/Master/MCliente.Master";

            }
            else if (System.Web.HttpContext.Current.Session["AdminIniciado"] != null)
            {
                int id = (int)System.Web.HttpContext.Current.Session["AdminIniciado"];
                ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
                Admin admin = Web.buscarAdm(id);

                if (admin.TipoDeAdmin == "Administrador global")
                {
                    this.MasterPageFile = "~/Master/AGlobal.Master";
                }
                else if (admin.TipoDeAdmin == "Administrador de productos")
                {
                    this.MasterPageFile = "~/Master/AProductos.Master";
                }
                else if (admin.TipoDeAdmin == "Administrador de pedidos")
                {
                    this.MasterPageFile = "~/Master/APedidos.Master";
                }
            }
            else
            {
                this.MasterPageFile = "~/Master/Default.Master";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (System.Web.HttpContext.Current.Session["PagAct"] == null)
                {
                    lblPaginaAct.Text = "1";
                }
                else
                {
                    lblPaginaAct.Text = System.Web.HttpContext.Current.Session["PagAct"].ToString();
                    System.Web.HttpContext.Current.Session["PagAct"] = null;
                }
                CargarListBuscar();
                CargarListFiltroTipo();
                CargarListFiltroTipoVen();
                CargarListOrdenarPor();



                // Buscador
                txtBuscar.Text = System.Web.HttpContext.Current.Session["BuscarCatNomProd"] != null ? System.Web.HttpContext.Current.Session["BuscarCatNomProd"].ToString() : "";
                System.Web.HttpContext.Current.Session["BuscarCatNomProd"] = null;

                txtPrecioMenorBuscar.Text = System.Web.HttpContext.Current.Session["precioMenorProductoBuscarCat"] != null ? System.Web.HttpContext.Current.Session["precioMenorProductoBuscarCat"].ToString() : "";
                System.Web.HttpContext.Current.Session["precioMenorProductoBuscarCat"] = null;

                txtPrecioMayorBuscar.Text = System.Web.HttpContext.Current.Session["precioMayorProductoBuscarCat"] != null ? System.Web.HttpContext.Current.Session["precioMayorProductoBuscarCat"].ToString() : "";
                System.Web.HttpContext.Current.Session["precioMayorProductoBuscarCat"] = null;

                // Listas
                listFiltroTipo.SelectedValue = System.Web.HttpContext.Current.Session["FiltroTipoProdCat"] != null ? System.Web.HttpContext.Current.Session["FiltroTipoProdCat"].ToString() : "Seleccione un tipo de producto";
                System.Web.HttpContext.Current.Session["FiltroTipoProdCat"] = null;

                listFiltroVen.SelectedValue = System.Web.HttpContext.Current.Session["FiltroTipoVenCat"] != null ? System.Web.HttpContext.Current.Session["FiltroTipoVenCat"].ToString() : "Seleccione un tipo de venta";
                System.Web.HttpContext.Current.Session["FiltroTipoVenCat"] = null;
                listBuscarPor.SelectedValue = System.Web.HttpContext.Current.Session["BuscarLstCat"] != null ? System.Web.HttpContext.Current.Session["BuscarLstCat"].ToString() : "Buscar por";
                System.Web.HttpContext.Current.Session["BuscarLstCat"] = null;
                listOrdenarPor.SelectedValue = System.Web.HttpContext.Current.Session["OrdenarPorCatalogo"] != null ? System.Web.HttpContext.Current.Session["OrdenarPorCatalogo"].ToString() : "Ordernar por";
                System.Web.HttpContext.Current.Session["OrdenarPorCatalogo"] = null;




                listarPagina();

            }

        }
        #endregion


        #region Utilidad

        private void comprobarBuscar()
        {
            txtBuscar.Visible = listBuscarPor.SelectedValue == "Nombre" ? true : false;
            listFiltroTipo.Visible = listBuscarPor.SelectedValue == "Tipo" ? true : false;
            listFiltroVen.Visible = listBuscarPor.SelectedValue == "Tipo venta" ? true : false;
            lblPrecio.Visible = listBuscarPor.SelectedValue == "Precio" ? true : false;
        }

        static int GenerateUniqueId()
        {
            Guid guid = Guid.NewGuid();
            int intGuid = guid.GetHashCode();
            int i = 0;

            while (intGuid < 0)
            {
                return GenerateUniqueId();
            }

            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            List<Pedido> lstPed = Web.listPedido();
            foreach (Pedido Pedido in lstPed)
            {
                if (Pedido.IdPedido.Equals(intGuid))
                {
                    i++;
                }
            }

            if (i == 0)
            {
                return intGuid;
            }
            else
                return GenerateUniqueId();

        }

        private void guardarBuscar()
        {
            System.Web.HttpContext.Current.Session["BuscarCatNomProd"] = txtBuscar.Text;
            System.Web.HttpContext.Current.Session["FiltroTipoProdCat"] = listFiltroTipo.SelectedValue != "Seleccione un tipo de producto" ? listFiltroTipo.SelectedValue : null ;
            System.Web.HttpContext.Current.Session["FiltroTipoVenCat"] = listFiltroVen.SelectedValue != "Seleccione un tipo de venta" ? listFiltroVen.SelectedValue : null ; 


            System.Web.HttpContext.Current.Session["precioMenorProductoBuscarCat"] = txtPrecioMenorBuscar.Text;
            System.Web.HttpContext.Current.Session["precioMayorProductoBuscarCat"] = txtPrecioMayorBuscar.Text;
            System.Web.HttpContext.Current.Session["BuscarLstCat"] = listBuscarPor.SelectedValue != "Buscar por" ? listBuscarPor.SelectedValue : null;
            System.Web.HttpContext.Current.Session["OrdenarPorCatalogo"] = listOrdenarPor.SelectedValue != "Ordenar por" ? listOrdenarPor.SelectedValue : null;
        }


        private void limpiar()
        {
            lblMensajes.Text = "";

            txtBuscar.Text = "";
            listFiltroVen.SelectedValue = "Seleccione un tipo de venta";
            listFiltroTipo.SelectedValue = "Seleccione un tipo de producto";

            txtPrecioMenorBuscar.Text = "";
            txtPrecioMayorBuscar.Text = "";
            listBuscarPor.SelectedValue = "Buscar por";
            listOrdenarPor.SelectedValue = "Ordenar por";
            comprobarBuscar();
            lblPaginaAct.Text = "1";
            listarPagina();
        }


        private int PagMax()
        {

            return 3;
        }

        private List<Producto> obtenerProductos()
        {
            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            string nombre = HttpUtility.HtmlEncode(txtBuscar.Text);
            string tipo = listFiltroTipo.SelectedValue != "Seleccione un tipo de producto" ? listFiltroTipo.SelectedValue : "";
            string tipoVen = listFiltroVen.SelectedValue != "Seleccione un tipo de venta" ? listFiltroVen.SelectedValue : "";
            int precioMenor = txtPrecioMenorBuscar.Text == "" ? 0 : int.Parse(txtPrecioMenorBuscar.Text);
            int precioMayor = txtPrecioMayorBuscar.Text == "" ? 999999 : int.Parse(txtPrecioMayorBuscar.Text);
            string ordenar = listOrdenarPor.SelectedValue != "Ordenar por" ? listOrdenarPor.SelectedValue : "";


            List<Producto> productos = Web.buscarProductoCatFiltro(nombre, tipo, tipoVen, precioMenor, precioMayor, ordenar);

            foreach (Producto unProducto in productos)
            {
                string Imagen = "data:image/jpeg;base64,";
                Imagen += unProducto.Imagen;
                Imagen = $"<img style=\"max-width:100px\" src=\"{Imagen}\">";
                unProducto.Imagen = Imagen;
                int cant = int.Parse(unProducto.CantTotal.Split(' ')[0]);
                int cantRes = int.Parse(unProducto.CantRes.Split(' ')[0]);
                unProducto.CantDisp = (cant - cantRes).ToString();
            }

            List<Producto> listaOrdenadaXcantDisp = new List<Producto>(productos);


            Producto auxProd;


            for (int i = 0; i < listaOrdenadaXcantDisp.Count; i++)
            {
                for (int indiceActual = 0; indiceActual < listaOrdenadaXcantDisp.Count - 1; indiceActual++)
                {

                    if (int.Parse(listaOrdenadaXcantDisp[indiceActual].CantDisp) < int.Parse(listaOrdenadaXcantDisp[indiceActual + 1].CantDisp))
                    {
                        auxProd = listaOrdenadaXcantDisp[indiceActual];
                        listaOrdenadaXcantDisp[indiceActual] = listaOrdenadaXcantDisp[indiceActual + 1];
                        listaOrdenadaXcantDisp[indiceActual + 1] = auxProd;
                    }
                }
            }

            List<Producto> lstResult = listOrdenarPor.SelectedValue == "Cantidad disponible" ? listaOrdenadaXcantDisp : productos;

            return lstResult;
        }



   

        private void listarPagina()
        {
            List<Producto> productos = obtenerProductos();
            List<Producto> productosPagina = new List<Producto>();

            List<Producto> lstProductos = LstObtenerProductosSinPed(productos);


            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            int cont = 0;
            foreach (Producto unProducto in lstProductos)
            {
                if (productosPagina.Count == PagMax())
                {
                    break;
                }
                if (cont >= ((pagina * PagMax()) - PagMax()))
                {
                    productosPagina.Add(unProducto);
                }

                cont++;
            }

            if (productosPagina.Count == 0)
            {
                lblMensajes.Text = "No se encontro ningún producto.";

                txtPaginas.Visible = false;
                lblPaginaSig.Visible = false;
                lblPaginaAct.Visible = false;
                lblPaginaAnt.Visible = false;
                lstProducto.Visible = false;
            }
            else
            {
                txtPaginas.Visible = true;
                lblMensajes.Text = "";
                modificarPagina();
                lstProducto.Visible = true;
                lstProducto.DataSource = null;
                lstProducto.DataSource = ObtenerDatos(productosPagina);
                lstProducto.DataBind();
            }


        }

        private void modificarPagina()
        {
            List<Producto> productos = obtenerProductos();
            List<Producto> lstProductos = LstObtenerProductosSinPed(productos);
            double pxp = PagMax();
            double count = lstProductos.Count;
            double pags = count / pxp;
            double cantPags = Math.Ceiling(pags);

            string pagAct = lblPaginaAct.Text.ToString();

            lblPaginaSig.Visible = true;
            lblPaginaAct.Visible = true;
            lblPaginaAnt.Visible = true;
            if (pagAct == cantPags.ToString())
            {
                lblPaginaSig.Visible = false;
            }
            if (pagAct == "1")
            {
                lblPaginaAnt.Visible = false;
            }
            if (pagAct == cantPags.ToString() && pagAct == "1")
            {
                txtPaginas.Visible = false;
                lblPaginaAct.Visible = false;

            }

            lblPaginaAnt.Text = (int.Parse(pagAct) - 1).ToString();
            lblPaginaAct.Text = pagAct.ToString();
            lblPaginaSig.Text = (int.Parse(pagAct) + 1).ToString();
        }

        public List<Producto> LstObtenerProductosSinPed(List<Producto> productos)
        {
            List<Producto> lstProductos = new List<Producto>();
            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();


            if (System.Web.HttpContext.Current.Session["ClienteIniciado"] != null)
            {

                int idClinete = int.Parse(System.Web.HttpContext.Current.Session["ClienteIniciado"].ToString());
                List<Pedido> lstPedido = Web.listPedidoCli(idClinete);
                int i = 0;

                foreach (Producto prod in productos)
                {
                    i = 0;
                    int idProducto = prod.IdProducto;


                    List<Pedido_Prod> lstPedidoProd = Web.listPedidoCli_Prod(idProducto);

                    foreach (Pedido pedido in lstPedido)
                    {
                        List<string[]> lstPedidLote = Web.buscarPedidoLote(pedido.IdPedido);
                        if (lstPedidLote.Count > 0)
                        {
                            foreach (string[] unPedidoLote in lstPedidLote)
                            { if (unPedidoLote[0].ToString().Equals (pedido.IdPedido.ToString()) 
                                 &&   unPedidoLote[1].ToString().Equals(idProducto.ToString())
                                && (pedido.Estado.ToString().Equals("Sin confirmar") ||
                                    pedido.Estado.ToString().Equals("Sin finalizar"))
                                    )

                                {
                                    i++;
                                }
                            }
                        }
                      
                            foreach (Pedido_Prod pedido_Prod in lstPedidoProd)
                            {

                                if (pedido_Prod.IdProducto == idProducto
                                    && pedido_Prod.IdPedido == pedido.IdPedido
                                    && (pedido.Estado.ToString().Equals("Sin confirmar") ||
                                    pedido.Estado.ToString().Equals("Sin finalizar"))
                                    )
                                {
                                    i++;
                                }
                            }
                        
                    }

                    if (i == 0)
                    {
                        Producto producto = new Producto();
                        producto.IdProducto = prod.IdProducto;
                        producto.Nombre = prod.Nombre;
                        producto.Tipo = prod.Tipo;
                        producto.TipoVenta = prod.TipoVenta;
                        producto.Imagen = prod.Imagen;
                        producto.Precio = prod.Precio;
                        producto.CantDisp = prod.CantDisp;
                        lstProductos.Add(producto);
                    }


                }


            }
            else
            {
                lstProductos = productos;
            }
            return lstProductos;





        }

        public DataTable ObtenerDatos(List<Producto> Productos)
        {
            DataTable dt = new DataTable();


            dt.Columns.AddRange(new DataColumn[6] {
                new DataColumn("Nombre", typeof(string)),
                new DataColumn("Tipo", typeof(string)),
                new DataColumn("TipoVenta", typeof(string)),
                new DataColumn("Precio", typeof(string)),
                new DataColumn("CantDisp", typeof(string)),
                new DataColumn("Imagen", typeof(string))

           });

            foreach (Producto unProducto in Productos)
            {
                DataRow dr = dt.NewRow();
                dr["Nombre"] = unProducto.Nombre.ToString();
                dr["Tipo"] = unProducto.Tipo.ToString();
                dr["TipoVenta"] = unProducto.TipoVenta.ToString();
                dr["Precio"] = unProducto.Precio.ToString() + " $";
                dr["CantDisp"] = unProducto.CantDisp.ToString() + " " + unProducto.TipoVenta.ToString();
                dr["Imagen"] = unProducto.Imagen.ToString();




                dt.Rows.Add(dr);
            }
            return dt;
        }


        #region DropDownBoxes

        #region Buscador

        public void CargarListBuscar()
        {
            listBuscarPor.DataSource = null;
            listBuscarPor.DataSource = createDataSourceBuscar();
            listBuscarPor.DataTextField = "nombre";
            listBuscarPor.DataValueField = "id";
            listBuscarPor.DataBind();
        }

        ICollection createDataSourceBuscar()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));

            dt.Rows.Add(createRow("Buscar por", "Buscar por", dt));
            dt.Rows.Add(createRow("Nombre", "Nombre", dt));
            dt.Rows.Add(createRow("Tipo", "Tipo", dt));
            dt.Rows.Add(createRow("Tipo venta", "Tipo venta", dt));
            dt.Rows.Add(createRow("Precio", "Precio", dt));
            DataView dv = new DataView(dt);
            return dv;
        }

        #endregion

        DataRow createRow(String Text, String Value, DataTable dt)
        {
            DataRow dr = dt.NewRow();

            dr[0] = Text; dr[1] = Value;

            return dr;
        }

        #endregion


        #region Filtro

        public void CargarListFiltroTipo()
        {
            listFiltroTipo.DataSource = null;
            listFiltroTipo.DataSource = createDataSourceFiltroTipo();
            listFiltroTipo.DataTextField = "nombre";
            listFiltroTipo.DataValueField = "id";
            listFiltroTipo.DataBind();
        }

        ICollection createDataSourceFiltroTipo()
        {

            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));

            dt.Rows.Add(createRow("Seleccione un tipo de producto", "Seleccione un tipo de producto", dt));
            dt.Rows.Add(createRow("Fruta", "Fruta", dt));
            dt.Rows.Add(createRow("Verdura", "Verdura", dt));



            DataView dv = new DataView(dt);
            return dv;
        }

        public void CargarListFiltroTipoVen()
        {
            listFiltroVen.DataSource = null;
            listFiltroVen.DataSource = createDataSourceFiltroTipoVen();
            listFiltroVen.DataTextField = "nombre";
            listFiltroVen.DataValueField = "id";
            listFiltroVen.DataBind();
        }


        ICollection createDataSourceFiltroTipoVen()
        {

            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));

            dt.Rows.Add(createRow("Seleccione un tipo de venta", "Seleccione un tipo de venta", dt));
            dt.Rows.Add(createRow("Kilos", "Kilos", dt));
            dt.Rows.Add(createRow("Unidades", "Unidades", dt));

            DataView dv = new DataView(dt);
            return dv;
        }
        #endregion

        #region Ordenar

        public void CargarListOrdenarPor()
        {
            listOrdenarPor.DataSource = null;
            listOrdenarPor.DataSource = createDataSourceOrdenarPor();
            listOrdenarPor.DataTextField = "nombre";
            listOrdenarPor.DataValueField = "id";
            listOrdenarPor.DataBind();
        }

        ICollection createDataSourceOrdenarPor()
        {

            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));

            dt.Rows.Add(createRow("Ordenar por", "Ordenar por", dt));
            dt.Rows.Add(createRow("Nombre", "Nombre", dt));
            dt.Rows.Add(createRow("Tipo", "Tipo", dt));
            dt.Rows.Add(createRow("Tipo de venta", "Tipo de venta", dt));
            dt.Rows.Add(createRow("Precio", "Precio", dt));
            dt.Rows.Add(createRow("Cantidad disponible", "Cantidad disponible", dt));


            DataView dv = new DataView(dt);
            return dv;
        }

        #endregion

  
        #endregion

        protected void listFiltroTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblPaginaAct.Text = "1";
            listarPagina();
        }

        protected void listOrdenarPor_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblPaginaAct.Text = "1";
            listarPagina();
        }


        #region Botones

        protected void btnRealizarPedido_Click(object sender, EventArgs e)
        {
            Producto producto = new Producto();
            List<Producto> productos = obtenerProductos();
            Button btnConstultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConstultar.NamingContainer;
            string nombre = selectedrow.Cells[0].Text;
            foreach (Producto unProducto in productos)
            {
                if (unProducto.Nombre.Equals(nombre))
                {
                    producto = unProducto;
                }
            }

            if (System.Web.HttpContext.Current.Session["ClienteIniciado"] != null)
            {
                int idCliente = int.Parse(System.Web.HttpContext.Current.Session["ClienteIniciado"].ToString());
                int pedSinFin = 0;
                ControladoraWeb Web = ControladoraWeb.obtenerInstancia();





                int idProducto = producto.IdProducto;
                Pedido_Prod pedido_Prodbus = Web.buscarProductoCli(producto.IdProducto, idCliente);
                int idPedido = 0;
                int idPedidoReg = 0;

                if (System.Web.HttpContext.Current.Session["PedidoCompra"] == null)
                {
                    List<Pedido> ped = Web.listPedidoCli(idCliente);
                    foreach (Pedido pedido in ped)
                    {
                        if (pedido.Estado.Equals("Sin finalizar"))
                        {
                            pedSinFin++;
                        }

                    }
                    if (pedSinFin == 0)
                    {

                        foreach (Pedido pedido in ped)
                        {
                            if (pedido.Estado.Equals("Sin finalizar") &&
                                 pedido.Estado.Equals("Sin confirmar") &&
                                 pedido_Prodbus.IdPedido.ToString().Equals(pedido.IdPedido.ToString())
                                )
                            {
                                idPedidoReg++;
                            }

                        }

                        if (idPedidoReg != 0)
                        {
                            idPedidoReg = 0;


                        }
                        else
                        {

                            Pedido pedido = new Pedido();

                            idPedido = GenerateUniqueId();

                            pedido.IdPedido = idPedido;
                            pedido.IdCliente = idCliente;
                            Cliente cli = Web.buscarCli(idCliente);
                            pedido.InformacionEnvio = cli.Direccion.ToString();

                            idPedidoReg = 1;
                            if (Web.altaPedido(pedido))
                            {
                                System.Web.HttpContext.Current.Session["PedidoCompra"] = idPedido;
                            }
                            else
                            {
                                idPedido = 0;
                            }
                        }

                    }
                }
                else
                {
                    idPedidoReg = 1;
                    idPedido = int.Parse(System.Web.HttpContext.Current.Session["PedidoCompra"].ToString());
                }

                if (pedSinFin == 0)
                {
                    if (idPedidoReg != 0)
                    {
                        if (idPedido != 0)
                        {

                            Pedido_Prod pedido_prod = new Pedido_Prod();
                            Producto pre = Web.buscarProducto(idProducto);

                            string cantidadMost = "0 " + pre.TipoVenta.ToString();

                            pedido_prod.IdProducto = idProducto;
                            pedido_prod.IdPedido = idPedido;
                            pedido_prod.Cantidad = cantidadMost;
                            string CantRes = pre.CantRes;

                            string[] string1 = pedido_prod.Cantidad.Split(' ');



                            double cantidadDouble = double.Parse(string1[0]);

                            double Precio = pre.Precio * cantidadDouble;


                            if (Web.altaPedido_Prod(pedido_prod, CantRes, Precio))
                            {
                              
                                lblPaginaAct.Text = "1";
                                listarPagina();
                                lblMensajes.Text = "Pedido realizado";

                            }
                            else
                            {
                                lblMensajes.Text = "Este producto ya se encuentra en el pedido";
                            }
                        }
                        else
                        {
                            lblMensajes.Text = "No se pudo realizar el pedido";
                        }
                    }
                    else
                    {
                        lblMensajes.Text = "Ya existe un pedido con este producto registrado";
                    }

                }
                else
                {
                    lblMensajes.Text = "Este cliente ya tiene un pedido sin finalizar";

                }




            }
            else
            {
                lblMensajes.Text = "Debe iniciar sesión como cliente para hacer un pedido";
            }
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            int num = 0;
            try
            {
                if (int.Parse(txtPrecioMenorBuscar.Text) <= int.Parse(txtPrecioMayorBuscar.Text)) num++;
            }
            catch
            {
                num++;
            }

            if (num == 1)
            {
                lblPaginaAct.Text = "1";
                listarPagina();
            }
            else
            {
                lblMensajes.Text = "El precio menor es mayor.";
                listBuscarPor.SelectedValue = "Precio";
                comprobarBuscar();
            }
        }
        protected void listBuscarPor_SelectedIndexChanged(object sender, EventArgs e)
        {
            comprobarBuscar();
        }

        protected void lblPaginaAnt_Click(object sender, EventArgs e)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            System.Web.HttpContext.Current.Session["PagAct"] = (pagina - 1).ToString();

            guardarBuscar();

            Server.TransferRequest(Request.Url.AbsolutePath, false);

        }

        protected void lblPaginaSig_Click(object sender, EventArgs e)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            System.Web.HttpContext.Current.Session["PagAct"] = (pagina + 1).ToString();

            guardarBuscar();
   
            Server.TransferRequest(Request.Url.AbsolutePath, false);
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
            listarPagina();
        }


        #endregion


    }
}