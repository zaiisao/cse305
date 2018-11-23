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
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    age integer NOT NULL
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor (
    actedin integer
)
INHERITS (public.person);


ALTER TABLE public.actor OWNER TO postgres;

--
-- Name: award; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.award (
    pid integer NOT NULL,
    award character varying(50) NOT NULL
);


ALTER TABLE public.award OWNER TO postgres;

--
-- Name: director; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.director (
    produced integer
)
INHERITS (public.person);


ALTER TABLE public.director OWNER TO postgres;

--
-- Name: distributedby; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.distributedby (
    subtitles character varying(50),
    language character varying(50),
    medium character varying(50),
    movid integer,
    disid integer
);


ALTER TABLE public.distributedby OWNER TO postgres;

--
-- Name: distributor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.distributor (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    headquarters character varying(50)
);


ALTER TABLE public.distributor OWNER TO postgres;

--
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    mid integer NOT NULL,
    genre character varying(50) NOT NULL
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- Name: location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location (
    did integer NOT NULL,
    location character varying(50) NOT NULL
);


ALTER TABLE public.location OWNER TO postgres;

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
    CONSTRAINT movie_duration_check CHECK ((duration > 60)),
    CONSTRAINT movie_rating_check CHECK (((rating >= 1) AND (rating <= 10))),
    CONSTRAINT movie_releasedate_check CHECK ((releasedate >= '2013-01-01'::date))
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- Name: producer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producer (
    produced integer
)
INHERITS (public.person);


ALTER TABLE public.producer OWNER TO postgres;

--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor (id, name, age, actedin) FROM stdin;
5351	Ryan Reynolds	42	1431045
\.


--
-- Data for Name: award; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.award (pid, award) FROM stdin;
\.


--
-- Data for Name: director; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.director (id, name, age, produced) FROM stdin;
\.


--
-- Data for Name: distributedby; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distributedby (subtitles, language, medium, movid, disid) FROM stdin;
\.


--
-- Data for Name: distributor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distributor (id, name, headquarters) FROM stdin;
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (mid, genre) FROM stdin;
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location (did, location) FROM stdin;
\.


--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie (id, name, duration, releasedate, rating, agerating) FROM stdin;
1431045	deadpool	109	2016-02-16	8	R
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, name, age) FROM stdin;
553409	Charles Martinet	63
\.


--
-- Data for Name: producer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producer (id, name, age, produced) FROM stdin;
\.


--
-- Name: award award_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_pkey PRIMARY KEY (pid, award);


--
-- Name: distributor distributor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distributor
    ADD CONSTRAINT distributor_pkey PRIMARY KEY (id);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (mid, genre);


--
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (did, location);


--
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: actor actor_actedin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_actedin_fkey FOREIGN KEY (actedin) REFERENCES public.movie(id);


--
-- Name: award award_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_pid_fkey FOREIGN KEY (pid) REFERENCES public.person(id);


--
-- Name: director director_produced_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_produced_fkey FOREIGN KEY (produced) REFERENCES public.movie(id);


--
-- Name: distributedby distributedby_disid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distributedby
    ADD CONSTRAINT distributedby_disid_fkey FOREIGN KEY (disid) REFERENCES public.distributor(id);


--
-- Name: distributedby distributedby_movid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distributedby
    ADD CONSTRAINT distributedby_movid_fkey FOREIGN KEY (movid) REFERENCES public.movie(id);


--
-- Name: genre genre_mid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_mid_fkey FOREIGN KEY (mid) REFERENCES public.movie(id);


--
-- Name: location location_did_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_did_fkey FOREIGN KEY (did) REFERENCES public.distributor(id);


--
-- Name: producer producer_produced_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producer
    ADD CONSTRAINT producer_produced_fkey FOREIGN KEY (produced) REFERENCES public.movie(id);


--
-- PostgreSQL database dump complete
--

