--Jimenez Méndez Ricardo
--Rodríguez Abreu José Ricardo
--Taboada Magallanes Ricardo

-- Consulta 1
-- Cambio de orden de clasificacion y precio: Hay menos juguetes con clasificación <= 5 que con precio <= a 200.
SELECT nombre_juguete,precio
FROM juguete
WHERE clasificacion <= 5 AND precio <= 200; 

--Consulta 2
-- Consulta eficiente y no se puede mejorar la búsqueda.
SELECT nombre_distribuidor
FROM distribuidor
WHERE deuda BETWEEN 0 AND 346444;

--Consulta 3
-- Cambio de orden de fecha_pedido y total ya que hay menos pedidos hechos en una fecha que con una cantidad.
SELECT id_pedido,numero_articulo,total
FROM pedido
WHERE fecha_pedido IN ('02/08/2014','08/28/2015') AND total >= 700000;

--Consulta 4
-- Primero buscamos apellido_paterno_empleado LIKE '%Be%' ya que hay más probabilidad que nombre_empleado 'Ju%'
SELECT *
FROM empleado
WHERE  apellido_paterno_empleado LIKE '%Be%' OR nombre_empleado LIKE 'Ju%'
GROUP BY id_empleado,fecha_de_nacimiento;

--Consulta 5
-- Consulta eficiente y no se puede mejorar el tiempo de búsqueda
SELECT *, SUM(total)
FROM pedido
WHERE total BETWEEN 400000 AND 800000 
GROUP BY id_pedido;

--Consulta 6
-- La consulta ya esta eficientada.
SELECT telefono_sucursal,SUM(balance_sucursal)
FROM sucursal
GROUP BY telefono_sucursal,nombre_sucursal; 

--Consulta 7
-- Cambio de cliente RIGHT JOIN realiza_compra. Tenemos menos realiza_compra que cliente.
SELECT nombre_cliente, correo
FROM realiza_compra B LEFT JOIN cliente A
ON A.id_cliente = B.cliente_realiza_compra
WHERE correo LIKE '%@hotmail.com';

--Consulta 8
-- Cambio de empleado INNER JOIN trabaja_en: Lo hacemos al revés para revisar menos casos. 
SELECT id_empleado,nombre_empleado
FROM trabaja_en B INNER JOIN empleado A 
ON A.id_empleado = B.empleado_trabaja_en
WHERE sucursal_trabaja_en = 3;	

--Consulta 9
-- Cambio de distribuidor A LEFT JOIN distribuye_a B: Tenemos menos distribye_a y revisa menos tuplas.
SELECT id_distribuidor,deuda
FROM  distribuye_a B RIGHT JOIN distribuidor A
ON A.id_distribuidor = B.distribuidor_distribuye_a
WHERE marca_distribuye_a >= 3;

--Consulta 10
-- Cambio de juguete INNER JOIN transaccion: Tenemos menos transacciones y revisa menos tuplas.
EXPLAIN SELECT nombre_juguete,SUM(precio)
FROM transaccion B INNER JOIN juguete A 
ON A.codigo_de_barras = B.codigo_transaccion
GROUP BY codigo_de_barras;

-- Creación de indice.
CREATE INDEX INDX_nombre_juguete
ON juguete (nombre_juguete);
