-- Ejemplo 3: Clínica Médica
-- Christopher Alexander Pineda Rodas - Base de datos

CREATE DATABASE IF NOT EXISTS clinica CHARACTER SET utf8mb4;
USE clinica;

CREATE TABLE especialidad (
  id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(80) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE medico (
  id_medico       INT AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(100) NOT NULL,
  id_especialidad INT NOT NULL,                 -- pertenece a una especialidad
  FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad)
) ENGINE=InnoDB;

CREATE TABLE paciente (
  id_paciente INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE cita (
  id_cita     INT AUTO_INCREMENT PRIMARY KEY,
  id_paciente INT NOT NULL,
  id_medico   INT NOT NULL,
  fecha       DATE NOT NULL,
  hora        TIME NOT NULL,
  consultorio VARCHAR(20) NOT NULL,
  FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente),
  FOREIGN KEY (id_medico)   REFERENCES medico   (id_medico),
  UNIQUE (id_medico, fecha, hora)               -- un médico no atiende dos citas a la vez
) ENGINE=InnoDB;

-- Una cita genera como máximo una receta (0..1)
CREATE TABLE receta (
  id_receta INT AUTO_INCREMENT PRIMARY KEY,
  id_cita   INT NOT NULL UNIQUE,
  FOREIGN KEY (id_cita) REFERENCES cita (id_cita)
) ENGINE=InnoDB;

CREATE TABLE medicamento (
  id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
  nombre         VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Relación N:M "incluye" con dosis y duración
CREATE TABLE receta_medicamento (
  id_receta      INT NOT NULL,
  id_medicamento INT NOT NULL,
  dosis          VARCHAR(60) NOT NULL,
  duracion       VARCHAR(60) NOT NULL,
  PRIMARY KEY (id_receta, id_medicamento),
  FOREIGN KEY (id_receta)      REFERENCES receta      (id_receta),
  FOREIGN KEY (id_medicamento) REFERENCES medicamento (id_medicamento)
) ENGINE=InnoDB;
