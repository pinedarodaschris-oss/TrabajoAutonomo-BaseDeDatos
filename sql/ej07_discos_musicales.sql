-- Ejercicio 7: Discos Musicales
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS discos_musicales CHARACTER SET utf8mb4;
USE discos_musicales;

CREATE TABLE genero_musical (
  id_genero INT AUTO_INCREMENT PRIMARY KEY,
  nombre    VARCHAR(60) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE cantante (
  id_cantante INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL,
  pais        VARCHAR(60)  NOT NULL
) ENGINE=InnoDB;

CREATE TABLE disco (
  id_disco    INT AUTO_INCREMENT PRIMARY KEY,
  titulo      VARCHAR(120)  NOT NULL,
  precio      DECIMAL(8,2)  NOT NULL,
  id_genero   INT NOT NULL,
  id_cantante INT NOT NULL,                     -- todo disco pertenece a un cantante
  FOREIGN KEY (id_genero)   REFERENCES genero_musical (id_genero),
  FOREIGN KEY (id_cantante) REFERENCES cantante (id_cantante)
) ENGINE=InnoDB;

CREATE TABLE cancion (
  id_cancion INT AUTO_INCREMENT PRIMARY KEY,
  titulo     VARCHAR(120) NOT NULL
) ENGINE=InnoDB;

-- Relación N:M "contiene" con la posición de la canción en el disco
CREATE TABLE disco_cancion (
  id_disco   INT NOT NULL,
  id_cancion INT NOT NULL,
  posicion   TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (id_disco, id_cancion),
  UNIQUE (id_disco, posicion),
  FOREIGN KEY (id_disco)   REFERENCES disco   (id_disco),
  FOREIGN KEY (id_cancion) REFERENCES cancion (id_cancion)
) ENGINE=InnoDB;
