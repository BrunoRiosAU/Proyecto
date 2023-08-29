﻿using Clases;
using System.Collections.Generic;

namespace Persistencia
{
    public class ControladoraP
    {

        #region Instancia

        private static ControladoraP _instancia;

        public static ControladoraP obtenerInstancia()
        {
            if (_instancia == null)
            {
                _instancia = new ControladoraP();
            }
            return _instancia;
        }

        #endregion

        #region Personas

        public List<Persona> lstIdPersonas()
        {
            return new pAdmin().lstIdPersonas();
        }


        #region Admins

        public List<string> userRepetidoAdm()
        {
            return new pAdmin().userRepetidoAdm();
        }

        public int iniciarSesionAdm(string user, string pass)
        {
            return new pAdmin().iniciarSesionAdm(user, pass);
        }


        public List<Admin> buscarAdminFiltro(string buscar, string varEst, string varAdm, string ordenar)
        {
            return new pAdmin().buscarAdminFiltro(buscar, varEst, varAdm, ordenar);
        }


        public Admin buscarAdm(int id)
        {
            return new pAdmin().buscarAdm(id);
        }

        public bool altaAdmin(Admin admin)
        {
            return new pAdmin().altaAdmin(admin);
        }

        public bool bajaAdmin(int id)
        {
            return new pAdmin().bajaAdmin(id);
        }

        public bool modificarAdm(Admin admin)
        {
            return new pAdmin().modificarAdm(admin);
        }

        #endregion

        #region Clientes



        public int iniciarSesionCli(string user, string pass)
        {
            return new pCliente().iniciarSesionCli(user, pass);
        }
        public List<string> userRepetidoCli()
        {
            return new pCliente().userRepetidoCli();
        }


        
        public List<Cliente> buscarCliFiltro(string buscar, string ordenar)
        {
            return new pCliente().buscarCliFiltro( buscar, ordenar);
        }


    

        public Cliente buscarCli(int id)
        {
            return new pCliente().buscarCli(id);
        }
       
        public bool altaCli(Cliente cli)
        {
            return new pCliente().altaCli(cli);
        }

        public bool bajaCli(int id)
        {
            return new pCliente().bajaCli(id);
        }

        public bool modificarCli(Cliente cli)
        {
            return new pCliente().modificarCli(cli);
        }




        #endregion

        #region Camioneros

      
        public List<Camionero> buscarCamioneroFiltro(string buscar, string disp, string ordenar)
        {
            return new pCamionero().buscarCamioneroFiltro(buscar, disp, ordenar);
        }

        public Camionero buscarCamionero(int id)
        {
            return new pCamionero().buscarCamionero(id);
        }


        public bool altaCamionero(Camionero camionero)
        {
            return new pCamionero().altaCamionero(camionero);
        }

        public bool bajaCamionero(int id)
        {
            return new pCamionero().bajaCamionero(id);
        }

        public bool modCamionero(Camionero camionero)
        {
            return new pCamionero().modCamionero(camionero);
        }

        #endregion

        #endregion

    }
}
