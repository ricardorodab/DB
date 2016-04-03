-- Procedimiento almacenado:

CREATE OR REPLACE FUNCTION pago_empleados ()

RETURNS TABLE(
id_pago INTEGER,
nombre VARCHAR(100),
pago numeric
) AS
$$
BEGIN

RETURN QUERY
SELECT a.id_empleado,a.nombre_empleado,( ( ( ( CURRENT_DATE - b.fecha_ingreso) / 365) + 1) * 70.10)
FROM empleado AS a INNER JOIN trabaja_en AS b ON
(a.id_empleado = b.id_empleado);
END;
$$
LANGUAGE 'plpgsql';

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
