﻿using Clases;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.Paginas.Productos;

namespace Web.Paginas.Pedidos
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        protected void Page_PreInit(object sender, EventArgs e)
        {

            if (System.Web.HttpContext.Current.Session["ClienteIniciado"] == null)
            {
                this.MasterPageFile = "~/Master/AGlobal.Master";
            }
            else
            {
                this.MasterPageFile = "~/Master/MCliente.Master";
                if (System.Web.HttpContext.Current.Session["PedidoCompraSel"] == null)
                {
                    Response.Redirect("/Paginas/PedidosCli/VerPedidosCli");
                }
            }
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                System.Web.HttpContext.Current.Session["Estado"] = null;
                int idPedido = int.Parse(System.Web.HttpContext.Current.Session["PedidoCompraSel"].ToString());



                if (System.Web.HttpContext.Current.Session["PagAct"] == null)
                {
                    lblPaginaAct.Text = "1";
                }
                else
                {
                    lblPaginaAct.Text = System.Web.HttpContext.Current.Session["PagAct"].ToString();
                    System.Web.HttpContext.Current.Session["PagAct"] = null;
                }
                listarProductos(idPedido);

            }
        }




        private int PagMax()
        {
            //Devuelve la cantidad de productos por pagina
            return 4;
        }

        private List<string[]> obtenerProductos(int idPedido)
        {
            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();


            string NomCli = "";
            string Estado = "";
            int CostoMin = 0;
            int CostoMayor = 99999999;
            string ordenar = "";
            List<string[]> productos = new List<string[]>();

            List<Pedido> lstPedido = Web.BuscarPedidoFiltro(NomCli, Estado, CostoMin, CostoMayor, ordenar);
            if (lstPedido.Count > 0)
            {
                foreach (Pedido unPed in lstPedido)
                {
                    if (unPed.IdPedido == idPedido)
                    {
                        Estado = unPed.Estado;
                        break;

                    }
                }

                if (Estado.ToString() == "Sin confirmar" || Estado.ToString() == "Sin finalizar")
                {
                    productos = Web.buscarPedidoProd(idPedido);
                    System.Web.HttpContext.Current.Session["Estado"] = Estado.ToString();
                }
                else
                {
                    productos = Web.buscarPedidoLote(idPedido);
                    System.Web.HttpContext.Current.Session["Estado"] = Estado.ToString();
                }
            }
            return productos;
        }

        private void listarProductos(int idPedido)
        {
            List<string[]> productos = obtenerProductos(idPedido);
            List<string[]> productosPagina = new List<string[]>();
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            int cont = 0;

            foreach (string[] unProducto in productos)
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
                lblMensajes.Text = "No se encontro ningún producto en este pedido.";


                lblPaginas.Visible = false;
                lstProducto.Visible = false;

            }
            else
            {

                lblMensajes.Text = "";
                modificarPagina(idPedido);
                lblPaginas.Visible = true;
                lstProducto.Visible = true;
                lstProducto.DataSource = null;
                lstProducto.DataSource = ObtenerProductos(productosPagina);
                lstProducto.DataBind();

            }


        }

        private void modificarPagina(int idPedido)
        {
            List<string[]> productos = obtenerProductos(idPedido);
            double pxp = PagMax();
            double count = productos.Count;
            double pags = count / pxp;
            double cantPags = Math.Ceiling(pags);

            string pagAct = lblPaginaAct.Text.ToString();
            lblPaginaAct.Visible = true;
            lblPaginaSig.Visible = true;
            lblPaginaAnt.Visible = true;
            txtPaginas.Visible = true;
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









        public DataTable ObtenerProductos(List<string[]> pedidos)
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[6] {




                new DataColumn("Nombre", typeof(string)),
                new DataColumn("Tipo", typeof(string)),
                new DataColumn("Imagen", typeof(string)),
                new DataColumn("Precio", typeof(string)),
                new DataColumn("Cantidad", typeof(string)),
            new DataColumn("PecioTotal", typeof(string))
            });



            foreach (string[] ped in pedidos)
            {
                DataRow dr = dt.NewRow();


                if (System.Web.HttpContext.Current.Session["Estado"].ToString() == "Sin finalizar" ||
                    System.Web.HttpContext.Current.Session["Estado"].ToString() == "Sin confirmar"
                    )
                {
                    dr["Nombre"] = ped[2].ToString();
                    dr["Tipo"] = ped[3].ToString();
                    dr["Precio"] = ped[4].ToString() + " $";
                    string Imagen = "data:image/jpeg;base64,";
                    Imagen += ped[5].ToString();
                    Imagen = $"<img style=\"max-width:100px\" src=\"{Imagen}\">";
                    dr["Imagen"] = Imagen;



                    dr["Cantidad"] = ped[6].ToString();


                    string[] arrayCant = ped[6].ToString().Split(' ');

                    double PrecioSubTotal = double.Parse(ped[4].ToString()) * double.Parse(arrayCant[0].ToString());

                    dr["PecioTotal"] = PrecioSubTotal.ToString() + " $";
                    dt.Rows.Add(dr);


                }

                else
                {

                    dr["Nombre"] = ped[2].ToString();
                    dr["Tipo"] = ped[6].ToString();
                    dr["Precio"] = ped[7].ToString() + " $";
                    string Imagen = "data:image/jpeg;base64,";
                    Imagen += ped[8].ToString();
                    Imagen = $"<img style=\"max-width:100px\" src=\"{Imagen}\">";
                    dr["Imagen"] = Imagen;



                    dr["Cantidad"] = ped[9].ToString();


                    string[] arrayCant = ped[9].ToString().Split(' ');

                    double PrecioSubTotal = double.Parse(ped[7].ToString()) * double.Parse(arrayCant[0].ToString());

                    dr["PecioTotal"] = PrecioSubTotal.ToString() + " $";

                    dt.Rows.Add(dr);

                }


            }
            return dt;


        }

        #region botones 


        protected void lblPaginaAnt_Click(object sender, EventArgs e)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            System.Web.HttpContext.Current.Session["PagAct"] = (pagina - 1).ToString();

            Server.TransferRequest(Request.Url.AbsolutePath, false);
        }

        protected void lblPaginaSig_Click(object sender, EventArgs e)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            System.Web.HttpContext.Current.Session["PagAct"] = (pagina + 1).ToString();

            Server.TransferRequest(Request.Url.AbsolutePath, false);
        }






        #endregion



    }

}
