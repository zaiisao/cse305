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
    age integer
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
    rating real,
    agerating character varying(50),
    description text,
    imgurl text,
    videourl text,
    CONSTRAINT movie_duration_check CHECK ((duration > 60)),
    CONSTRAINT movie_rating_check CHECK (((rating >= (1)::double precision) AND (rating <= (10)::double precision))),
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
362766	Tom Hardy	41	1270797
5351	Ryan Reynolds	42	5463162
\.


--
-- Data for Name: awards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.awards (pid, award) FROM stdin;
5351	Best Actor
5351	Best Actor in a Comedy
5351	Male Star of the Year
362766	Best Actor in an Action Movie
1783265	Best Animation
\.


--
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directors (id, name, age, produced) FROM stdin;
1783265	Tim Miller	48	1431045
500610	David Leitch	\N	5463162
\.


--
-- Data for Name: distributedby; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distributedby (subtitles, language, medium, movid, disid) FROM stdin;
English, Malay, Hebrew	English, Hindi	Theatre	1431045	622136
English, Malay, Bangla, Arabic	English, Hindi	Theatre	5463162	622136
\.


--
-- Data for Name: distributors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distributors (id, name, headquarters) FROM stdin;
622136	20th Century Fox	Los Angeles, CA
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (mid, genre) FROM stdin;
1431045	Action
1431045	Adventure
1431045	Comedy
5463162	Action
5463162	Adventure
5463162	Comedy
1270797	Action
1270797	Sci Fi
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (did, location) FROM stdin;
622136	Argentina
622136	Beligum
622136	Chile
622136	France
622136	UK
622136	Indonesia
622136	Japan
622136	Netherlands
622136	Norway
622136	Singapore
622136	USA
622136	Germany
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (id, name, duration, releasedate, rating, agerating, description, imgurl, videourl) FROM stdin;
1431045	Deadpool	109	2016-02-16	8	R	A fast-talking mercenary with a morbid sense of humor is subjected to a rogue experiment that leaves him with accelerated healing powers and a quest for revenge.	https://upload.wikimedia.org/wikipedia/en/2/23/Deadpool_%282016_poster%29.png	https://www.youtube.com/embed/ONHBaC-pfsk
1270797	Venom	112	2018-10-05	7	PG-13	When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego "Venom" to save his life.	https://upload.wikimedia.org/wikipedia/en/2/22/Venom_%282018_flim_poster%29.png	https://www.youtube.com/embed/xLCn88bfW1o
5463162	Deadpool 2	119	2018-05-18	7.80000019	R	Foul-mouthed mutant mercenary Wade Wilson (AKA. Deadpool), brings together a team of fellow mutant rogues to protect a young boy with supernatural abilities from the brutal, time-traveling cyborg, Cable.	https://upload.wikimedia.org/wikipedia/en/c/cf/Deadpool_2_poster.jpg	https://www.youtube.com/embed/D86RtevtfrA
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
6830	John J. Kelly	51	1431045
1334526	Simon Kinberg	45	1431045
1334526	Simon Kinberg	45	5463162
498278	Stan Lee	95	1431045
498278	Stan Lee	95	5463162
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

