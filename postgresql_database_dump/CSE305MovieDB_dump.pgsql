--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: movie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    duration integer NOT NULL,
    releasedate date NOT NULL,
    rating integer,
    agerating character varying(50),
    genre character varying(50),
    CONSTRAINT movie_duration_check CHECK ((duration > 60)),
    CONSTRAINT movie_rating_check CHECK (((rating >= 1) AND (rating <= 10))),
    CONSTRAINT movie_releasedate_check CHECK ((releasedate >= '2013-01-01'::date))
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie (id, name, duration, releasedate, rating, agerating, genre) FROM stdin;
\.


--
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

