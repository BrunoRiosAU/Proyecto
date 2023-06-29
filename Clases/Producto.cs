﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clases
{
    public class Producto
    {
        private int _idProducto;
        private string _nombre;
        private string _tipo;
        private char _tipoVenta;
        private double _precio;

        public int IdProducto { get => _idProducto; set => _idProducto = value; }
        public string Nombre { get => _nombre; set => _nombre = value; }
        public string Tipo { get => _tipo; set => _tipo = value; }
        public char TipoVenta { get => _tipoVenta; set => _tipoVenta = value; }
        public double Precio { get => _precio; set => _precio = value; }

        public Producto() { }

        public Producto(int idProducto, string nombre, string tipo, char tipoVenta, double precio)
        {
            IdProducto = idProducto;
            Nombre = nombre;
            Tipo = tipo;
            TipoVenta = tipoVenta;
            Precio = precio;
        }
    }
}