CREATE database rickys_toys;

\connect rickys_toys


CREATE TABLE juguete (
    codigo_barras integer NOT NULL PRIMARY KEY,
    nombre_juguete character varying(250) NOT NULL,
    precio double precision CHECK (precio >= 0),
    clasificacion integer NOT NULL
);

CREATE TABLE sucursal (
    id_sucursal integer NOT NULL PRIMARY KEY,
    nombre_sucursal character varying(250) NOT NULL,
    telefono_sucursal bigint NOT NULL
);


CREATE TABLE cliente (
    id_cliente integer NOT NULL PRIMARY KEY,
    nombre_cliente character varying(230) NOT NULL,
    apellido_paterno_cliente character varying(230),
    apellido_materno_cliente character varying(230),
    telefono_cliente bigint,
    correo character varying(50) NOT NULL,
    tarjeta_de_credito bigint
);


CREATE TABLE distribuidor (
    id_distribuidor integer NOT NULL PRIMARY KEY,
    nombre_distribuidor character varying(220) NOT NULL
);


CREATE TABLE marca (
    id_marca integer NOT NULL PRIMARY KEY,
    nombre_marca character varying(220) NOT NULL
);

CREATE TABLE posicion (
   id_posicion integer NOT NULL PRIMARY KEY,
   posicion character varying(250) NOT NULL
);

CREATE TABLE articulo_pedido(
       id_articulo_pedido integer NOT NULL PRIMARY KEY,
       numero_articulos integer NOT NULL,
       total double precision CHECK (total >= 0)
);


CREATE TABLE empleado (
    id_empleado integer NOT NULL PRIMARY KEY,
    id_posicion integer NOT NULL,
    rfc_empleado character varying(215) NOT NULL,
    nombre_empleado character varying(230) NOT NULL,
    apellido_materno_empleado character varying(230) NOT NULL,
    apellido_paterno_empleado character varying(230) NOT NULL,
    fecha_nacimiento date NOT NULL, 
    FOREIGN KEY (id_posicion) REFERENCES posicion(id_posicion)
);

CREATE TABLE distribuye_a (
    id_distribuidor integer NOT NULL PRIMARY KEY,
    id_marca integer NOT NULL,
    FOREIGN KEY (id_distribuidor) REFERENCES distribuidor(id_distribuidor),
    FOREIGN KEY (id_marca) REFERENCES marca(id_marca));


CREATE TABLE es_dueno_de (
    codigo_barras integer NOT NULL PRIMARY KEY,
    id_marca integer NOT NULL,
    deuda double precision NOT NULL,
    FOREIGN KEY (codigo_barras) REFERENCES juguete(codigo_barras),
    FOREIGN KEY (id_marca) REFERENCES marca(id_marca));


CREATE TABLE pedido (
    id_pedido integer NOT NULL PRIMARY KEY,
    id_articulo_pedido integer NOT NULL,
    fecha_pedido timestamp without time zone NOT NULL,
    FOREIGN KEY (id_articulo_pedido) REFERENCES articulo_pedido(id_articulo_pedido)
);


CREATE TABLE realiza_compra (
    id_cliente integer NOT NULL,
    id_pedido integer NOT NULL PRIMARY KEY,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido));


CREATE TABLE trabaja_en (
    id_empleado integer NOT NULL PRIMARY KEY,
    id_sucursal integer NOT NULL,
    fecha_ingreso date NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

CREATE TABLE transaccion (
    codigo_barras integer NOT NULL,
    id_pedido integer NOT NULL,
    id_sucursal integer NOT NULL,		
    PRIMARY KEY (codigo_barras, id_pedido, id_sucursal),     
    FOREIGN KEY (codigo_barras) REFERENCES juguete(codigo_barras),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
);

CREATE TABLE direccion_cliente (
    id_cliente integer NOT NULL PRIMARY KEY,
    calle_cliente character varying(250) NOT NULL,
    estado_cliente character varying(230) NOT NULL,
    numero_cliente integer NOT NULL,
    colonia_cliente character varying(250) NOT NULL,
    municipio_cliente character varying(250) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) 
);

CREATE TABLE direccion_sucursal (
    id_sucursal integer NOT NULL PRIMARY KEY,
    calle_sucursal character varying(250) NOT NULL,
    estado_sucursal character varying(230) NOT NULL,
    numero_sucursal integer NOT NULL,
    colonia_sucursal character varying(250) NOT NULL,
    municipio_sucursal character varying(250) NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal) 
);


