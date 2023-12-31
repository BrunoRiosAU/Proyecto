﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Clases;
using persistenciaDB;

namespace Persistencia
{
    class pCamionero
    {


        public List<Camionero> buscarCamioneroFiltro(Camionero pCamionero, string fchVencDesde, string fchVencHasta, string ordenar)
        {
            List<Camionero> resultado = new List<Camionero>();
            try
            {
                Camionero camionero;


                SqlConnection conect = Conexion.Conectar();

                SqlCommand cmd = new SqlCommand("BuscarCamioneroFiltro", conect);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@nombre", pCamionero.Nombre));
                cmd.Parameters.Add(new SqlParameter("@apellido", pCamionero.Apellido));
                cmd.Parameters.Add(new SqlParameter("@email", pCamionero.Email));

                cmd.Parameters.Add(new SqlParameter("@cedula", pCamionero.Cedula));
                cmd.Parameters.Add(new SqlParameter("@disponible", pCamionero.Disponible));

                cmd.Parameters.Add(new SqlParameter("@fchVencDesde", fchVencDesde));
                cmd.Parameters.Add(new SqlParameter("@fchVencHasta", fchVencHasta));
                cmd.Parameters.Add(new SqlParameter("@ordenar", ordenar));
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        camionero = new Camionero();
                        camionero.IdPersona = int.Parse(reader["idPersona"].ToString());
                        camionero.Nombre = reader["nombre"].ToString();
                        camionero.Apellido = reader["apellido"].ToString();
                        camionero.Email = reader["email"].ToString();
                        camionero.Telefono = reader["telefono"].ToString();

                        string Fecha = reader["fchNacimiento"].ToString();
                        string[] fechaArr = Fecha.Split(' ');
                        camionero.FchNacimiento = fechaArr[0];

                        camionero.Cedula = reader["cedula"].ToString();
                        camionero.Disponible = reader["disponible"].ToString();

                        string Fecha2 = reader["fchManejo"].ToString();
                        string[] fecha2Arr = Fecha2.Split(' ');

                        camionero.FchManejo = fecha2Arr[0];
                        resultado.Add(camionero);
                    }
                }

                conect.Close();
            }
            catch (Exception)
            {
                return resultado;
            }
            return resultado;
        }

        public Camionero buscarCamionero(int id)
        {
            Camionero camionero = new Camionero();

            using (SqlConnection connect = Conexion.Conectar())
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("BuscarCamionero", connect);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@id", id));

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            camionero.IdPersona = int.Parse(reader["idCamionero"].ToString());
                            camionero.Nombre = reader["nombre"].ToString();
                            camionero.Apellido = reader["apellido"].ToString();
                            camionero.Email = reader["email"].ToString();
                            camionero.Telefono = reader["telefono"].ToString();
                            camionero.FchNacimiento = reader["fchNacimiento"].ToString();
                            camionero.Cedula = reader["cedula"].ToString();
                            camionero.Disponible = reader["disponible"].ToString();
                            camionero.FchManejo = reader["fchManejo"].ToString();
                        }
                    }
                }
                catch (Exception)
                {

                    return camionero;

                }
            }
            return camionero;
        }

        public bool altaCamionero(Camionero camionero, int idAdmin)
        {
            bool resultado = false;

            try
            {
                SqlConnection connect = Conexion.Conectar();
                SqlCommand cmd = new SqlCommand("AltaCamionero", connect);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@id", camionero.IdPersona));
                cmd.Parameters.Add(new SqlParameter("@nombre", camionero.Nombre));
                cmd.Parameters.Add(new SqlParameter("@apellido", camionero.Apellido));
                cmd.Parameters.Add(new SqlParameter("@email", camionero.Email));
                cmd.Parameters.Add(new SqlParameter("@tele", camionero.Telefono));
                cmd.Parameters.Add(new SqlParameter("@fchNac", camionero.FchNacimiento));
                cmd.Parameters.Add(new SqlParameter("@cedula", camionero.Cedula));
                cmd.Parameters.Add(new SqlParameter("@disp", camionero.Disponible));
                cmd.Parameters.Add(new SqlParameter("@manejo", camionero.FchManejo));
                cmd.Parameters.Add(new SqlParameter("@idAdmin", idAdmin));


                int resBD = cmd.ExecuteNonQuery();

                if (resBD > 0)
                {
                    resultado = true;
                }
                if (connect.State == ConnectionState.Open)
                {
                    connect.Close();
                    resultado = true;
                }
            }
            catch (Exception)
            {
                resultado = false;
            }
            return resultado;
        }

        public bool bajaCamionero(int id, int idAdmin)
        {
            bool resultado = false;

            try
            {
                SqlConnection connect = Conexion.Conectar();
                SqlCommand cmd = new SqlCommand("BajaCamionero", connect);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@id", id));
                cmd.Parameters.Add(new SqlParameter("@idAdmin", idAdmin));

                int resBD = cmd.ExecuteNonQuery();

                if (resBD > 0)
                {
                    resultado = true;
                }
                if (connect.State == ConnectionState.Open)
                {
                    connect.Close();

                }

            }
            catch (Exception)
            {
                resultado = false;
                return resultado;
            }

            return resultado;

        }

        public bool modCamionero(Camionero camionero, int idAdmin)
        {
            bool resultado = false;

            try
            {
                SqlConnection connect = Conexion.Conectar();
                SqlCommand cmd = new SqlCommand("ModificarCamionero", connect);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@id", camionero.IdPersona));
                cmd.Parameters.Add(new SqlParameter("@nombre", camionero.Nombre));
                cmd.Parameters.Add(new SqlParameter("@apellido", camionero.Apellido));
                cmd.Parameters.Add(new SqlParameter("@email", camionero.Email));
                cmd.Parameters.Add(new SqlParameter("@tele", camionero.Telefono));
                cmd.Parameters.Add(new SqlParameter("@fchNac", camionero.FchNacimiento));
                cmd.Parameters.Add(new SqlParameter("@cedula", camionero.Cedula));
                cmd.Parameters.Add(new SqlParameter("@disp", camionero.Disponible));
                cmd.Parameters.Add(new SqlParameter("@manejo", camionero.FchManejo));
                cmd.Parameters.Add(new SqlParameter("@idAdmin", idAdmin));

                int resBD = cmd.ExecuteNonQuery();

                if (resBD > 0)
                {
                    resultado = true;
                }
                if (connect.State == ConnectionState.Open)
                {
                    connect.Close();
                    resultado = true;

                }

            }
            catch (Exception)
            {
                resultado = false;
                return resultado;

            }

            return resultado;

        }
    }
}
