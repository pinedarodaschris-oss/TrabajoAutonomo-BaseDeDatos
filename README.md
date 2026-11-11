# Trabajo Autónomo - Base de Datos
### Modelado Entidad-Relación y código MySQL

Colección de 9 ejercicios de modelado de bases de datos: cada uno incluye su **diagrama Entidad-Relación** (notación de Chen) y el **script MySQL** del modelo relacional resultante.

## Información general

| | |
|---|---|
| **Facultad** | FEIRNNET |
| **Carrera** | Computación |
| **Ciclo / paralelo** | Ciclo 3-A |
| **Periodo académico** | Septiembre 2026 - Marzo 2027 |
| **Materia** | Base de datos |
| **Docente** | Rene Guaman |
| **Estudiante** | Christopher Alexander Pineda Rodas |

## Contenido

| N.º | Ejercicio | Base de datos | Diagrama | Script |
|:-:|---|---|:-:|:-:|
| 1 | Sistema de Biblioteca | `biblioteca` | [Diagrama](diagramas/ej01_biblioteca.png) | [SQL](sql/ej01_biblioteca.sql) |
| 2 | Pedidos de Restaurante | `restaurante` | [Diagrama](diagramas/ej02_restaurante.png) | [SQL](sql/ej02_restaurante.sql) |
| 3 | Clínica Médica | `clinica` | [Diagrama](diagramas/ej03_clinica.png) | [SQL](sql/ej03_clinica.sql) |
| 4 | Sistema de Aerolínea | `aerolinea` | [Diagrama](diagramas/ej04_aerolinea.png) | [SQL](sql/ej04_aerolinea.sql) |
| 5 | Empresa Discográfica | `discografica` | [Diagrama](diagramas/ej05_discografica.png) | [SQL](sql/ej05_discografica.sql) |
| 6 | Tienda Informática | `tienda_informatica` | [Diagrama](diagramas/ej06_tienda_informatica.png) | [SQL](sql/ej06_tienda_informatica.sql) |
| 7 | Discos Musicales | `discos_musicales` | [Diagrama](diagramas/ej07_discos_musicales.png) | [SQL](sql/ej07_discos_musicales.sql) |
| 8 | Camiones | `transporte` | [Diagrama](diagramas/ej08_camiones.png) | [SQL](sql/ej08_camiones.sql) |
| 9 | Veterinaria | `veterinaria` | [Diagrama](diagramas/ej09_veterinaria.png) | [SQL](sql/ej09_veterinaria.sql) |

## Estructura del repositorio

```
TrabajoAutonomoBaseDeDatos/
├── README.md
├── diagramas/        # Imagen PNG del diagrama E-R de cada ejercicio
├── sql/              # Un script .sql por ejercicio + todos_los_ejercicios.sql
└── docs/             # Informe en PDF con enunciados, diagramas y código
```

## Cómo ejecutar los scripts

Requisitos: **MySQL 8.0.16 o superior** (desde esta versión se aplican las restricciones `CHECK`).

Un ejercicio concreto:

```bash
mysql -u root -p < sql/ej01_biblioteca.sql
```

Todos los ejercicios a la vez (cada uno crea su propia base de datos):

```bash
mysql -u root -p < sql/todos_los_ejercicios.sql
```

Para comprobar el resultado:

```sql
SHOW DATABASES;
USE biblioteca;
SHOW TABLES;
```

## Notación de los diagramas

- **Rectángulo**: entidad (doble borde = entidad débil).
- **Rombo**: relación (doble rombo = relación identificadora).
- **Óvalo**: atributo (subrayado = clave primaria; doble óvalo = atributo multivaluado).
- **1, N, M**: cardinalidad de cada extremo de la relación.
- **Triángulo ISA**: jerarquía de especialización (Ejercicio 9).

## Criterios de transformación a MySQL

