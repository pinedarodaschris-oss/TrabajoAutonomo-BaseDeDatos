-- Ejercicio 8: Camiones
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS transporte CHARACTER SET utf8mb4;
USE transporte;

CREATE TABLE camionero (
  cedula    VARCHAR(13) PRIMARY KEY,
  nombre    VARCHAR(100) NOT NULL,
  telefono  VARCHAR(15),
  direccion VARCHAR(150),
  salario   DECIMAL(10,2) NOT NULL,
  poblacion VARCHAR(80)
) ENGINE=InnoDB;

CREATE TABLE provincia (
  codigo_provincia VARCHAR(5) PRIMARY KEY,
  nombre           VARCHAR(60) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE destinatario (
  cedula           VARCHAR(13) PRIMARY KEY,
  nombre           VARCHAR(100) NOT NULL,
  direccion        VARCHAR(150) NOT NULL,
  codigo_provincia VARCHAR(5)   NOT NULL,       -- "se encuentra" en una provincia
  FOREIGN KEY (codigo_provincia) REFERENCES provincia (codigo_provincia)
) ENGINE=InnoDB;

CREATE TABLE paquete (
  codigo_paquete      VARCHAR(15) PRIMARY KEY,
  descripcion         VARCHAR(150) NOT NULL,
  cedula_camionero    VARCHAR(13)  NOT NULL,    -- lo distribuye un solo camionero
  codigo_provincia    VARCHAR(5)   NOT NULL,    -- llega a una sola provincia
  cedula_destinatario VARCHAR(13)  NOT NULL,    -- lo recibe un destinatario
  FOREIGN KEY (cedula_camionero)    REFERENCES camionero    (cedula),
  FOREIGN KEY (codigo_provincia)    REFERENCES provincia    (codigo_provincia),
  FOREIGN KEY (cedula_destinatario) REFERENCES destinatario (cedula)
) ENGINE=InnoDB;

CREATE TABLE camion (
  matricula VARCHAR(10) PRIMARY KEY,
  modelo    VARCHAR(60) NOT NULL,
  tipo      VARCHAR(40) NOT NULL,
  potencia  INT NOT NULL
) ENGINE=InnoDB;

-- Relación N:M "conduce": un camionero conduce varios camiones en fechas distintas
CREATE TABLE conduce (
  id_conduccion    INT AUTO_INCREMENT PRIMARY KEY,
  cedula_camionero VARCHAR(13) NOT NULL,
  matricula        VARCHAR(10) NOT NULL,
  fecha            DATE NOT NULL,
  UNIQUE (cedula_camionero, matricula, fecha),
  FOREIGN KEY (cedula_camionero) REFERENCES camionero (cedula),
  FOREIGN KEY (matricula)        REFERENCES camion    (matricula)
) ENGINE=InnoDB;
