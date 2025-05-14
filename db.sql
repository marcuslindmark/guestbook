--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2025-05-14 10:28:03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16642)
-- Name: guestbook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guestbook (
    id integer NOT NULL,
    namn text NOT NULL,
    meddelande text NOT NULL
);


ALTER TABLE public.guestbook OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16641)
-- Name: guestbook_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guestbook_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guestbook_id_seq OWNER TO postgres;

--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 214
-- Name: guestbook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guestbook_id_seq OWNED BY public.guestbook.id;


--
-- TOC entry 3173 (class 2604 OID 16645)
-- Name: guestbook id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guestbook ALTER COLUMN id SET DEFAULT nextval('public.guestbook_id_seq'::regclass);


--
-- TOC entry 3319 (class 0 OID 16642)
-- Dependencies: 215
-- Data for Name: guestbook; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.guestbook (id, namn, meddelande) VALUES (1, 'Kajsa', 'Kan vi ses någon dag snart? Imorgon?');
INSERT INTO public.guestbook (id, namn, meddelande) VALUES (3, 'Marcus', 'Gillar den här webbsidan skarpt!');
INSERT INTO public.guestbook (id, namn, meddelande) VALUES (4, 'Kalle', 'Hej');
INSERT INTO public.guestbook (id, namn, meddelande) VALUES (5, 'Ronja', 'Hej! Hoppas du får en fin dag :)');
INSERT INTO public.guestbook (id, namn, meddelande) VALUES (7, 'Torsten', 'Hejsan');
INSERT INTO public.guestbook (id, namn, meddelande) VALUES (8, 'jade', 'Hej igen');


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 214
-- Name: guestbook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guestbook_id_seq', 8, true);


--
-- TOC entry 3175 (class 2606 OID 16649)
-- Name: guestbook guestbook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guestbook
    ADD CONSTRAINT guestbook_pkey PRIMARY KEY (id);


-- Completed on 2025-05-14 10:28:03

--
-- PostgreSQL database dump complete
--

