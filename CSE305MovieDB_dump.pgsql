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
757087	Maaya Sakamoto	38	2983564
1856	Oprah Winfrey	1620680	\N
168	Samuel L. Jackson	69	3460252
2933542	Boyd Holbrook	37	3829266
1638365	John Lloyd Young	43	1742044
1638365		43	1742044
2706992	Erich Bergen	32	1742044
3145634	Tao Tsuchiya	\N	5261644
6729494	Ryoma Takeuchi	25	5261644
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
136	Best Performance in a Motion Picture
168	Best Actor in a Supporting Role
\.


--
-- Data for Name: directors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directors (id, name, age, produced) FROM stdin;
1783265	Tim Miller	48	1431045
500610	David Leitch	\N	5463162
2951802	Tomonori Sudo	40	2983564
7905466	Peter Jackson	57	7905466
893659	Gore Verbinski	54	1210819
233	Quentin Tarantino	55	3460252
948	Shane Black	56	3829266
1148550	Ava DuVernay	46	1620680
142	Clint Eastwood	88	1742044
3410783	Takahiro Miki	\N	5261644
\.


--
-- Data for Name: distributedby; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distributedby (subtitles, language, medium, movid, disid) FROM stdin;
English, Malay, Hebrew	English, Hindi	Theatre	1431045	622136
English, Malay, Bangla, Arabic	English, Hindi	Theatre	5463162	622136
English	Japanese	Theatre	2983564	132285
English	English	Theatre, All Media	7905466	26840
English, Arabic	English	Theatre, Blu-Ray, DVD	1210819	226183
English	English	Theatre, DVD	1620680	226183
English	English, Spanish, French	Blu-Ray, DVD	3460252	622136
English	English, Spanish	Theatre	3829266	622136
English, Italian, French	English, Italian, French	Threatre	1742044	26840
Japanese	Japanese	Theatre	5261644	2219
\.


