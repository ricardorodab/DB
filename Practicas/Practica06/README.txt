¿Por qué no se agregó la condición de No Nulidad (NOT NULL) a las columnas ID_cliente y
Genero de la tabla Cliente de la Figura 6.8?

R= Porque el ID_cliente es de tipo serial y eso la hace PRIMARY KEY en automático haciendo que por default el atributo sea no nulificable. Además el tipo serial cada que aumenta uno se incrementa.
Género no puede ser null porque decimos que los valores se encuentran solamente dentro de los valores puestos en el CHECK ('M' y 'H').


¿Por qué no se agregó la condición de No Nulidad (NOT NULL) a las columnas ID_pedido,
ID_cliente, Numero_articulos y Total de la tabla Pedido de la Figura 6.8?

R= ID_pedido no puede ser null por la misma razón que no puede ser null ID_cliente de la pregunta anterior (Porque es SERIAL).
Los otros es debido a que son de tipo INTEGER y por default el estándar SQL no acepta valores null en atributos de tipo numéricos (en su lugar, usa el 0).


INTEGRANTES:

Jiménez Méndez Ricardo
Rodríguez Abreu José Ricardo
Taboada Magallanes Ricardo
