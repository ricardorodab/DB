CREATE OR REPLACE FUNCTION SP_inserta_juguete_nuevo
(codigo INTEGER,
nombre VARCHAR(50),
precio1 DOUBLE PRECISION,
clasificacion1 INTEGER)

RETURNS VARCHAR(20)
AS
$$
BEGIN

INSERT INTO juguete (codigo_de_barras, nombre_juguete,precio, clasificacion) VALUES (codigo, nombre, precio1, clasificacion1);

RETURN 'Insercion_Exitosa';

END;
$$
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION SP_elimina_juguete_viejo
(codigo INTEGER)

RETURNS VARCHAR(20)
AS
$$
BEGIN

DELETE FROM juguete
WHERE codigo_de_barras = codigo;

RETURN 'Borrado_Exitosa';

END;
$$
LANGUAGE 'plpgsql';
