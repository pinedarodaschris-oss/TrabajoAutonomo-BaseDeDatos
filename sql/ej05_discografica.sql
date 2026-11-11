-- Ejercicio 5: Empresa Discográfica
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS discografica CHARACTER SET utf8mb4;
USE discografica;

CREATE TABLE manager (
  id_manager INT AUTO_INCREMENT PRIMARY KEY,
  nombre     VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE artista (
  nif             VARCHAR(15)  PRIMARY KEY,
  nombre_completo VARCHAR(120) NOT NULL,
  id_manager      INT NOT NULL,                 -- representado por un manager
  FOREIGN KEY (id_manager) REFERENCES manager (id_manager)
) ENGINE=InnoDB;

CREATE TABLE evento_promocion (
  id_evento         INT AUTO_INCREMENT PRIMARY KEY,
  fecha_celebracion DATE NOT NULL,
  numero_asistentes INT  NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- Relación N:M "participan"
CREATE TABLE participacion (
  nif       VARCHAR(15) NOT NULL,
  id_evento INT         NOT NULL,
  PRIMARY KEY (nif, id_evento),
  FOREIGN KEY (nif)       REFERENCES artista (nif),
  FOREIGN KEY (id_evento) REFERENCES evento_promocion (id_evento)
) ENGINE=InnoDB;
