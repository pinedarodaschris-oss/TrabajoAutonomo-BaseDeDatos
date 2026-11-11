-- Ejercicios Entidad-Relación (Base de datos) - Christopher Alexander Pineda Rodas
-- Cada ejercicio crea su propia base de datos.

-- ============================================================
-- Ejemplo 1: Sistema de Biblioteca
-- ============================================================
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

-- ============================================================
-- Ejemplo 2: Pedidos de Restaurante
-- ============================================================
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

-- ============================================================
-- Ejemplo 3: Clínica Médica
-- ============================================================
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

-- ============================================================
-- Ejemplo 4: Sistema de Aerolínea
-- ============================================================
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

-- ============================================================
-- Ejercicio 5: Empresa Discográfica
-- ============================================================
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

-- ============================================================
-- Ejercicio 6: Tienda Informática
-- ============================================================
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

-- ============================================================
-- Ejercicio 7: Discos Musicales
-- ============================================================
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

-- ============================================================
-- Ejercicio 8: Camiones
-- ============================================================
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

-- ============================================================
-- Ejercicio 9: Veterinaria
-- ============================================================
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

