-- Ejemplo 4: Sistema de Aerolínea
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS aerolinea CHARACTER SET utf8mb4;
USE aerolinea;

CREATE TABLE avion (
  id_avion INT AUTO_INCREMENT PRIMARY KEY,
  modelo   VARCHAR(60) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE vuelo (
  id_vuelo     INT AUTO_INCREMENT PRIMARY KEY,
  numero_vuelo VARCHAR(10) NOT NULL,
  fecha        DATE        NOT NULL,
  origen       VARCHAR(60) NOT NULL,
  destino      VARCHAR(60) NOT NULL,
  id_avion     INT NOT NULL,                    -- cada vuelo lo realiza un avión
  FOREIGN KEY (id_avion) REFERENCES avion (id_avion),
  UNIQUE (numero_vuelo, fecha)
) ENGINE=InnoDB;

CREATE TABLE pasajero (
  id_pasajero INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Relación N:M "reserva": asiento y tarifa pagada al reservar
CREATE TABLE reserva (
  id_reserva  INT AUTO_INCREMENT PRIMARY KEY,
  id_vuelo    INT NOT NULL,
  id_pasajero INT NOT NULL,
  asiento     VARCHAR(5)    NOT NULL,
  tarifa      DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_vuelo)    REFERENCES vuelo    (id_vuelo),
  FOREIGN KEY (id_pasajero) REFERENCES pasajero (id_pasajero),
  UNIQUE (id_vuelo, asiento),                   -- un asiento por vuelo
  UNIQUE (id_vuelo, id_pasajero)
) ENGINE=InnoDB;
