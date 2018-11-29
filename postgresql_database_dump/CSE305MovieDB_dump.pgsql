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
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.people (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    age integer NOT NULL
);


ALTER TABLE public.people OWNER TO postgres;

--
-- Name: actors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actors (
    actedin integer
)
INHERITS (public.people);


ALTER TABLE public.actors OWNER TO postgres;

--
-- Name: awards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.awards (
    pid integer NOT NULL,
    award character varying(50) NOT NULL
);


ALTER TABLE public.awards OWNER TO postgres;

--
-- Name: directors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directors (
    produced integer
)
INHERITS (public.people);


ALTER TABLE public.directors OWNER TO postgres;

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
-- Name: distributors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.distributors (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    headquarters character varying(50)
);


ALTER TABLE public.distributors OWNER TO postgres;

--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    mid integer NOT NULL,
    genre character varying(50) NOT NULL
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    did integer NOT NULL,
    location character varying(50) NOT NULL
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    duration integer NOT NULL,
    releasedate date NOT NULL,
    rating integer,
    agerating character varying(50),
    description text,
    imgurl text,
    videourl text,
    CONSTRAINT movie_duration_check CHECK ((duration > 60)),
    CONSTRAINT movie_rating_check CHECK (((rating >= 1) AND (rating <= 10))),
    CONSTRAINT movie_releasedate_check CHECK ((releasedate >= '2013-01-01'::date))
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: producers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producers (
    produced integer
)
INHERITS (public.people);


ALTER TABLE public.producers OWNER TO postgres;

--
-- Data for Name: actors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actors (id, name, age, actedin) FROM stdin;
5351	Ryan Reynolds	42	1431045
\.


--
-- Data for Name: awards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.awards (pid, award) FROM stdin;
\.


--
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directors (id, name, age, produced) FROM stdin;
\.


--
-- Data for Name: distributedby; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distributedby (subtitles, language, medium, movid, disid) FROM stdin;
\.


--
-- Data for Name: distributors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distributors (id, name, headquarters) FROM stdin;
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (mid, genre) FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (did, location) FROM stdin;
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (id, name, duration, releasedate, rating, agerating, description, imgurl, videourl) FROM stdin;
1431045	deadpool	109	2016-02-16	8	R	A fast-talking mercenary with a morbid sense of humor is subjected to a rogue experiment that leaves him with accelerated healing powers and a quest for revenge.	https://upload.wikimedia.org/wikipedia/en/2/23/Deadpool_%282016_poster%29.png	https://www.youtube.com/watch?v=ONHBaC-pfsk
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.people (id, name, age) FROM stdin;
553409	Charles Martinet	63
\.


--
-- Data for Name: producers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producers (id, name, age, produced) FROM stdin;
\.


--
-- Name: awards award_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.awards
    ADD CONSTRAINT award_pkey PRIMARY KEY (pid, award);


--
-- Name: distributors distributor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distributors
    ADD CONSTRAINT distributor_pkey PRIMARY KEY (id);


--
-- Name: genres genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genre_pkey PRIMARY KEY (mid, genre);


--
-- Name: locations location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT location_pkey PRIMARY KEY (did, location);


--
-- Name: movies movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- Name: people person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: actors actor_actedin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actor_actedin_fkey FOREIGN KEY (actedin) REFERENCES public.movies(id);


--
-- Name: awards award_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.awards
    ADD CONSTRAINT award_pid_fkey FOREIGN KEY (pid) REFERENCES public.people(id);


--
-- Name: directors director_produced_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directors
    ADD CONSTRAINT director_produced_fkey FOREIGN KEY (produced) REFERENCES public.movies(id);


--
-- Name: distributedby distributedby_disid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distributedby
    ADD CONSTRAINT distributedby_disid_fkey FOREIGN KEY (disid) REFERENCES public.distributors(id);


--
-- Name: distributedby distributedby_movid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distributedby
    ADD CONSTRAINT distributedby_movid_fkey FOREIGN KEY (movid) REFERENCES public.movies(id);


--
-- Name: genres genre_mid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genre_mid_fkey FOREIGN KEY (mid) REFERENCES public.movies(id);


--
-- Name: locations location_did_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT location_did_fkey FOREIGN KEY (did) REFERENCES public.distributors(id);


--
-- Name: producers producer_produced_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producers
    ADD CONSTRAINT producer_produced_fkey FOREIGN KEY (produced) REFERENCES public.movies(id);


--
-- PostgreSQL database dump complete
--