--
-- Data for Name: distributors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distributors (id, name, headquarters) FROM stdin;
622136	20th Century Fox	Los Angeles, CA
132285	Aniplex	Japan
26840	Warner Bros.	Burbank, CA
226183	Walt Disney Studious Motion Pictures	Burbank, CA
2219	Toho Company	Japan
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
2983564	Animation
2983564	Drama
2983564	Fantasy
1210819	Action
1210819	Adventure
1210819	Western
1210819	Superhero
1620680	Adventure
1620680	Family
1620680	Fantasy
3460252	Crime
3460252	Drama
3460252	Mystery
1742044	Biography
1742044	Drama
1742044	Music
1742044	Musical
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
132285	Japan
132285	USA
26840	USA
26840	Singapore
26840	Ireland
226183	USA
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (id, name, duration, releasedate, rating, agerating, description, imgurl, videourl) FROM stdin;
1431045	Deadpool	109	2016-02-16	8	R	A fast-talking mercenary with a morbid sense of humor is subjected to a rogue experiment that leaves him with accelerated healing powers and a quest for revenge.	https://upload.wikimedia.org/wikipedia/en/2/23/Deadpool_%282016_poster%29.png	https://www.youtube.com/embed/ONHBaC-pfsk
1270797	Venom	112	2018-10-05	7	PG-13	When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego "Venom" to save his life.	https://upload.wikimedia.org/wikipedia/en/2/22/Venom_%282018_flim_poster%29.png	https://www.youtube.com/embed/xLCn88bfW1o
5463162	Deadpool 2	119	2018-05-18	7.80000019	R	Foul-mouthed mutant mercenary Wade Wilson (AKA. Deadpool), brings together a team of fellow mutant rogues to protect a young boy with supernatural abilities from the brutal, time-traveling cyborg, Cable.	https://upload.wikimedia.org/wikipedia/en/c/cf/Deadpool_2_poster.jpg	https://www.youtube.com/embed/D86RtevtfrA
7905466	They Shall Not Grow Old	99	2018-11-09	8.69999981	R	A documentary about World War I with never-before-seen footage to commemorate the centennial of the end of the war. 	https://m.media-amazon.com/images/M/MV5BNmJhMDI5NGItYTA2YS00YzNjLWE5MjktMTkyNDNiZGI2NzAzXkEyXkFqcGdeQXVyNjI2OTgxNzY@._V1_.jpg	https://www.youtube.com/embed/IrabKK9Bhds
1620680	A Wrinkle In Time	109	2018-03-09	4.19999981	PG	After the disappearance of her scientist father, three peculiar beings send Meg, her brother, and her friend to space in order to find him.	https://m.media-amazon.com/images/M/MV5BMjMxNjQ5MTI3MV5BMl5BanBnXkFtZTgwMjQ2MTAyNDM@._V1_UX182_CR0,0,182,268_AL_.jpg	https://www.youtube.com/embed/UhZ56rcWwRQ
3460252	The Hateful Eight	187	2015-12-30	7.80000019	R	In the dead of a Wyoming winter, a bounty hunter and his prisoner find shelter in a cabin currently inhabited by a collection of nefarious characters.	https://m.media-amazon.com/images/M/MV5BMjA1MTc1NTg5NV5BMl5BanBnXkFtZTgwOTM2MDEzNzE@._V1_UX182_CR0,0,182,268_AL_.jpg	https://www.youtube.com/embed/nIOmotayDMY
3829266	The Predator	107	2018-09-14	5.5999999	R	When a young boy accidentally triggers the universes most lethal hunters return to Earth, only a ragtag crew of ex-soldiers and a disgruntled scientist can prevent the end of the human race.	https://m.media-amazon.com/images/M/MV5BMjM5MDk2NDIxMF5BMl5BanBnXkFtZTgwNjU5NDk3NTM@._V1_UX182_CR0,0,182,268_AL_.jpg	https://www.youtube.com/embed/AAJ2LVVgqVo
1210819	The Lone Ranger	210	2013-07-03	6.4000001	PG-13	Native American warrior Tonto recounts the untold tales that transformed John Reid, a man of the law, into a legend of justice.	https://m.media-amazon.com/images/M/MV5BZjFiMTc2MTAtZDA0My00OGRmLTk5M2ItNTlmYTUwZmU2YmRiXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_UX182_CR0,0,182,268_AL_.jpg	https://www.youtube.com/embed/JjFsNSoDZK8
2983564	The Garden of Sinners: Future Gospel	90	2013-10-28	7.19999981	G	Mirai Fukuin is an adaptation of a side story from the Kara no Kyoukai novel series. It is divided into two parts. Möbius ring Shizune Seo and Mitsuru Kamekura are psychics who can see the future. Shizune was sick of her predictable boring life and Meruka became a professional bomber taking advantage of his supernatural power. When Shizune met Mikiya and when Meruka met Shiki, their immutable future started to change. Möbius link Takes place ten years after the events of Kara no Kyoukai.'Mirai Fukuin is an adaptation of a side story from the Kara no Kyoukai novel series. It is divided into two parts. Möbius ring Shizune Seo and Mitsuru Kamekura are psychics who can see the future. Shizune was sick of her predictable boring life and Meruka became a professional bomber taking advantage of his supernatural power. When Shizune met Mikiya and when Meruka met Shiki, their immutable future started to change. Möbius link Takes place ten years after the events of Kara no Kyoukai.	https://m.media-amazon.com/images/M/MV5BZjQ1OTRlZTAtMTc5OS00NzZkLThjNTctOTA1MWFlMTVhZjQzXkEyXkFqcGdeQXVyNjgwNTk4Mg@@._V1_UY268_CR7,0,182,268_AL_.jpg	https://www.youtube.com/embed/cMZhEaO0nJk
1742044	Jersey Boys\n	134	2014-06-14	6.80000019	R	The story of four young men from the wrong side of the tracks in New Jersey who came together to form the iconic 1960s rock group The Four Seasons.	https://m.media-amazon.com/images/M/MV5BMjIyMjA2OTM0NF5BMl5BanBnXkFtZTgwMzY2MTI2MTE@._V1_UX182_CR0,0,182,268_AL_.jpg	https://www.youtube.com/embed/tL2iILHUsG0
5261644	Yell for the Blue Sky	126	2016-08-20	6.0999999	G	Aozora Yell centers on Tsubasa, a girl who saw an inspirational brass band performance at the finals of the Japanese high school baseball championships one summer. Tsubasa vows to join the band when she enters high school, and she happens to meet a certain boy who has a similar goal which both of them are striving for. 	https://m.media-amazon.com/images/M/MV5BN2E5MTVmOWUtOTQ2OS00YmNkLTkwMGEtMWMxODczNThlZmU3XkEyXkFqcGdeQXVyNDI2OTY2MzE@._V1_UY268_CR3,0,182,268_AL_.jpg	https://www.youtube.com/embed/3GqnDrhVsHA
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
2195555	Kinoko Nasu	45	2983564
254645	Ted Elliot	57	1210819
136	Johnny Depp	55	1210819
233	Quentin Tarantino	55	3460252
948	Shane Black	56	3829266
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

