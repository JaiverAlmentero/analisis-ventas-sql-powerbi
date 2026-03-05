 
                               Bloque 1:

 Crear la base de datos
Descripción: Este comando crea la base de datos donde se almacenarán todas las tablas del proyecto de ventas.
*/

CREATE DATABASE ProyectoVentas;


              
                                 Bloque 2
Descripción: 
1. El comando USE selecciona la base de datos "ProyectoVentas" creada previamente.
2. La tabla "Ventas" almacenará todos los registros de ventas realizadas, con información de fecha, producto, cantidad, precio y ciudad.
3. Se define "Id" como PRIMARY KEY con IDENTITY para generar automáticamente un identificador único por fila.

/*
Columnas:
- Id: Identificador único de cada venta (INT, autoincremental)
- Fecha: Fecha de la venta (DATE)
- Producto: Nombre del producto vendido (VARCHAR(100))
- Cantidad: Número de unidades vendidas (INT)
- Precio: Precio unitario del producto (DECIMAL(10,2))
- Ciudad: Ciudad donde se realizó la venta (VARCHAR(100))
*/

USE ProyectoVentas;

CREATE TABLE Ventas (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATE,
    Producto VARCHAR(100),
    Cantidad INT,
    Precio DECIMAL(10,2),
    Ciudad VARCHAR(100)
);


                                 Bloque 3:


 Inserción de datos en la tabla Ventas
Descripción:
Este bloque agrega registros de ventas a la tabla "Ventas". 
Cada fila representa una venta de un producto en una fecha y ciudad específica, con la cantidad y el precio unitario.

Columnas insertadas:
- Fecha: Fecha de la venta
- Producto: Nombre del producto vendido
- Cantidad: Número de unidades vendidas
- Precio: Precio unitario del producto
- Ciudad: Ciudad donde se realizó la venta

Propósito:
Estos datos servirán para realizar análisis de ventas, como:
- Total de ventas por producto
- Ventas por ciudad
- Ingresos por fecha
- Preparación de dashboards en Power BI
*/

INSERT INTO Ventas (Fecha, Producto, Cantidad, Precio, Ciudad) VALUES
('2026-02-28','Laptop',2,2500000,'Bogotá'),
('2026-02-09','Mouse',5,80000,'Medellín'),
('2026-03-01','Teclado',3,150000,'Cali'),
('2026-03-02','Laptop',1,2500000,'Barranquilla'),
('2026-03-03','Monitor',2,900000,'Bogotá'),
('2026-01-04','Mouse',4,80000,'Cali');

 
                              Bloque 4: 

Consultas de análisis de ventas
Descripción: 
Este bloque realiza distintos análisis sobre los datos de la tabla "Ventas" para generar métricas clave:
- Total de ventas
- Ventas por ciudad
- Productos más vendidos
- Ventas de un producto específico
- Porcentaje de ventas por ciudad respecto al total

Estas consultas se pueden usar para dashboards en Power BI y reportes de gestión.
*/

/* Consulta 1: Mostrar todos los registros de ventas */
SELECT * FROM Ventas;

/* Consulta 2: Calcular el total de ventas (Cantidad * Precio) */
SELECT SUM(Cantidad * Precio) AS TotalVentas
FROM Ventas;

/* Consulta 3: Total de ventas por ciudad */
SELECT Ciudad, SUM(Cantidad * Precio) AS TotalPorCiudad
FROM Ventas
GROUP BY Ciudad;

/* Consulta 4: Total de unidades vendidas por producto, ordenado de mayor a menor */
SELECT Producto, SUM(Cantidad) AS TotalUnidades
FROM Ventas
GROUP BY Producto
ORDER BY TotalUnidades DESC;

/* Consulta 5: Total de ventas de 'Laptop' por ciudad */
SELECT Ciudad, SUM(Cantidad * Precio) AS TotalLaptop
FROM Ventas
WHERE Producto = 'Laptop'
GROUP BY Ciudad;

/* Consulta 6: Porcentaje de ventas por ciudad sobre el total */
SELECT 
    Ciudad,
    SUM(Cantidad * Precio) AS TotalPorCiudad,
    SUM(Cantidad * Precio) * 100.0 / 
        (SELECT SUM(Cantidad * Precio) FROM Ventas) 
        AS PorcentajeSobreTotal
FROM Ventas
GROUP BY Ciudad
ORDER BY TotalPorCiudad DESC;