- Cada entidad se convierte en una tabla con su clave primaria.
- Las relaciones **1:N** se resuelven con una clave foránea en el lado N.
- Las relaciones **N:M** se resuelven con una tabla intermedia, que guarda los atributos de la relación (por ejemplo `cantidad` y `precio_unitario` en `detalle_pedido`).
- Los atributos multivaluados pasan a una tabla propia (`propietario_telefono`).
- La entidad débil `familiar_contacto` usa como clave la del propietario, con `ON DELETE CASCADE`.
- La jerarquía ISA (`personal`, `veterinario`, `auxiliar`) comparte el código como clave primaria y foránea.

## Ejercicios

Cada ejercicio presenta el contexto (enunciado), su diagrama Entidad-Relación y el enlace al script MySQL.

### Ejemplo 1: Sistema de Biblioteca

**Contexto del ejercicio**

Una biblioteca registra libros y autores. Un libro puede tener varios autores y un autor varios libros. Los socios toman libros prestados; de cada préstamo interesan la fecha de retiro y la de devolución.


**Diagrama Entidad-Relación**

![Ejemplo 1: Sistema de Biblioteca](diagramas/ej01_biblioteca.png)

[Ver código MySQL](sql/ej01_biblioteca.sql)

### Ejemplo 2: Pedidos de Restaurante

**Contexto del ejercicio**

Los clientes realizan pedidos que contienen varios platos con distinta cantidad. Los platos se agrupan en categorías. Cada pedido lo atiende un único mesero. El precio del plato debe registrarse tal como estaba al momento del pedido, aunque luego cambie.


**Diagrama Entidad-Relación**

![Ejemplo 2: Pedidos de Restaurante](diagramas/ej02_restaurante.png)

[Ver código MySQL](sql/ej02_restaurante.sql)

### Ejemplo 3: Clínica Médica

**Contexto del ejercicio**

Los pacientes solicitan citas; cada cita la atiende un médico a un paciente en fecha, hora y consultorio. De algunas citas se genera una receta que incluye medicamentos con dosis y duración. Cada médico pertenece a una especialidad.


**Diagrama Entidad-Relación**

![Ejemplo 3: Clínica Médica](diagramas/ej03_clinica.png)

[Ver código MySQL](sql/ej03_clinica.sql)

### Ejemplo 4: Sistema de Aerolínea

**Contexto del ejercicio**

Una aerolínea opera vuelos (cada uno con número, fecha, origen y destino), cada vuelo lo realiza un avión. Los pasajeros realizan reservas para un vuelo específico, indicando asiento y tarifa pagada en el momento de la reserva.


**Diagrama Entidad-Relación**

![Ejemplo 4: Sistema de Aerolínea](diagramas/ej04_aerolinea.png)

[Ver código MySQL](sql/ej04_aerolinea.sql)

### Ejercicio 5: Empresa Discográfica

**Contexto del ejercicio**

Una empresa discográfica necesita modelar los datos sobre sus diferentes recursos según las siguientes características:


- Manager: de cada mánager se almacena un identificador de manager y su nombre. Un manager representa a una serie de artistas.
- Artista: un artista es representado por un manager. De los artistas se almacena su nombre completo (usando un único atributo) y su NIF.
- Evento de promoción: los artistas participan en eventos de promoción para dar a conocer sus trabajos. En un evento de promoción pueden participar varios artistas. De un evento se almacena un identificador único, la fecha de celebración y el número de asistentes.

**Diagrama Entidad-Relación**

![Ejercicio 5: Empresa Discográfica](diagramas/ej05_discografica.png)

[Ver código MySQL](sql/ej05_discografica.sql)

### Ejercicio 6: Tienda Informática

**Contexto del ejercicio**

