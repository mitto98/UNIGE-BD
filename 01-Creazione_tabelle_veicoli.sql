CREATE TABLE Categoria
(
    categoria varchar(20) PRIMARY KEY
);

CREATE TABLE Modello
(
    nome_modello             varchar(20) PRIMARY KEY,
    lunghezza                numeric(6, 2) NOT NULL,
    larghezza                numeric(6, 2) NOT NULL,
    altezza                  numeric(6, 2) NOT NULL,
    n_porte                  smallint      NOT NULL,
    consumo                  numeric(4, 2),
    velocita                 smallint      NOT NULL,
    motorizzazione           smallint,
    cap_bagagliaio           numeric(6, 2) NOT NULL,
    t_oraria                 numeric(5, 2) NOT NULL,
    t_giornaliera            numeric(5, 2) NOT NULL,
    t_settimanale            numeric(5, 2) NOT NULL,
    t_chilometrica           numeric(5, 2) NOT NULL,
    t_giornaliera_aggiuntiva numeric(6, 2) NOT NULL,
    categoria                varchar(20)   NOT NULL
        REFERENCES Categoria
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    aria                     bool,
    servo_s                  bool,
    airbag                   bool
);

CREATE TABLE Parcheggio
(
    nome_parcheggio varchar(20) PRIMARY KEY,
    n_posti         numeric        NOT NULL,
    zona            varchar(20)    NOT NULL,
    longitudine     numeric(14, 7) NOT NULL,
    latitudine      numeric(14, 7) NOT NULL,
    nazione         varchar(20)    NOT NULL,
    citta           varchar(20)    NOT NULL,
    cap             numeric(5, 0)  NOT NULL,
    civico          numeric(4, 0)  NOT NULL,
    via             varchar(20)    NOT NULL,
    FOREIGN KEY (nazione, citta, cap, via, civico)
        REFERENCES indirizzo (nazione, citta, cap, via, civico)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE categoria_parcheggio
(
    id              serial primary key,
    nome_parcheggio varchar(20) references parcheggio,
    categoria       varchar(20) references categoria
);

CREATE TABLE vettura
(
    nome_vettura   varchar(10) PRIMARY KEY,
    targa          varchar(7) UNIQUE NOT NULL,
    chilometraggio numeric           NOT NULL,
    seggiolini     numeric,
    colore         varchar(20)       NOT NULL,
    animali        bool              NOT NULL,
    modello        varchar(20) REFERENCES modello,
    sede           varchar(20) REFERENCES parcheggio
);

CREATE TABLE Rifornimenti
(
    targa          varchar(7) references Vettura (targa),
    chilometraggio numeric,
    data           date    NOT NULL,
    litri          numeric NOT NULL,
    PRIMARY KEY (chilometraggio, targa)
);
