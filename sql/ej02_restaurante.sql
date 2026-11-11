-- Ejemplo 2: Pedidos de Restaurante
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS restaurante CHARACTER SET utf8mb4;
USE restaurante;

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre     VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE mesero (
  id_mesero INT AUTO_INCREMENT PRIMARY KEY,
  nombre    VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(60) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE plato (
  id_plato     INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100)  NOT NULL,
  precio       DECIMAL(8,2)  NOT NULL,          -- precio vigente
  id_categoria INT NOT NULL,
  FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
) ENGINE=InnoDB;

CREATE TABLE pedido (
  id_pedido  INT AUTO_INCREMENT PRIMARY KEY,
  fecha      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  id_cliente INT NOT NULL,
  id_mesero  INT NOT NULL,                      -- un único mesero por pedido
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_mesero)  REFERENCES mesero  (id_mesero)
) ENGINE=InnoDB;

-- Relación N:M "contiene": guarda el precio del momento del pedido
CREATE TABLE detalle_pedido (
  id_pedido       INT NOT NULL,
  id_plato        INT NOT NULL,
  cantidad        INT NOT NULL CHECK (cantidad > 0),
  precio_unitario DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (id_pedido, id_plato),
  FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
  FOREIGN KEY (id_plato)  REFERENCES plato  (id_plato)
) ENGINE=InnoDB;
