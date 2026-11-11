-- Ejercicio 9: Veterinaria
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS veterinaria CHARACTER SET utf8mb4;
USE veterinaria;

CREATE TABLE propietario (
  cedula    VARCHAR(13) PRIMARY KEY,
  apellidos VARCHAR(80)  NOT NULL,
  nombres   VARCHAR(80)  NOT NULL,
  direccion VARCHAR(150)
) ENGINE=InnoDB;

-- Atributo multivaluado "telefonos"
CREATE TABLE propietario_telefono (
  cedula_propietario VARCHAR(13) NOT NULL,
  telefono           VARCHAR(15) NOT NULL,
  PRIMARY KEY (cedula_propietario, telefono),
  FOREIGN KEY (cedula_propietario) REFERENCES propietario (cedula)
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE mascota (
  id_mascota         INT AUTO_INCREMENT PRIMARY KEY,
  nombre             VARCHAR(60) NOT NULL,
  fecha_nacimiento   DATE,
  tipo               VARCHAR(40) NOT NULL,
  cedula_propietario VARCHAR(13) NOT NULL,      -- la lleva uno y solo un propietario
  FOREIGN KEY (cedula_propietario) REFERENCES propietario (cedula)
) ENGINE=InnoDB;

-- Entidad débil (1:1): si el propietario desaparece, el familiar ya no interesa
CREATE TABLE familiar_contacto (
  cedula_propietario VARCHAR(13) PRIMARY KEY,
  cedula             VARCHAR(13) NOT NULL UNIQUE,
  nombre             VARCHAR(80) NOT NULL,
  telefono           VARCHAR(15) NOT NULL,
  FOREIGN KEY (cedula_propietario) REFERENCES propietario (cedula)
    ON DELETE CASCADE
) ENGINE=InnoDB;

-- Superclase de la jerarquía ISA
CREATE TABLE personal (
  codigo VARCHAR(15) PRIMARY KEY,
  cedula VARCHAR(13) NOT NULL UNIQUE,
  nombre VARCHAR(80) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE veterinario (
  codigo       VARCHAR(15) PRIMARY KEY,
  fecha_alta   DATE        NOT NULL,
  especialidad VARCHAR(70) NOT NULL,
  FOREIGN KEY (codigo) REFERENCES personal (codigo) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE auxiliar (
  codigo           VARCHAR(15) PRIMARY KEY,
  base_cotizacion  DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (codigo) REFERENCES personal (codigo) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Relación N:M "pasa consulta" (puede repetirse en fechas distintas)
CREATE TABLE consulta (
  id_consulta          INT AUTO_INCREMENT PRIMARY KEY,
  id_mascota           INT         NOT NULL,
  codigo_veterinario   VARCHAR(15) NOT NULL,
  fecha                DATE        NOT NULL,
  diagnostico          TEXT        NOT NULL,
  FOREIGN KEY (id_mascota)         REFERENCES mascota     (id_mascota),
  FOREIGN KEY (codigo_veterinario) REFERENCES veterinario (codigo)
) ENGINE=InnoDB;
