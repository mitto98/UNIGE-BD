CREATE TABLE referente
(
    telefono varchar(10) PRIMARY KEY,
    nome     varchar(10) NOT NULL,
    cognome  varchar(15) NOT NULL
);

CREATE TABLE rappresentante
(
    nome          varchar(10),
    cognome       varchar(15),
    data_nascita  date,
    luogo_nascita varchar(20) NOT NULL,
    PRIMARY KEY (nome, cognome, data_nascita)
);

CREATE TABLE azienda
(
    piva                        numeric(11) PRIMARY KEY,
    rag_sociale                 varchar(30)                      NOT NULL,
    telefono                    varchar(10)                      NOT NULL,
    telefono_referente          varchar(10) REFERENCES referente NOT NULL,
    nome_rappresentante         varchar(10)                      NOT NULL,
    cognome_rappresentante      varchar(15)                      NOT NULL,
    data_nascita_rappresentante date                             NOT NULL
);

CREATE TABLE indirizzo
(
    nazione varchar(20)   NOT NULL,
    citta   varchar(20)   NOT NULL,
    cap     numeric(5, 0) NOT NULL,
    civico  numeric(4, 0) NOT NULL,
    via     varchar(20)   NOT NULL,
    PRIMARY KEY (nazione, citta, cap, civico, via)
);

CREATE TABLE sede
(
    idsede    serial PRIMARY KEY,
    piva      numeric(11) REFERENCES azienda,
    nazione   varchar(20)   NOT NULL,
    citta     varchar(20)   NOT NULL,
    cap       numeric(5, 0) NOT NULL,
    civico    numeric(4, 0) NOT NULL,
    via       varchar(20)   NOT NULL,
    tipo_sede varchar(9)    NOT NULL,
    FOREIGN KEY (nazione, citta, cap, via, civico)
        REFERENCES indirizzo (nazione, citta, cap, via, civico)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE documento
(
    n_documento       varchar(10) PRIMARY KEY,
    rilascio          date          NOT NULL,
    scadenza          date          NOT NULL,
    professione       varchar(30)   NOT NULL,
    nome              varchar(10)   NOT NULL,
    cognome           varchar(15)   NOT NULL,
    is_patente        bool          NOT NULL,
    luogo_nascita     varchar(20)   NOT NULL,
    data_nascita      date          NOT NULL,
    categoria_patente char(1),
    nazione           varchar(20)   NOT NULL,
    citta             varchar(20)   NOT NULL,
    cap               numeric(5, 0) NOT NULL,
    civico            numeric(4, 0) NOT NULL,
    via               varchar(20)   NOT NULL,
    FOREIGN KEY (nazione, citta, cap, civico, via)
        REFERENCES indirizzo (nazione, citta, cap, civico, via)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE conducente
(
    id_conducente serial PRIMARY KEY,
    piva          numeric(11) REFERENCES azienda,
    n_documento   varchar(10) REFERENCES documento
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    n_patente     varchar(10) NOT NULL REFERENCES documento
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (id_conducente, piva, n_documento, n_patente)
);

CREATE TABLE persona
(
    cf            char(16)    NOT NULL PRIMARY KEY,
    id_conducente int references conducente
        ON DELETE CASCADE,
    telefono      varchar(11) NOT NULL,
    eta           numeric,
    n_documento   varchar(10) NOT NULL references documento,
    n_patente     varchar(10) NOT NULL references documento

);
