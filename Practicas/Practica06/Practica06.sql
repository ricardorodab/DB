
CREATE TABLE cliente (
    id_cliente integer NOT NULL PRIMARY KEY,
    nombre_cliente character varying(30) NOT NULL,
    apellido_paterno_cliente character varying(30),
    apellido_materno_cliente character varying(30),
    telefono_cliente bigint,
    correo character varying(50) NOT NULL,
    tarjeta_de_credito bigint
);

CREATE TABLE direccion_cliente (
    id_direccion_cliente integer NOT NULL PRIMARY KEY,
    calle_cliente character varying(50),
    estado_cliente character varying(30),
    numero_cliente integer,
    colonia_cliente character varying(50),
    municipio_cliente character varying(50)
);

CREATE TABLE direccion_sucursal (
    id_direccion_sucursal integer NOT NULL PRIMARY KEY,
    calle_sucursal character varying(50),
    estado_sucursal character varying(30),
    numero_sucursal integer,
    colonia_sucursal character varying(50),
    municipio_sucursal character varying(50)
);


CREATE TABLE distribuidor (
    id_distribuidor integer NOT NULL PRIMARY KEY,
    nombre_distribuidor character varying(20),
    deuda double precision CHECK (deuda >= 0)
);


CREATE TABLE marca (
    id_marca integer NOT NULL PRIMARY KEY,
    nombre_marca character varying(20)
);

CREATE TABLE distribuye_a (
    distribuidor_distribuye_a integer,
    marca_distribuye_a integer,
    FOREIGN KEY (distribuidor_distribuye_a) REFERENCES distribuidor(id_distribuidor),
    FOREIGN KEY (marca_distribuye_a) REFERENCES marca(id_marca));

CREATE TABLE empleado (
    id_empleado integer NOT NULL PRIMARY KEY,
    rfc_empleado character varying(15),
    nombre_empleado character varying(30) NOT NULL,
    apellido_materno_empleado character varying(30),
    apellido_paterno_empleado character varying(30),
    fecha_de_nacimiento date,
    fecha_de_ingreso date,
    posicion character varying(50)
);


CREATE TABLE juguete (
    codigo_de_barras bigint NOT NULL PRIMARY KEY,
    nombre_juguete character varying(50) NOT NULL,
    precio double precision CHECK (precio >= 0),
    clasificacion integer
);

CREATE TABLE es_dueno_de (
    codigo_es_dueno_de bigint,
    marca_es_dueno_de integer,
    FOREIGN KEY (codigo_es_dueno_de) REFERENCES juguete(codigo_de_barras),
    FOREIGN KEY (marca_es_dueno_de) REFERENCES marca(id_marca));


CREATE TABLE pedido (
    id_pedido integer NOT NULL PRIMARY KEY,
    numero_articulo integer CHECK (numero_articulo > 0),
    total double precision,
    fecha_pedido timestamp without time zone
);

CREATE TABLE realiza_compra (
    cliente_realiza_compra integer,
    pedido_realiza_compra integer,
    FOREIGN KEY (cliente_realiza_compra) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (pedido_realiza_compra) REFERENCES pedido(id_pedido));


CREATE TABLE sucursal (
    id_sucursal integer NOT NULL PRIMARY KEY,
    nombre_sucursal character varying(30),
    telefono_sucursal bigint,
    balance_sucursal double precision
);


CREATE TABLE se_vende_en (
    codigo_se_vende_en bigint,
    sucursal_se_vende_en integer,
    FOREIGN KEY (codigo_se_vende_en) REFERENCES juguete(codigo_de_barras),
    FOREIGN KEY (sucursal_se_vende_en) REFERENCES sucursal(id_sucursal));


CREATE TABLE trabaja_en (
    sucursal_trabaja_en integer,
    empleado_trabaja_en integer,
    FOREIGN KEY (empleado_trabaja_en) REFERENCES empleado(id_empleado),
    FOREIGN KEY (sucursal_trabaja_en) REFERENCES sucursal(id_sucursal));

CREATE TABLE transaccion (
    codigo_transaccion bigint,
    pedido_transaccion integer,
    FOREIGN KEY (codigo_transaccion) REFERENCES juguete(codigo_de_barras),
    FOREIGN KEY (pedido_transaccion) REFERENCES pedido(id_pedido));

