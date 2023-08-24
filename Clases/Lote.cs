﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Clases
{
    public class Lote
    {
        private int _idGranja;
        private int _idProducto;
        private string _fchProduccion;
        private string _cantidad;
        private double _precio;
        private int _idDeposito;

        public override string ToString()
        {
            return IdGranja + " - " + IdProducto + " - " + FchProduccion + " - " + Cantidad + " - " + Precio + " - " + IdDeposito;
        }

        public Lote() { }

        public Lote(int idGranja, int idProducto, string fchProduccion, string cantidad, double precio, int idDeposito)
        {
            IdGranja = idGranja;
            IdProducto = idProducto;
            FchProduccion = fchProduccion;
            Cantidad = cantidad;
            Precio = precio;
            IdDeposito = idDeposito;
        }

        public int IdGranja { get => _idGranja; set => _idGranja = value; }
        public int IdProducto { get => _idProducto; set => _idProducto = value; }
        public string FchProduccion { get => _fchProduccion; set => _fchProduccion = value; }
        public string Cantidad { get => _cantidad; set => _cantidad = value; }
        public double Precio { get => _precio; set => _precio = value; }
        public int IdDeposito { get => _idDeposito; set => _idDeposito = value; }
    }
}