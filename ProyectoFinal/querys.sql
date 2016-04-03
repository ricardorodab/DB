/*Fundamentos de bases de datos: Busquedas*/

--Seleciona los juguetes mas "economicos"
SELECT nombre_juguete, codigo_de_barras
FROM juguete
WHERE precio < 200

--
CREATE VIEW marca_distribuidor AS
SELECT a.id_distribuidor, nombre_distribuidor, c.id_marca
FROM distribuidor AS a INNER JOIN distribuye_a AS b ON (a.id_distribuidor = b.id_distribuidor)
     INNER JOIN marca AS c ON (b.id_marca = c.id_marca);

(SELECT nombre_distribuidor,MAX(a.precio)
FROM jugardor AS a INNER JOIN  es_dueno_de  AS b ON (a.id_juguete = b.id_juguete)
     INNER JOIN marca_distribuidor AS c ON (b.id_marca = c.id_marca)
GROUP BY nombre_distribuidor) AS x

UNION

(SELECT nombre_distribuidor,MIN(a.precio)
FROM jugardor AS a INNER JOIN  es_dueno_de  AS b ON (a.id_juguete = b.id_juguete)
     INNER JOIN marca_distribuidor AS c ON (b.id_marca = c.id_marca)
GROUP BY nombre_distribuidor) AS y

--Selecciona los clientes que tengan alguna 'D' en su nombre
SELECT nombre_cliente,correo,tarjeta_de_credito
FROM cliente
WHERE nombre_cliente LIKE %D%;

--Selecciona el nombre,correo y tarjeta de credito cuyo pedido tenga un total de articulos mayor a 30
CREATE VIEW cliente_pedido AS
SELECT nombre_cliente
FROM cliente AS a INNER JOIN realiza_compra AS b ON (a.id_cliente = b.id_cliente)
     INNER JOIN pedido AS c ON (b.id_pedido = c.id_pedido);     

SELECT nombre_cliente,correo,tarjeta_de_credito
FROM cliente_pedido AS a INNER JOIN articulo_pedido AS b ON (a.id_articulo_pedido = b.id_articulo_pedido)
WHERE numero_articulos > 30;
