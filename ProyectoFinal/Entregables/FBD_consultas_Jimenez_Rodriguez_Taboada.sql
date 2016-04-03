-- Consulta 1:
--1. Clientes y pedidos que hayan comprando el mismo producto en el año 2015 y que su precio sea mayor a 100.

--INSERT INTO "articulo_pedido" (id_articulo_pedido,numero_articulos,total) VALUES (101,97,1572);
--INSERT INTO "pedido" (id_pedido,id_articulo_pedido,fecha_pedido) VALUES (101,101,'03/28/2015');
--INSERT INTO "transaccion" (id_pedido,id_sucursal,codigo_barras) VALUES (101,68,33);
--INSERT INTO "realiza_compra" (id_pedido,id_cliente) VALUES (101,63);



SELECT a.id_cliente, a.nombre_cliente, a.apellido_paterno_cliente,
a.apellido_materno_cliente, a.telefono_cliente, a.correo,
a.tarjeta_de_credito, b.id_pedido, b.id_articulo_pedido, b.fecha_pedido  -- Los Datos de los clientes y medidos.
FROM (cliente AS a INNER JOIN realiza_compra AS c 
ON (c.id_cliente = a.id_cliente)) INNER JOIN pedido AS b ON (b.id_pedido = c.id_pedido) -- Tablas clientes - pedidos
WHERE EXTRACT (YEAR FROM b.fecha_pedido) = 2015 --Fecha 2015
AND b.id_pedido IN (SELECT d.id_pedido
	      FROM pedido AS d INNER JOIN (transaccion AS e INNER JOIN juguete AS f ON
	      (e.codigo_barras = f.codigo_barras)) ON (d.id_pedido = e.id_pedido)
	      WHERE f.precio > 100) -- Todos los juguetes en pedidos de mas de $100
AND a.id_cliente IN (SELECT id_cliente
    		    FROM (SELECT g.id_cliente, i.codigo_barras AS cb_tabla, COUNT(i.codigo_barras) AS ccb_tabla
    		    	  FROM realiza_compra AS g INNER JOIN (pedido as h INNER JOIN
			       (transaccion AS j INNER JOIN juguete as i ON (j.codigo_barras = i.codigo_barras))
			       ON (h.id_pedido = j.id_pedido)) ON (g.id_pedido = h.id_pedido)
			       GROUP BY i.codigo_barras,g.id_cliente) AS sub_tabla
			       WHERE ccb_tabla > 1); -- Aquellos clientes que han comprado dos veces el mismo juguete.
	     	 	      

--2. Los clientes que no hayan comprado nada durante el mes de septiembre de cualquier año.


SELECT a.id_cliente, a.nombre_cliente, a.apellido_paterno_cliente,
a.apellido_materno_cliente, a.telefono_cliente, a.correo,
a.tarjeta_de_credito, b.id_pedido, b.id_articulo_pedido, b.fecha_pedido
FROM (cliente AS a INNER JOIN realiza_compra AS c
ON (c.id_cliente = a.id_cliente)) INNER JOIN pedido AS b ON (b.id_pedido = c.id_pedido) -- Tablas clientes - pedidos
WHERE EXTRACT (MONTH FROM b.fecha_pedido) != 9
AND b.id_pedido IN (SELECT d.id_pedido
              FROM pedido AS d INNER JOIN (transaccion AS e INNER JOIN juguete AS f ON
	                    (e.codigo_barras = f.codigo_barras)) ON (d.id_pedido = e.id_pedido)
			                  WHERE f.precio > 1);


--3. Aquellos clientes y pedidos que empiecen con A y hayan comprado al menos un producto.

SELECT a.id_cliente, a.nombre_cliente, a.apellido_paterno_cliente,
a.apellido_materno_cliente, a.telefono_cliente, a.correo,
a.tarjeta_de_credito, b.id_pedido, b.id_articulo_pedido, b.fecha_pedido
FROM (cliente AS a INNER JOIN realiza_compra AS c
ON (c.id_cliente = a.id_cliente)) INNER JOIN pedido AS b ON (b.id_pedido = c.id_pedido)
INNER JOIN articulo_pedido AS d ON (b.id_articulo_pedido = d.id_articulo_pedido) -- Tablas clientes - pedidos
WHERE a.nombre_cliente LIKE 'A%'
AND d.numero_articulos > 1;

--4.  Para aquellos clientes que hayan comprado al menos un producto en el año 2014 con precio mayor a 200, mostrar una leyenda de
--'Autoriado', si su costo es diferente a 20 el cliente sera 'Verificado', aquellos clientes que se llamen Bruno su leyenda sera
--'Activo', si su apellido es Santos el cliente sera 'Aprobando' y en cualquier otro caso 'En proceso'.

CREATE VIEW tablita AS
(SELECT a.id_cliente,a.nombre_cliente,a.apellido_paterno_cliente,d.*
FROM cliente AS a INNER JOIN realiza_compra AS b ON (a.id_cliente = b.id_cliente)
INNER JOIN pedido AS c ON (b.id_pedido = c.id_pedido)
INNER JOIN articulo_pedido AS d ON (c.id_articulo_pedido = d.id_articulo_pedido)
WHERE EXTRACT (YEAR FROM c.fecha_pedido) = 2014 AND numero_articulos>1 AND total > 200);

CREATE OR REPLACE FUNCTION show_message(varchar, varchar, double precision)
RETURNS varchar AS '
DECLARE
    v_name ALIAS FOR $1;
    v_apellido ALIAS FOR $2;
    v_pedido ALIAS FOR $3;
BEGIN
    IF v_name LIKE ''Bruno'' THEN
    RETURN ''Activo'';
    END IF;
    IF v_apellido LIKE ''Santos'' THEN
    RETURN ''Aprobando'';
    END IF;
    RETURN ''En proceso'';
    IF v_pedido > 20 OR v_pedido < 20 THEN
    return ''Verificando'';
    END IF;
END;
' LANGUAGE plpgsql;

SELECT nombre_cliente,apellido_paterno_cliente,show_message(nombre_cliente, apellido_paterno_cliente,total) FROM tablita;

DROP VIEW tablita;
