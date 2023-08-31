﻿using Clases;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Paginas.Admins
{
    public partial class frmListarAdmins : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            this.MasterPageFile = "~/Master/AGlobal.Master";


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


                System.Web.HttpContext.Current.Session["idAdminSel"] = null;
          

                CargarTipos();

                if (System.Web.HttpContext.Current.Session["idAdminMod"] != null)
                {
                    lblMensajes.Text = "Administrador Modificado";
                    System.Web.HttpContext.Current.Session["idAdminMod"] = null;
                }
                CargarListFiltroTipoHab();
                CargarListFiltroTipoAdm();
                CargarListOrdenarPor();
                if (System.Web.HttpContext.Current.Session["Buscar"] != null)
                {
                    txtBuscar.Text = System.Web.HttpContext.Current.Session["Buscar"].ToString();
                    System.Web.HttpContext.Current.Session["Buscar"] = null;
                }

                if (System.Web.HttpContext.Current.Session["FiltroTipoHab"] != null)
                {
                    listFiltroTipoHab.SelectedValue = System.Web.HttpContext.Current.Session["FiltroTipoHab"].ToString();
                    System.Web.HttpContext.Current.Session["FiltroTipoHab"] = null;
                }

                if (System.Web.HttpContext.Current.Session["FiltroTipoAdm"] != null)
                {
                    lstFltTipoAdm.SelectedValue = System.Web.HttpContext.Current.Session["FiltroTipoAdm"].ToString();
                    System.Web.HttpContext.Current.Session["FiltroTipoAdm"] = null;
                }

                if (System.Web.HttpContext.Current.Session["OrdenarPor"] != null)
                {
                    listOrdenarPor.SelectedValue = System.Web.HttpContext.Current.Session["OrdenarPor"].ToString();
                    System.Web.HttpContext.Current.Session["OrdenarPor"] = null;

                }

                listarPagina();

            }
        }



        private bool faltanDatos()
        {
            if (txtNombre.Text == "" || txtApell.Text == "" || txtEmail.Text == "" || txtTel.Text == ""
             || txtUser.Text == "" || txtFchNac.Text == "")


            {
                return true;
            }
            else { return false; }


        }

        private bool fchNotToday()
        {
            string fecha = txtFchNac.Text;
            DateTime fechaDate = Convert.ToDateTime(fecha);
            if (fechaDate < DateTime.Today)
            {
                return true;
            }
            else { return false; }


        }


        public void CargarTipos()
        {
            listTipoAdmin.DataSource = createDataSourceTip();
            listTipoAdmin.DataTextField = "nombre";
            listTipoAdmin.DataValueField = "id";
            listTipoAdmin.DataBind();

            lstEstado.DataSource = createDataSourceEstado();
            lstEstado.DataTextField = "nombre";
            lstEstado.DataValueField = "id";
            lstEstado.DataBind();

        }



        ICollection createDataSourceTip()
        {


            DataTable dt = new DataTable();


            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));

            // Populate the table with sample values.
            dt.Rows.Add(createRow("Seleccionar tipo de Admin", "Seleccionar tipo de Admin", dt));
            dt.Rows.Add(createRow("Administrador global", "Administrador global", dt));
            dt.Rows.Add(createRow("Administrador de productos", "Administrador de productos", dt));
            dt.Rows.Add(createRow("Administrador de pedidos", "Administrador de pedidos", dt));
            dt.Rows.Add(createRow("Administrador de flota", "Administrador de flota", dt));


            DataView dv = new DataView(dt);
            return dv;

        }

        ICollection createDataSourceEstado()
        {

            DataTable dt = new DataTable();


            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));

            dt.Rows.Add(createRow("Seleccionar estado de Admin", "Seleccionar estado de Admin", dt));
            dt.Rows.Add(createRow("Habilitado", "Habilitado", dt));
            dt.Rows.Add(createRow("No Habilitado", "No Habilitado", dt));

            DataView dv = new DataView(dt);
            return dv;
        }

        DataRow createRow(String Text, String Value, DataTable dt)
        {


            DataRow dr = dt.NewRow();

            dr[0] = Text;
            dr[1] = Value;

            return dr;

        }



        #region Utilidad
        private void limpiar()
        {

            txtId.Text = "";
            txtBuscar.Text = "";
            lblMensajes.Text = "";
            txtNombre.Text = "";
            txtApell.Text = "";
            txtEmail.Text = "";
            txtTel.Text = "";
            txtFchNac.Text = "";
            txtUser.Text = "";
            txtPass.Text = "";
            listTipoAdmin.SelectedValue = "Seleccionar tipo de Admin";
            txtBuscar.Text = "";
            lstAdmin.SelectedIndex = -1;

            lstFltTipoAdm.SelectedValue = "Filtrar por tipo de admin";
            listFiltroTipoHab.SelectedValue = "Filtrar por estado";
            listOrdenarPor.SelectedValue = "Ordenar por";
            lblPaginaAct.Text = "1";
            listarPagina();
        }


        private bool ValidUser()
        {
            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            List<string> users = Web.userRepetidoCli();
            List<string> admins = Web.userRepetidoAdm();
            int pep = 0;
            string user = txtUser.Text;
            string Luser = user.ToLower();
            for (int i = 0; i < users.Count; i++)
            {
                if (Luser.Equals(users[i].ToString().ToLower()))
                {
                    pep++;
                }
                string u = users[i].ToString();

            }

            for (int i = 0; i < admins.Count; i++)
            {
                if (Luser.Equals(admins[i].ToString().ToLower()))
                {
                    pep++;
                }
                string u = admins[i].ToString();

            }




            if (pep > 0)
            {
                return false;
            }
            else { return true; }


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
            List<Persona> lstPer = Web.lstIdPersonas();
            foreach (Persona persona in lstPer)
            {
                if (persona.IdPersona.Equals(intGuid))
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





        private int PagMax()
        {
          
            return 2;
        }



        private void listarPagina()
        {
            List<Admin> admins = obtenerAdmins();
            List<Admin> adminPagina = new List<Admin>();
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            int cont = 0;
            foreach (Admin unAdmin in admins)
            {
                if (adminPagina.Count == PagMax())
                {
                    break;
                }
                if (cont >= ((pagina * PagMax()) - PagMax()))
                {
                    adminPagina.Add(unAdmin);
                }

                cont++;
            }

            if (adminPagina.Count == 0)
            {
                lblMensajes.Text = "No se encontro ningún administrador.";

                lblPaginaAnt.Visible = false;
                lblPaginaAct.Visible = false;
                lblPaginaSig.Visible = false;
                lstAdmin.Visible = false;
            }
            else
            {
                
                lblMensajes.Text = "";
                modificarPagina();
                lstAdmin.Visible = true;
                lstAdmin.DataSource = null;
                lstAdmin.DataSource = adminPagina;
                lstAdmin.DataBind();
            }

        }
        private void modificarPagina()
        {
            List<Admin> admins = obtenerAdmins();
            double pxp = PagMax();
            double count = admins.Count;
            double pags = count / pxp;
            double cantPags = Math.Ceiling(pags);

            string pagAct = lblPaginaAct.Text.ToString();
 
            lblPaginaSig.Visible = true;
            lblPaginaAct.Visible =true;
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


        private List<Admin> obtenerAdmins()
        {
            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            string buscar = txtBuscar.Text;
            string varEst = "";
            string varAdm = "";
            string ordenar = "";
            if (listFiltroTipoHab.SelectedValue != "Filtrar por estado")
            {
                varEst = listFiltroTipoHab.SelectedValue;
            }

            if (lstFltTipoAdm.SelectedValue != "Filtrar por tipo de admin")
            {
                varAdm = lstFltTipoAdm.SelectedValue;
            }




            if (listOrdenarPor.SelectedValue != "Ordenar por")
            {
                ordenar = listOrdenarPor.SelectedValue;
            }

            List<Admin> admins = Web.buscarAdminFiltro(buscar, varEst, varAdm, ordenar);

            return admins;
        }

        #endregion

        #region Filtro

        public void CargarListFiltroTipoHab()
        {
            listFiltroTipoHab.DataSource = null;
            listFiltroTipoHab.DataSource = createDataSourceFiltroTipoHab();
            listFiltroTipoHab.DataTextField = "nombre";
            listFiltroTipoHab.DataValueField = "id";
            listFiltroTipoHab.DataBind();
        }

        ICollection createDataSourceFiltroTipoHab()
        {

            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));

            dt.Rows.Add(createRow("Filtrar por estado", "Filtrar por estado", dt));
            dt.Rows.Add(createRow("Habilitado", "Habilitado", dt));
            dt.Rows.Add(createRow("No Habilitado", "No Habilitado", dt));



            DataView dv = new DataView(dt);
            return dv;
        }


        public void CargarListFiltroTipoAdm()
        {
            lstFltTipoAdm.DataSource = null;
            lstFltTipoAdm.DataSource = createDataSourceFiltroTipoAdm();
            lstFltTipoAdm.DataTextField = "nombre";
            lstFltTipoAdm.DataValueField = "id";
            lstFltTipoAdm.DataBind();
        }

        ICollection createDataSourceFiltroTipoAdm()
        {

            DataTable dt = new DataTable();

            dt.Columns.Add(new DataColumn("nombre", typeof(String)));
            dt.Columns.Add(new DataColumn("id", typeof(String)));


            dt.Rows.Add(createRow("Filtrar por tipo de admin", "Filtrar por tipo de admin", dt));
            dt.Rows.Add(createRow("Administrador global", "Administrador global", dt));
            dt.Rows.Add(createRow("Administrador de productos", "Administrador de productos", dt));
            dt.Rows.Add(createRow("Administrador de pedidos", "Administrador de pedidos", dt));
            dt.Rows.Add(createRow("Administrador de flota", "Administrador de flota", dt));


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
            dt.Rows.Add(createRow("Apellido", "Apellido", dt));
            dt.Rows.Add(createRow("E-Mail", "E-Mail", dt));
            dt.Rows.Add(createRow("Teléfono", "Teléfono", dt));
            dt.Rows.Add(createRow("Fecha de Nacimiento", "Fecha de Nacimiento", dt));
            dt.Rows.Add(createRow("Usuario", "Usuario", dt));
            dt.Rows.Add(createRow("Tipo de Admin", "Tipo de Admin", dt));
            dt.Rows.Add(createRow("Estado", "Estado", dt));
            DataView dv = new DataView(dt);
            return dv;
        }

        #endregion




        #region botones
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            lblPaginaAct.Text = "1";
            listarPagina();
        }
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
        protected void lblPaginaAnt_Click(object sender, EventArgs e)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            System.Web.HttpContext.Current.Session["PagAct"] = (pagina - 1).ToString();
            System.Web.HttpContext.Current.Session["Buscar"] = txtBuscar.Text;
            System.Web.HttpContext.Current.Session["FiltroTipoHab"] = listFiltroTipoHab.SelectedValue;
            System.Web.HttpContext.Current.Session["FiltroTipoAdm"] = lstFltTipoAdm.SelectedValue;
            System.Web.HttpContext.Current.Session["OrdenarPor"] = listOrdenarPor.SelectedValue;
            Server.TransferRequest(Request.Url.AbsolutePath, false);
        }

        protected void lblPaginaSig_Click(object sender, EventArgs e)
        {
            string p = lblPaginaAct.Text.ToString();
            int pagina = int.Parse(p);
            System.Web.HttpContext.Current.Session["PagAct"] = (pagina + 1).ToString();
            System.Web.HttpContext.Current.Session["Buscar"] = txtBuscar.Text;
            System.Web.HttpContext.Current.Session["FiltroTipoHab"] = listFiltroTipoHab.SelectedValue;
            System.Web.HttpContext.Current.Session["FiltroTipoAdm"] = lstFltTipoAdm.SelectedValue;
            System.Web.HttpContext.Current.Session["OrdenarPor"] = listOrdenarPor.SelectedValue;
            Server.TransferRequest(Request.Url.AbsolutePath, false);
        }

        protected void btnAlta_Click(object sender, EventArgs e)
        {
            if (!faltanDatos())
            {
                if (txtPass.Text != "")
                {
                    if (listTipoAdmin.SelectedValue.ToString() != "Seleccionar tipo de Admin")
                    {
                        if (lstEstado.SelectedValue.ToString() != "Seleccionar estado de Admin")
                        {
                            if (ValidUser())
                            {
                                if (fchNotToday())
                                {
                                    int id = GenerateUniqueId();
                                    string nombre = HttpUtility.HtmlEncode(txtNombre.Text);
                                    string apellido = HttpUtility.HtmlEncode(txtApell.Text);
                                    string email = HttpUtility.HtmlEncode(txtEmail.Text);
                                    string tele = HttpUtility.HtmlEncode(txtTel.Text);
                                    string txtFc = HttpUtility.HtmlEncode(txtFchNac.Text);
                                    string tipoAdm = HttpUtility.HtmlEncode(listTipoAdmin.SelectedValue.ToString());
                                    string user = HttpUtility.HtmlEncode(txtUser.Text);
                                    string pass = HttpUtility.HtmlEncode(txtPass.Text);
                                    string estado = HttpUtility.HtmlEncode(lstEstado.SelectedValue.ToString());

                                    string hashedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(pass, "SHA1");



                                    ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
                                    Admin unAdmin = new Admin(id, nombre, apellido, email, tele, txtFc, user, hashedPassword, tipoAdm, estado);
                                    if (Web.altaAdmin(unAdmin))
                                    {
                                       
                                        lblMensajes.Text = "Administrador dado de alta con éxito.";
                                        listarPagina();

                                    }
                                    else
                                    {

                                        lblMensajes.Text = "Ya existe un Administrador con estos datos. Estos son los posibles datos repetidos (Email / Teléfono / Usuario).";


                                    }

                                }
                                else
                                {
                                    lblMensajes.Text = "La fecha debe ser menor a hoy";
                                }
                            }
                            else
                            {
                                lblMensajes.Text = "El nombre de usuario ya existe.";
                            }
                        }
                        else
                        {
                            lblMensajes.Text = "Falta seleccionar el estado de Administrador.";
                        }
                    }
                    else
                    {
                        lblMensajes.Text = "Falta seleccionar el tipo de Administrador.";
                    }
                }
                else
                {
                    lblMensajes.Text = "Falta la contraseña.";
                }

            }
            else
            {
                lblMensajes.Text = "Faltan Datos.";
            }
        }



        protected void btnBaja_Click(object sender, EventArgs e)
        {
            int id;
            Button btnConstultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConstultar.NamingContainer;
            id = int.Parse(selectedrow.Cells[0].Text);

            ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
            Admin unAdmin = Web.buscarAdm(id);
            if (unAdmin != null)
            {
                if (Web.bajaAdmin(id))
                {
                    limpiar();
                    lblMensajes.Text = "Se ha eliminado el Administrador.";
                    lblPaginaAct.Text = "1";
                    listarPagina();
                }
                else
                {

                    lblMensajes.Text = "No se ha podido eliminar el Administrador.";
                }
            }
            else
            {
                lblMensajes.Text = "El Administrador no existe.";
            }

        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {

            int id;
            Button btnConstultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConstultar.NamingContainer;
            id = int.Parse(selectedrow.Cells[0].Text);

            System.Web.HttpContext.Current.Session["idAdminSel"] = id;

            Response.Redirect("/Paginas/Admins/modAdmin");
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
            listarPagina();
        }

        #endregion
    }
}