Se desea crear una aplicación para la gestión de una tienda informática. La tienda dispone de una serie de productos que se venden a los clientes. De cada producto informático se desea guardar el código, descripción, precio y número de existencias. De cada cliente se desea guardar el código, nombre, apellidos, dirección y número telefónico. Un cliente puede comprar varios productos en la tienda y un mismo producto puede ser comprado por varios clientes. Cada vez que se compre un artículo quedará registrada la compra en la base de datos junto con la fecha en la que se compró el artículo. La tienda tiene contactos con varios proveedores que son los que suministran los productos. Un mismo producto puede ser suministrado por varios proveedores. De cada proveedor se desea guardar el código, nombres, apellidos, dirección, provincia y número de teléfono.


**Diagrama Entidad-Relación**

![Ejercicio 6: Tienda Informática](diagramas/ej06_tienda_informatica.png)

[Ver código MySQL](sql/ej06_tienda_informatica.sql)

### Ejercicio 7: Discos Musicales

**Contexto del ejercicio**

- La tienda vende discos de diferentes géneros musicales y cantantes
- Cada género musical tiene un identificador
- Cada disco tiene título, género musical, precio y cantante
- De un cantante se registra el nombre y su país. Todo disco pertenece a un cantante y un cantante puede tener muchos discos. Además un disco tiene un conjunto de canciones (identificador y título)
- Un disco tiene muchas canciones y una canción puede estar en varios discos. Interesa conocer la posición de una canción en un determinado disco

**Diagrama Entidad-Relación**

![Ejercicio 7: Discos Musicales](diagramas/ej07_discos_musicales.png)

[Ver código MySQL](sql/ej07_discos_musicales.sql)

### Ejercicio 8: Camiones

**Contexto del ejercicio**

Se desea informatizar la gestión de una empresa de transporte que reparte paquetes por toda España. Los encargados de llevar los paquetes son los camioneros, de los que se quiere guardar la cédula, nombre, teléfono, dirección, salario y población en que vive. De los paquetes transportados interesa conocer el código del paquete, descripción, destinatario y dirección del destinatario.

Un camionero distribuye muchos paquetes, y un paquete sólo puede ser distribuido por un camionero. De las provincias a las que llegan los paquetes interesa guardar el código de provincia y el nombre. Un paquete sólo puede llegar a una provincia. Sin embargo, a una provincia pueden llegar varios paquetes.

De los camiones que llevan los camioneros, interesa conocer la matrícula, modelo, tipo y potencia. Un camionero puede conducir diferentes camiones en fechas diferentes, y un camión puede ser conducido por varios camioneros.


**Diagrama Entidad-Relación**

![Ejercicio 8: Camiones](diagramas/ej08_camiones.png)

[Ver código MySQL](sql/ej08_camiones.sql)

### Ejercicio 9: Veterinaria

**Contexto del ejercicio**

- Del propietario interesa: cédula, apellidos, nombres, dirección, teléfonos
- De la mascota interesa: identificador, nombre, fecha de nacimiento, tipo
- Un propietario puede llevar una o varias mascotas
- Una mascota la lleva uno y solo un propietario
- Del personal de la clínica veterinaria interesa un código, la cédula, nombre
- Entre el personal de la clínica se distingue a los veterinarios y los auxiliares, pudiendo haber otros tipos
  - Del veterinario se guarda además su fecha_alta y especialidad
  - De los auxiliares interesa su base de cotización
- Las mascotas pasan consulta con los veterinarios. De manera que:
  - un veterinario puede pasar consulta a ninguna o a varias mascotas, y
  - una misma mascota de la clínica ha pasado consulta una o más veces en fechas diferentes con varios veterinarios.
  - Al pasar consulta se realiza un diagnóstico.
- Cada propietario tiene un familiar de contacto para casos de emergencia.
  - De este familiar interesa la cédula, nombre y teléfono.
  - Si el propietario se da de alta en la clínica veterinaria, el familiar ya no interesa.
  - El familiar es contacto de un solo propietario

**Diagrama Entidad-Relación**

![Ejercicio 9: Veterinaria](diagramas/ej09_veterinaria.png)

[Ver código MySQL](sql/ej09_veterinaria.sql)

---

Christopher Alexander Pineda Rodas
