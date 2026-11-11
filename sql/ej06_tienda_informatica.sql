-- Ejercicio 6: Tienda Informática
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS tienda_informatica CHARACTER SET utf8mb4;
USE tienda_informatica;

CREATE TABLE tienda (
  id_tienda INT AUTO_INCREMENT PRIMARY KEY,
  nombre    VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE producto (
  codigo      VARCHAR(15) PRIMARY KEY,
  descripcion VARCHAR(150) NOT NULL,
  precio      DECIMAL(10,2) NOT NULL,
  existencias INT NOT NULL DEFAULT 0,
  id_tienda   INT NOT NULL,                     -- la tienda vende el producto
  FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda)
) ENGINE=InnoDB;

CREATE TABLE cliente (
  codigo    VARCHAR(15) PRIMARY KEY,
  nombres   VARCHAR(80)  NOT NULL,
  apellidos VARCHAR(80)  NOT NULL,
  direccion VARCHAR(150),
  telefono  VARCHAR(15)
) ENGINE=InnoDB;

CREATE TABLE proveedor (
  codigo    VARCHAR(15) PRIMARY KEY,
  nombres   VARCHAR(80)  NOT NULL,
  apellidos VARCHAR(80)  NOT NULL,
  direccion VARCHAR(150),
  provincia VARCHAR(60),
  telefono  VARCHAR(15),
  id_tienda INT NOT NULL,                       -- la tienda tiene contacto con el proveedor
  FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda)
) ENGINE=InnoDB;

-- Relación N:M "suministra"
CREATE TABLE suministra (
  codigo_proveedor VARCHAR(15) NOT NULL,
  codigo_producto  VARCHAR(15) NOT NULL,
  PRIMARY KEY (codigo_proveedor, codigo_producto),
  FOREIGN KEY (codigo_proveedor) REFERENCES proveedor (codigo),
  FOREIGN KEY (codigo_producto)  REFERENCES producto  (codigo)
) ENGINE=InnoDB;

-- Relación N:M "compra": cada compra queda registrada con su fecha
CREATE TABLE compra (
  id_compra       INT AUTO_INCREMENT PRIMARY KEY,
  codigo_cliente  VARCHAR(15) NOT NULL,
  codigo_producto VARCHAR(15) NOT NULL,
  fecha           DATE NOT NULL,
  FOREIGN KEY (codigo_cliente)  REFERENCES cliente  (codigo),
  FOREIGN KEY (codigo_producto) REFERENCES producto (codigo)
) ENGINE=InnoDB;
