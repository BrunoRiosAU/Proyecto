﻿using Clases;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Paginas.Granjass
{
    public partial class frmGranjas : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            this.MasterPageFile = "~/Master/AGlobal.Master";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            System.Web.HttpContext.Current.Session["idGranjaSelMod"] = null;
            if (!IsPostBack)
            {

                if (System.Web.HttpContext.Current.Session["loteDatos"] != null)
                {
                    btnVolver.Visible = true;
                    lstGranja.Visible = false;
                    lstGranjaSelect.Visible = true;
                }
                if (System.Web.HttpContext.Current.Session["GranjaMod"] != null)
                {
                    lblMensajes.Text = "Granja Modificada";
                    System.Web.HttpContext.Current.Session["GranjaMod"] = null;
                }
                if (System.Web.HttpContext.Current.Session["GranjaDatosFrm"] != null)
                {
                    cargarDatos();
                }
                if (System.Web.HttpContext.Current.Session["PagAct"] == null)
                {
                    lblPaginaAct.Text = "1";
                }
                else
                {
                    lblPaginaAct.Text = System.Web.HttpContext.Current.Session["PagAct"].ToString();
                    System.Web.HttpContext.Current.Session["PagAct"] = null;
                }
                CargarListOrdenarPor();
                CargarListDueño();


                if (System.Web.HttpContext.Current.Session["Buscar"] != null)
                {
                    txtBuscar.Text = System.Web.HttpContext.Current.Session["Buscar"].ToString();
                    System.Web.HttpContext.Current.Session["Buscar"] = null;
                }
                if (System.Web.HttpContext.Current.Session["OrdenarPor"] != null)
                {
                    listOrdenarPor.SelectedValue = System.Web.HttpContext.Current.Session["OrdenarPor"].ToString();
                    System.Web.HttpContext.Current.Session["OrdenarPor"] = null;

                }





                listarPagina();





            }
        }

        #region Guardar y cargar datos

        private void guardarDatos()
        {


            System.Web.HttpContext.Current.Session["GranjaDatosFrm"] = "Si";

            System.Web.HttpContext.Current.Session["Ubicacion"] = txtUbicacion.Text;
            System.Web.HttpContext.Current.Session["Nombre"] = txtNombre.Text;

        }

        private void cargarDatos()
        {
            System.Web.HttpContext.Current.Session["GranjaDatosFrm"] = null;



            txtUbicacion.Text = System.Web.HttpContext.Current.Session["Ubicacion"].ToString();
            System.Web.HttpContext.Current.Session["Ubicacion"] = null;

            txtNombre.Text = System.Web.HttpContext.Current.Session["Nombre"].ToString();
            System.Web.HttpContext.Current.Session["Nombre"] = null;

            if (System.Web.HttpContext.Current.Session["DuenoSelected"] != null)
            {
                listDueño.SelectedValue = System.Web.HttpContext.Current.Session["DuenoSelected"].ToString();
                System.Web.HttpContext.Current.Session["DuenoSelected"] = null;
            }





        }


        #endregion

        private int PagMax()
        {

            return 2;
        }



        private List<Granja> obtenerGranjas()
        {
            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            string buscar = txtBuscar.Text;

            string ordenar = "";


            if (listOrdenarPor.SelectedValue != "Ordenar por")
            {
                ordenar = listOrdenarPor.SelectedValue;
            }



            List<Granja> granja = Web.buscarGranjaFiltro(buscar, ordenar);

            return granja;
        }


        private void listarPagina()
        {
            List<Granja> granjas = obtenerGranjas();
            List<Granja> GranjaPagina = new List<Granja>();
       
         


            if (listOrdenarPor.SelectedValue == "Nombre del dueño")
            {
                Granjasorden(granjas);
            }
            else
            {
                GranjasNorm(granjas, GranjaPagina);
            }



        }

        private void Granjasorden(List<Granja> granjas)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            int cont = 0;
            List<string[]> GranjaPagina = new List<string[]>();


            List<string[]> ordenGranjasDu = ObtenerGranjaslstOrd(granjas);
            foreach (string[] unaGranja in ordenGranjasDu)
            {
                if (GranjaPagina.Count == PagMax())
                {
                    break;
                }
                if (cont >= ((pagina * PagMax()) - PagMax()))
                {
                    GranjaPagina.Add(unaGranja);
                }

                cont++;
            }

            if (GranjaPagina.Count == 0)
            {
                lblMensajes.Text = "No se encontro ningún administrador.";

                lblPaginaAnt.Visible = false;
                lblPaginaAct.Visible = false;
                lblPaginaSig.Visible = false;
                lstGranja.Visible = false;
                lstGranjaSelect.Visible = false;
            }
            else
            {
                if (System.Web.HttpContext.Current.Session["loteDatos"] != null)
                {
                    lstGranjaSelect.Visible = true;
                    modificarPagina();
                    lstGranjaSelect.DataSource = null;
                    lstGranjaSelect.DataSource = ObtenerGranjasDataTableOrd(GranjaPagina);
                    lstGranjaSelect.DataBind();
                }

                else
                {
                    lblMensajes.Text = "";
                    modificarPagina();
                    lstGranja.Visible = true;
                    lstGranja.DataSource = null;
                    lstGranja.DataSource = ObtenerGranjasDataTableOrd(GranjaPagina);
                    lstGranja.DataBind();
                }
            }

        }

        private void GranjasNorm(List<Granja> granjas, List<Granja> GranjaPagina)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            int cont = 0;
            foreach (Granja unaGranja in granjas)
            {
                if (GranjaPagina.Count == PagMax())
                {
                    break;
                }
                if (cont >= ((pagina * PagMax()) - PagMax()))
                {
                    GranjaPagina.Add(unaGranja);
                }

                cont++;
            }

            if (GranjaPagina.Count == 0)
            {
                lblMensajes.Text = "No se encontro ningún administrador.";

                lblPaginaAnt.Visible = false;
                lblPaginaAct.Visible = false;
                lblPaginaSig.Visible = false;
                lstGranja.Visible = false;
                lstGranjaSelect.Visible = false;
            }
            else
            {
                if (System.Web.HttpContext.Current.Session["loteDatos"] != null)
                {
                    lstGranjaSelect.Visible = true;
                    modificarPagina();
                    lstGranjaSelect.DataSource = null;
                    lstGranjaSelect.DataSource = ObtenerGranjasDataTable(GranjaPagina);
                    lstGranjaSelect.DataBind();
                }

                else
                {
                    lblMensajes.Text = "";
                    modificarPagina();
                    lstGranja.Visible = true;
                    lstGranja.DataSource = null;
                    lstGranja.DataSource = ObtenerGranjasDataTable(GranjaPagina);
                    lstGranja.DataBind();
                }
            }



        }

        private void modificarPagina()
        {
            List<Granja> granjas = obtenerGranjas();
            double pxp = PagMax();
            double count = granjas.Count;
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
            lblPaginaAnt.Text = (int.Parse(pagAct) - 1).ToString();
            lblPaginaAct.Text = pagAct.ToString();
            lblPaginaSig.Text = (int.Parse(pagAct) + 1).ToString();
        }


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
            dt.Rows.Add(createRow("Ubicación", "Ubicación", dt));
            dt.Rows.Add(createRow("Nombre del dueño", "Nombre del dueño", dt));

            DataView dv = new DataView(dt);
            return dv;
        }

        #endregion



        public DataTable ObtenerGranjasDataTable(List<Granja> granjas)
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[4] {



                new DataColumn("IdGranja", typeof(int)),
                new DataColumn("Nombre", typeof(string)),
                new DataColumn("Ubicacion", typeof(string)),

                new DataColumn("NomDue", typeof(string))});

            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();

            foreach (Granja gran in granjas)
            {
                Cliente cli = Web.buscarCli(gran.IdCliente);

                DataRow dr = dt.NewRow();
                dr["IdGranja"] = gran.IdGranja.ToString();
                dr["Nombre"] = gran.Nombre.ToString();
                dr["Ubicacion"] = gran.Ubicacion.ToString();
                dr["NomDue"] = cli.Nombre.ToString();
                dt.Rows.Add(dr);
            }
     
            return dt;
        }

        public DataTable ObtenerGranjasDataTableOrd(List<string[]> granjas)
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[4] {



                new DataColumn("IdGranja", typeof(int)),
                new DataColumn("Nombre", typeof(string)),
                new DataColumn("Ubicacion", typeof(string)),

                new DataColumn("NomDue", typeof(string))});

            foreach (string[] gran in granjas)
            {
                DataRow dr = dt.NewRow();
                dr["IdGranja"] = gran[0].ToString();
                dr["Nombre"] = gran[1].ToString();
                dr["Ubicacion"] = gran[2].ToString();
                dr["NomDue"] = gran[3].ToString();
                dt.Rows.Add(dr);
            }

            return dt;
        }





        public List<string[]> ObtenerGranjaslstOrd(List<Granja> granjas)
        {
            List<string[]> myList = new List<string[]>();

            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();

            foreach (Granja gran in granjas)
            {
                Cliente cli = Web.buscarCli(gran.IdCliente);

                string[] dr = new string[4];
                dr[0] = gran.IdGranja.ToString();
                dr[1] = gran.Nombre.ToString();
                dr[2] = gran.Ubicacion.ToString();
                dr[3] = cli.Nombre.ToString();
                myList.Add(dr);
              
            }
            var myListOrdenada = myList.OrderBy(x => x[3]).ToList();
            return myListOrdenada;
        }









        private bool faltanDatos()
        {
            if (txtNombre.Text == "" || txtUbicacion.Text == "" || listDueño.SelectedValue == "Seleccione un Dueño")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private void limpiar()
        {
            lblMensajes.Text = "";
            txtId.Text = "";
            txtBuscar.Text = "";


            txtNombre.Text = "";
            txtUbicacion.Text = "";
            listOrdenarPor.SelectedValue = "Ordenar por";
            lstGranja.SelectedIndex = -1;
            lblPaginaAct.Text = "1";
            listarPagina();
        }



        public void CargarListDueño()
        {
            listDueño.DataSource = null;
            listDueño.DataSource = createDataSource();
            listDueño.DataTextField = "nombre";
            listDueño.DataValueField = "id";
            listDueño.DataBind();

        }



        ICollection createDataSource()
        {
            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            List<Cliente> clientes = new List<Cliente>();
            string b = "";
            string d = "";
            string o = "";
            clientes = Web.buscarCliFiltro(b,d);




            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));

            dt.Rows.Add(createRow("Seleccione un Dueño", "Seleccione un Dueño", dt));

            cargarDueños(clientes, dt);

            DataView dv = new DataView(dt);
            return dv;

        }

        private void cargarDueños(List<Cliente> clientes, DataTable dt)
        {
            foreach (Cliente unCliente in clientes)
            {
                dt.Rows.Add(createRow(unCliente.IdPersona + " " + unCliente.Nombre + " " + unCliente.Apellido, unCliente.IdPersona.ToString(), dt));
            }
        }

        DataRow createRow(String Text, String Value, DataTable dt)
        {


            DataRow dr = dt.NewRow();

            dr[0] = Text;
            dr[1] = Value;

            return dr;

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
            string var1 = "";
            string var2 = "";
            List<Granja> lstGranjas = Web.buscarGranjaFiltro(var1, var2);
            foreach (Granja granja in lstGranjas)
            {
                if (granja.IdGranja.Equals(intGuid))
                {
                    i++;
                }
            }

            if (i == 0)
            {
                return intGuid;
            }
            else return GenerateUniqueId();
        }






        protected void btnBuscarDueño_Click(object sender, EventArgs e)
        {
            guardarDatos();
            Response.Redirect("/Paginas/Clientes/frmListarClientes");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Paginas/Lotes/frmAltaLotes");
        }

        protected void btnAlta_Click(object sender, EventArgs e)
        {
            if (!faltanDatos())
            {
                int id = GenerateUniqueId();
                string nombre = HttpUtility.HtmlEncode(txtNombre.Text);
                string ubicacion = HttpUtility.HtmlEncode(txtUbicacion.Text);
                int idCliente = int.Parse(HttpUtility.HtmlEncode(listDueño.SelectedValue));

                ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
                Granja unaGranja = new Granja(id, nombre, ubicacion, idCliente);
                if (Web.altaGranja(unaGranja))
                {
                    if (System.Web.HttpContext.Current.Session["loteDatos"] != null)
                    {
                        System.Web.HttpContext.Current.Session["idGranjaSel"] = unaGranja.IdGranja.ToString();
                        Response.Redirect("/Paginas/Lotes/frmAltaLotes");
                    }
                    else
                    {
                        listarPagina();
                        lblMensajes.Text = "Granja dada de alta con éxito.";
                    }


                }
                else
                {
                    lblMensajes.Text = "Ya existe una Granja con estos datos. Estos son los posibles datos repetidos (Ubicación).";
                }
            }
            else
            {
                lblMensajes.Text = "Faltan datos.";
            }
        }


        protected void btnSelected_Click(object sender, EventArgs e)
        {

            Button btnConstultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConstultar.NamingContainer;
            string id = (HttpUtility.HtmlEncode(selectedrow.Cells[0].Text));

            System.Web.HttpContext.Current.Session["idGranjaSel"] = id;

            Response.Redirect("/Paginas/Lotes/frmAltaLotes");

        }

        private bool comprobarProducen(int id)
        {
            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            string buscar = "";
                string ord = "";
            List<string[]> lotes = Web.buscarFiltrarLotes(buscar, ord);
            foreach (string[] unLote in lotes)
            {
                if (int.Parse(unLote[0]).Equals(id))
                {
                    return true;
                }
            }
            return false;
        }

        protected void btnBaja_Click(object sender, EventArgs e)
        {
            Button btnConstultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConstultar.NamingContainer;
            int id = int.Parse(HttpUtility.HtmlEncode(selectedrow.Cells[0].Text));

            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            Granja unaGranja = Web.buscarGranja(id);
            if (unaGranja != null)
            {
                if (!comprobarProducen(id))
                {
                    if (Web.bajaGranja(id))
                    {
                        listarPagina();
                        lblMensajes.Text = "Se ha borrado la granja.";
                    }
                    else
                    {
                        lblMensajes.Text = "No se ha podido borrar la granja.";
                    }
                }
                else
                {
                    lblMensajes.Text = "Esta granja esta asociada a un lote.";
                }
            }
            else
            {
                lblMensajes.Text = "La granja no existe.";
            }

        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {

            int id;
            Button btnConstultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConstultar.NamingContainer;
            id = int.Parse(selectedrow.Cells[0].Text);

            System.Web.HttpContext.Current.Session["idGranjaSelMod"] = id;
            Response.Redirect("/Paginas/Granjas/modGranja");

        }

        protected void listOrdenarPor_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblPaginaAct.Text = "1";
            listarPagina();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            lblPaginaAct.Text = "1";
            listarPagina();
        }

        protected void lblPaginaAnt_Click(object sender, EventArgs e)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            System.Web.HttpContext.Current.Session["PagAct"] = (pagina - 1).ToString();
            System.Web.HttpContext.Current.Session["Buscar"] = txtBuscar.Text;

            System.Web.HttpContext.Current.Session["OrdenarPor"] = listOrdenarPor.SelectedValue;
            Server.TransferRequest(Request.Url.AbsolutePath, false);
        }

        protected void lblPaginaSig_Click(object sender, EventArgs e)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            System.Web.HttpContext.Current.Session["PagAct"] = (pagina + 1).ToString();
            System.Web.HttpContext.Current.Session["Buscar"] = txtBuscar.Text;

            System.Web.HttpContext.Current.Session["OrdenarPor"] = listOrdenarPor.SelectedValue;
            Server.TransferRequest(Request.Url.AbsolutePath, false);
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
            listarPagina();
        }



    }
}