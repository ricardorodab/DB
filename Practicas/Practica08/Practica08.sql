--Jimenez Méndez Ricardo
--Rodríguez Abreu José Ricardo
--Taboada Magallanes Ricardo

-- Consulta 1
SELECT nombre_juguete,precio
FROM juguete
WHERE precio <= 200 AND clasificacion <= 5; 

--Consulta 2
SELECT nombre_distribuidor
FROM distribuidor
WHERE deuda BETWEEN 0 AND 346444;

--Consulta 3
SELECT id_pedido,numero_articulo,total
FROM pedido
WHERE total >= 700000 AND fecha_pedido IN ('02/08/2014','08/28/2015');

--Consulta 4
SELECT *
FROM empleado
WHERE nombre_empleado LIKE 'Ju%' OR apellido_paterno_empleado LIKE '%Be%'
GROUP BY id_empleado,fecha_de_nacimiento;

--Consulta 5
SELECT *, SUM(total)
FROM pedido
WHERE total BETWEEN 400000 AND 800000 
GROUP BY id_pedido;

--Consulta 6
SELECT telefono_sucursal,SUM(balance_sucursal)
FROM sucursal
GROUP BY telefono_sucursal,nombre_sucursal; 

--Consulta 7
SELECT nombre_cliente, correo
FROM cliente A RIGHT JOIN realiza_compra B
ON A.id_cliente = B.cliente_realiza_compra
WHERE correo LIKE '%@hotmail.com';

--Consulta 8
SELECT id_empleado,nombre_empleado
FROM empleado A INNER JOIN trabaja_en B
ON A.id_empleado = B.empleado_trabaja_en
WHERE sucursal_trabaja_en = 3;	

--Consulta 9
SELECT id_distribuidor,deuda
FROM distribuidor A LEFT JOIN distribuye_a B
ON A.id_distribuidor = B.distribuidor_distribuye_a
WHERE marca_distribuye_a >= 3;

--Consulta 10
SELECT nombre_juguete,SUM(precio)
FROM juguete A INNER JOIN transaccion B
ON A.codigo_de_barras = B.codigo_transaccion
GROUP BY codigo_de_barras;


