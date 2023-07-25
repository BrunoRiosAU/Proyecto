﻿using Clases;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Paginas.Clientes
{
    public partial class RegCliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        #region Utilidad


        private void limpiar()
        {

         
            txtNombre.Text = "";
            txtApell.Text = "";
            txtEmail.Text = "";
            txtTel.Text = "";
            txtFchNac.Text = "";
            txtUser.Text = "";
            txtPass.Text = "";
            txtDir.Text = "";



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





        private bool faltanDatos()
        {
            if (txtNombre.Text == "" || txtApell.Text == "" || txtEmail.Text == "" || txtTel.Text == ""
             || txtUser.Text == "" || txtDir.Text == "" || txtFchNac.Text == "" || txtPass.Text == "")


            {
                return true;
            }
            else { return false; }

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




        #endregion



        protected void btnAlta_Click(object sender, EventArgs e)
        {
            if (!faltanDatos())
            {
                if (fchNotToday())
                {
                    int id = GenerateUniqueId();
                    string nombre = HttpUtility.HtmlEncode(txtNombre.Text);
                    string apellido = HttpUtility.HtmlEncode(txtApell.Text);
                    string email = HttpUtility.HtmlEncode(txtEmail.Text);
                    string tele = HttpUtility.HtmlEncode(txtTel.Text);
                    string txtFc = HttpUtility.HtmlEncode(txtFchNac.Text);
                    string user = HttpUtility.HtmlEncode(txtUser.Text);
                    string pass = HttpUtility.HtmlEncode(txtPass.Text);
                    string dirr = HttpUtility.HtmlEncode(txtDir.Text);

                    string hashedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(pass, "SHA1");



                    ControladoraWeb Web = ControladoraWeb.obtenerInstancia();
                    Cliente unCli = new Cliente(id, nombre, apellido, email, tele, txtFc, user, hashedPassword, dirr);
                    if (Web.altaCli(unCli))
                    {
                        lblMensajes.Text = "Cliente dado de alta con exito.";

                        limpiar();
                    }
                    else
                    {
                        lblMensajes.Text = "No se pudo dar de alta el Cliente, Usuario o Email ya fueron registrados";
                        limpiar();
                    }

                }
                else
                {
                    lblMensajes.Text = "Seleccionar una fecha menor a hoy.";
                }

            }
            else
            {
                lblMensajes.Text = "Faltan Datos";
            }
        }


    }
}