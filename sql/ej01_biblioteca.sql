-- Ejemplo 1: Sistema de Biblioteca
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS biblioteca CHARACTER SET utf8mb4;
USE biblioteca;

CREATE TABLE libro (
  id_libro INT AUTO_INCREMENT PRIMARY KEY,
  titulo   VARCHAR(150) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE autor (
  id_autor INT AUTO_INCREMENT PRIMARY KEY,
  nombre   VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE socio (
  id_socio INT AUTO_INCREMENT PRIMARY KEY,
  nombre   VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Relación N:M "es escrito"
CREATE TABLE libro_autor (
  id_libro INT NOT NULL,
  id_autor INT NOT NULL,
  PRIMARY KEY (id_libro, id_autor),
  FOREIGN KEY (id_libro) REFERENCES libro (id_libro),
  FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
) ENGINE=InnoDB;

-- Relación N:M "Préstamo" con atributos propios
CREATE TABLE prestamo (
  id_prestamo      INT AUTO_INCREMENT PRIMARY KEY,
  id_libro         INT  NOT NULL,
  id_socio         INT  NOT NULL,
  fecha_retiro     DATE NOT NULL,
  fecha_devolucion DATE NULL,
  FOREIGN KEY (id_libro) REFERENCES libro (id_libro),
  FOREIGN KEY (id_socio) REFERENCES socio (id_socio),
  CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_retiro)
) ENGINE=InnoDB;
