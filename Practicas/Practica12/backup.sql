--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: sp_elimina_juguete_viejo(integer); Type: FUNCTION; Schema: public; Owner: ricardo_rodab
--

CREATE FUNCTION sp_elimina_juguete_viejo(codigo integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN

DELETE FROM juguete
WHERE codigo_de_barras = codigo;

RETURN 'Borrado_Exitosa';

END;
$$;


ALTER FUNCTION public.sp_elimina_juguete_viejo(codigo integer) OWNER TO ricardo_rodab;

--
-- Name: sp_inserta_juguete_nuevo(integer, character varying, double precision, integer); Type: FUNCTION; Schema: public; Owner: ricardo_rodab
--

CREATE FUNCTION sp_inserta_juguete_nuevo(codigo integer, nombre character varying, precio1 double precision, clasificacion1 integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN

INSERT INTO juguete (codigo_de_barras, nombre_juguete,precio, clasificacion) VALUES (codigo, nombre, precio1, clasificacion1);

RETURN 'Insercion_Exitosa';

END;
$$;


ALTER FUNCTION public.sp_inserta_juguete_nuevo(codigo integer, nombre character varying, precio1 double precision, clasificacion1 integer) OWNER TO ricardo_rodab;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE cliente (
    id_cliente integer NOT NULL,
    nombre_cliente character varying(30) NOT NULL,
    apellido_paterno_cliente character varying(30),
    apellido_materno_cliente character varying(30),
    telefono_cliente bigint,
    correo character varying(50) NOT NULL,
    tarjeta_de_credito bigint
);


ALTER TABLE cliente OWNER TO ricardo_rodab;

--
-- Name: direccion_cliente; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE direccion_cliente (
    id_direccion_cliente integer NOT NULL,
    calle_cliente character varying(50),
    estado_cliente character varying(30),
    numero_cliente integer,
    colonia_cliente character varying(50),
    municipio_cliente character varying(50)
);


ALTER TABLE direccion_cliente OWNER TO ricardo_rodab;

--
-- Name: direccion_sucursal; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE direccion_sucursal (
    id_direccion_sucursal integer NOT NULL,
    calle_sucursal character varying(50),
    estado_sucursal character varying(30),
    numero_sucursal integer,
    colonia_sucursal character varying(50),
    municipio_sucursal character varying(50)
);


ALTER TABLE direccion_sucursal OWNER TO ricardo_rodab;

--
-- Name: distribuidor; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE distribuidor (
    id_distribuidor integer NOT NULL,
    nombre_distribuidor character varying(20),
    deuda double precision,
    CONSTRAINT distribuidor_deuda_check CHECK ((deuda >= (0)::double precision))
);


ALTER TABLE distribuidor OWNER TO ricardo_rodab;

--
-- Name: distribuye_a; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE distribuye_a (
    distribuidor_distribuye_a integer,
    marca_distribuye_a integer
);


ALTER TABLE distribuye_a OWNER TO ricardo_rodab;

--
-- Name: empleado; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE empleado (
    id_empleado integer NOT NULL,
    rfc_empleado character varying(15),
    nombre_empleado character varying(30) NOT NULL,
    apellido_materno_empleado character varying(30),
    apellido_paterno_empleado character varying(30),
    fecha_de_nacimiento date,
    fecha_de_ingreso date,
    posicion character varying(50)
);


ALTER TABLE empleado OWNER TO ricardo_rodab;

--
-- Name: es_dueno_de; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE es_dueno_de (
    codigo_es_dueno_de bigint,
    marca_es_dueno_de integer
);


ALTER TABLE es_dueno_de OWNER TO ricardo_rodab;

--
-- Name: juguete; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE juguete (
    codigo_de_barras bigint NOT NULL,
    nombre_juguete character varying(50) NOT NULL,
    precio double precision,
    clasificacion integer,
    CONSTRAINT juguete_precio_check CHECK ((precio >= (0)::double precision))
);


ALTER TABLE juguete OWNER TO ricardo_rodab;

--
-- Name: marca; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE marca (
    id_marca integer NOT NULL,
    nombre_marca character varying(20)
);


ALTER TABLE marca OWNER TO ricardo_rodab;

--
-- Name: pedido; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE pedido (
    id_pedido integer NOT NULL,
    numero_articulo integer,
    total double precision,
    fecha_pedido timestamp without time zone,
    CONSTRAINT pedido_numero_articulo_check CHECK ((numero_articulo > 0))
);


ALTER TABLE pedido OWNER TO ricardo_rodab;

--
-- Name: realiza_compra; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE realiza_compra (
    cliente_realiza_compra integer,
    pedido_realiza_compra integer
);


ALTER TABLE realiza_compra OWNER TO ricardo_rodab;

--
-- Name: se_vende_en; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE se_vende_en (
    codigo_se_vende_en bigint,
    sucursal_se_vende_en integer
);


ALTER TABLE se_vende_en OWNER TO ricardo_rodab;

--
-- Name: sucursal; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE sucursal (
    id_sucursal integer NOT NULL,
    nombre_sucursal character varying(30),
    telefono_sucursal bigint,
    balance_sucursal double precision
);


ALTER TABLE sucursal OWNER TO ricardo_rodab;

--
-- Name: trabaja_en; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE trabaja_en (
    sucursal_trabaja_en integer,
    empleado_trabaja_en integer
);


ALTER TABLE trabaja_en OWNER TO ricardo_rodab;

--
-- Name: transaccion; Type: TABLE; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE TABLE transaccion (
    codigo_transaccion bigint,
    pedido_transaccion integer
);


ALTER TABLE transaccion OWNER TO ricardo_rodab;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY cliente (id_cliente, nombre_cliente, apellido_paterno_cliente, apellido_materno_cliente, telefono_cliente, correo, tarjeta_de_credito) FROM stdin;
1	Ernesto	Melano	Rosa	5532843750	romeler@gmail.com	3628304716284635
2	Diana	Castillo	Salazar	5528351423	dianita_moxita@hotmail.com	2415362734079352
3	Jose Ricardo	Rodriguez	Abreu	5526542430	ricardo_rodab@hotmail.com	1029384756102938
4	Edgar	Molina	Renal	5523182935	remol@hotmail.com	2638142068535614
\.


--
-- Data for Name: direccion_cliente; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY direccion_cliente (id_direccion_cliente, calle_cliente, estado_cliente, numero_cliente, colonia_cliente, municipio_cliente) FROM stdin;
1	Tecacalo	Distrito Federal	6	Adolfo Ruiz Cortines	Coyoacán
2	684-6130 Mattis Street	Sląskie	14	8339 Donec Avenue	Z.
3	P.O. Box 258, 3253 Vel, Ave	North Island	82	935-8605 Pulvinar Av.	Ank
4	1372 Vel, St.	Virginia	81	902-1158 Diam. St.	Alajuela
5	Ap #567-6440 Orci. St.	Overijssel	58	P.O. Box 387, 5296 Aliquam Ave	Alajuela
\.


--
-- Data for Name: direccion_sucursal; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY direccion_sucursal (id_direccion_sucursal, calle_sucursal, estado_sucursal, numero_sucursal, colonia_sucursal, municipio_sucursal) FROM stdin;
2	Calzada de Tlalpan	Distrito Federal	1024	Portales	Coyoacán
3	Calzada del Hueso	Distrito Federal	22	Bordo	Tlalpan
1	6331 Lorem, Ave	NI	67	Ap #302-8455 Suspendisse Ave	South Island
11	8341 Integer St.	WB	72	9650 Nunc Street	MP
41	P.O. Box 565, 7116 Lorem, Avenue	West Bengal	45	406-3848 Semper Rd.	Vienna
\.


--
-- Data for Name: distribuidor; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY distribuidor (id_distribuidor, nombre_distribuidor, deuda) FROM stdin;
1	Pulvinar Inc.	346444
2	Non Institute	126528
3	Nunc Institute	159333
4	Massa Suspendisse	917927
5	Neque PC	998212
\.


--
-- Data for Name: distribuye_a; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY distribuye_a (distribuidor_distribuye_a, marca_distribuye_a) FROM stdin;
1	1
2	2
3	3
4	4
5	5
\.


--
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY empleado (id_empleado, rfc_empleado, nombre_empleado, apellido_materno_empleado, apellido_paterno_empleado, fecha_de_nacimiento, fecha_de_ingreso, posicion) FROM stdin;
1	AAFJ900101G47	Jesus	Alcazar	Figueroa	1990-01-01	2011-06-05	Gerente
3	JUCH920303MW8	Juan	Cordero	Hernandez	1992-03-03	2013-01-11	Vendedor
4	JUDI930404CC8	Juana	Daza	Iglesias	1993-04-04	2013-12-11	Vendedor
5	JOEJ940505GY5	Josefina	Ejido	Jimenez	1994-05-05	2012-04-04	Limpieza
2	BEGJ910202499	Rigoberto	Benitez	Gonzalez	1991-02-02	2011-03-05	Gerente
\.


--
-- Data for Name: es_dueno_de; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY es_dueno_de (codigo_es_dueno_de, marca_es_dueno_de) FROM stdin;
7506129404567	1
1274303598135	2
3790283417778	3
4915801055838	4
1314151617229	5
\.


--
-- Data for Name: juguete; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY juguete (codigo_de_barras, nombre_juguete, precio, clasificacion) FROM stdin;
7506129404567	Cubo Rubik	200	12
3790283417778	Señor Cara de Papa: Original	300	5
4915801055838	Max Steel: Brigada Nocturna	500	5
1314151617229	Playmobile: Payaso Asesino	200	5
1274303598135	Patricio Inflable	150	3
\.


--
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY marca (id_marca, nombre_marca) FROM stdin;
1	Hasbro
2	Lego
3	Mattel
4	Duncan
5	Play mobile
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY pedido (id_pedido, numero_articulo, total, fecha_pedido) FROM stdin;
1	7062730	773753	2015-08-28 00:00:00
2	3439978	74492	2014-12-14 00:00:00
3	1716506	950034	2016-09-24 00:00:00
4	7327886	449152	2015-06-19 00:00:00
5	1748592	773885	2014-02-08 00:00:00
\.


--
-- Data for Name: realiza_compra; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY realiza_compra (cliente_realiza_compra, pedido_realiza_compra) FROM stdin;
1	1
2	2
3	3
4	4
\.


--
-- Data for Name: se_vende_en; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY se_vende_en (codigo_se_vende_en, sucursal_se_vende_en) FROM stdin;
7506129404567	1
1274303598135	2
3790283417778	3
4915801055838	4
1314151617229	5
\.


--
-- Data for Name: sucursal; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY sucursal (id_sucursal, nombre_sucursal, telefono_sucursal, balance_sucursal) FROM stdin;
1	Universidad	5531084278	1000
2	Perisur	5540888362	300
3	Hueso	5555674350	600
4	Tepito	5554218903	20
5	Alaska	8004454435	2000
\.


--
-- Data for Name: trabaja_en; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY trabaja_en (sucursal_trabaja_en, empleado_trabaja_en) FROM stdin;
3	3
4	4
5	5
\.


--
-- Data for Name: transaccion; Type: TABLE DATA; Schema: public; Owner: ricardo_rodab
--

COPY transaccion (codigo_transaccion, pedido_transaccion) FROM stdin;
7506129404567	1
1274303598135	2
3790283417778	3
4915801055838	4
1314151617229	5
\.


--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- Name: direccion_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY direccion_cliente
    ADD CONSTRAINT direccion_cliente_pkey PRIMARY KEY (id_direccion_cliente);


--
-- Name: direccion_sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY direccion_sucursal
    ADD CONSTRAINT direccion_sucursal_pkey PRIMARY KEY (id_direccion_sucursal);


--
-- Name: distribuidor_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY distribuidor
    ADD CONSTRAINT distribuidor_pkey PRIMARY KEY (id_distribuidor);


--
-- Name: empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (id_empleado);


--
-- Name: juguete_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY juguete
    ADD CONSTRAINT juguete_pkey PRIMARY KEY (codigo_de_barras);


--
-- Name: marca_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (id_marca);


--
-- Name: pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido);


--
-- Name: sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

ALTER TABLE ONLY sucursal
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (id_sucursal);


--
-- Name: indx_nombre_juguete; Type: INDEX; Schema: public; Owner: ricardo_rodab; Tablespace: 
--

CREATE INDEX indx_nombre_juguete ON juguete USING btree (nombre_juguete);


--
-- Name: distribuye_a_distribuidor_distribuye_a_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY distribuye_a
    ADD CONSTRAINT distribuye_a_distribuidor_distribuye_a_fkey FOREIGN KEY (distribuidor_distribuye_a) REFERENCES distribuidor(id_distribuidor);


--
-- Name: distribuye_a_marca_distribuye_a_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY distribuye_a
    ADD CONSTRAINT distribuye_a_marca_distribuye_a_fkey FOREIGN KEY (marca_distribuye_a) REFERENCES marca(id_marca);


--
-- Name: es_dueno_de_codigo_es_dueno_de_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY es_dueno_de
    ADD CONSTRAINT es_dueno_de_codigo_es_dueno_de_fkey FOREIGN KEY (codigo_es_dueno_de) REFERENCES juguete(codigo_de_barras);


--
-- Name: es_dueno_de_marca_es_dueno_de_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY es_dueno_de
    ADD CONSTRAINT es_dueno_de_marca_es_dueno_de_fkey FOREIGN KEY (marca_es_dueno_de) REFERENCES marca(id_marca);


--
-- Name: realiza_compra_cliente_realiza_compra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY realiza_compra
    ADD CONSTRAINT realiza_compra_cliente_realiza_compra_fkey FOREIGN KEY (cliente_realiza_compra) REFERENCES cliente(id_cliente) ON DELETE CASCADE;


--
-- Name: realiza_compra_pedido_realiza_compra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY realiza_compra
    ADD CONSTRAINT realiza_compra_pedido_realiza_compra_fkey FOREIGN KEY (pedido_realiza_compra) REFERENCES pedido(id_pedido);


--
-- Name: se_vende_en_codigo_se_vende_en_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY se_vende_en
    ADD CONSTRAINT se_vende_en_codigo_se_vende_en_fkey FOREIGN KEY (codigo_se_vende_en) REFERENCES juguete(codigo_de_barras);


--
-- Name: se_vende_en_sucursal_se_vende_en_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY se_vende_en
    ADD CONSTRAINT se_vende_en_sucursal_se_vende_en_fkey FOREIGN KEY (sucursal_se_vende_en) REFERENCES sucursal(id_sucursal);


--
-- Name: trabaja_en_empleado_trabaja_en_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY trabaja_en
    ADD CONSTRAINT trabaja_en_empleado_trabaja_en_fkey FOREIGN KEY (empleado_trabaja_en) REFERENCES empleado(id_empleado);


--
-- Name: trabaja_en_sucursal_trabaja_en_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY trabaja_en
    ADD CONSTRAINT trabaja_en_sucursal_trabaja_en_fkey FOREIGN KEY (sucursal_trabaja_en) REFERENCES sucursal(id_sucursal);


--
-- Name: transaccion_codigo_transaccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT transaccion_codigo_transaccion_fkey FOREIGN KEY (codigo_transaccion) REFERENCES juguete(codigo_de_barras);


--
-- Name: transaccion_pedido_transaccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ricardo_rodab
--

ALTER TABLE ONLY transaccion
    ADD CONSTRAINT transaccion_pedido_transaccion_fkey FOREIGN KEY (pedido_transaccion) REFERENCES pedido(id_pedido);


--
-- Name: public; Type: ACL; Schema: -; Owner: ricardo_rodab
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM ricardo_rodab;
GRANT ALL ON SCHEMA public TO ricardo_rodab;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: direccion_cliente; Type: ACL; Schema: public; Owner: ricardo_rodab
--

REVOKE ALL ON TABLE direccion_cliente FROM PUBLIC;
REVOKE ALL ON TABLE direccion_cliente FROM ricardo_rodab;
GRANT ALL ON TABLE direccion_cliente TO ricardo_rodab;


--
-- Name: direccion_sucursal; Type: ACL; Schema: public; Owner: ricardo_rodab
--

REVOKE ALL ON TABLE direccion_sucursal FROM PUBLIC;
REVOKE ALL ON TABLE direccion_sucursal FROM ricardo_rodab;
GRANT ALL ON TABLE direccion_sucursal TO ricardo_rodab;


--
-- Name: distribuidor; Type: ACL; Schema: public; Owner: ricardo_rodab
--

REVOKE ALL ON TABLE distribuidor FROM PUBLIC;
REVOKE ALL ON TABLE distribuidor FROM ricardo_rodab;
GRANT ALL ON TABLE distribuidor TO ricardo_rodab;
GRANT SELECT ON TABLE distribuidor TO atd WITH GRANT OPTION;


--
-- Name: empleado; Type: ACL; Schema: public; Owner: ricardo_rodab
--

REVOKE ALL ON TABLE empleado FROM PUBLIC;
REVOKE ALL ON TABLE empleado FROM ricardo_rodab;
GRANT ALL ON TABLE empleado TO ricardo_rodab;
GRANT SELECT ON TABLE empleado TO atd WITH GRANT OPTION;


--
-- Name: juguete; Type: ACL; Schema: public; Owner: ricardo_rodab
--

REVOKE ALL ON TABLE juguete FROM PUBLIC;
REVOKE ALL ON TABLE juguete FROM ricardo_rodab;
GRANT ALL ON TABLE juguete TO ricardo_rodab;
GRANT SELECT ON TABLE juguete TO migmor WITH GRANT OPTION;


--
-- Name: marca; Type: ACL; Schema: public; Owner: ricardo_rodab
--

REVOKE ALL ON TABLE marca FROM PUBLIC;
REVOKE ALL ON TABLE marca FROM ricardo_rodab;
GRANT ALL ON TABLE marca TO ricardo_rodab;
GRANT SELECT ON TABLE marca TO migmor WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

