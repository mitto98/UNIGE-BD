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

-- A mio avviso non è necessario creare una tabella per immagazzinare gli indirizzi,
--  vengono comunque memorizzati nelle tabelle che la riferiscono, e non c'è necessità
--  di avere un unica sorgente di verità per gli indirizzi presenti nel sistema.
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
    CHECK (tipo_sede LIKE 'LEGALE' OR tipo_sede LIKE 'OPERATIVA'),
    FOREIGN KEY (nazione, citta, cap, via, civico) REFERENCES indirizzo (nazione, citta, cap, via, civico)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE documento
(
    n_documento       varchar(10) PRIMARY KEY,
    rilascio          date          NOT NULL,
    scadenza          date          NOT NULL,
    CHECK (scadenza < NOW()),
    professione       varchar(30)   NOT NULL,
    nome              varchar(10)   NOT NULL,
    cognome           varchar(15)   NOT NULL,
    is_patente        bool          NOT NULL,
    luogo_nascita     varchar(20)   NOT NULL,
    data_nascita      date          NOT NULL,
    CHECK (data_nascita < (NOW() - interval '18 year')),
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
--    CHECK (cf ~ $$^[A-Z]{6}\d{2}[A-Z]\d{2}[A-Z]\d{3}[A-Z]$/i$$),
    id_conducente int references conducente
        ON DELETE CASCADE,
    telefono      varchar(11) NOT NULL,
    eta           numeric,
    CHECK (18 < eta),
    n_documento   varchar(10) NOT NULL references documento,
    n_patente     varchar(10) NOT NULL references documento
);

CREATE TABLE categoria
(
    categoria varchar(20) PRIMARY KEY
);

CREATE TABLE modello
(
    nome_modello             varchar(20) PRIMARY KEY,
    lunghezza                numeric(6, 2) NOT NULL,
    CHECK (lunghezza BETWEEN 0 AND 500),
    larghezza                numeric(6, 2) NOT NULL,
    CHECK (larghezza BETWEEN 0 AND 250),
    altezza                  numeric(6, 2) NOT NULL,
    CHECK (altezza BETWEEN 0 AND 250),
    n_porte                  smallint      NOT NULL,
    CHECK ( n_porte BETWEEN 2 AND 5),
    consumo                  numeric(4, 2),
    velocita                 smallint      NOT NULL,
    CHECK (velocita BETWEEN 30 AND 350),
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

CREATE TABLE parcheggio
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
    CHECK (targa ~ '^[A-Z]{2}[0-9]{3}[A-Z]{2}$'),
    chilometraggio numeric           NOT NULL,
    seggiolini     numeric,
    colore         varchar(20)       NOT NULL,
    animali        bool              NOT NULL,
    modello        varchar(20) REFERENCES modello,
    sede           varchar(20) REFERENCES parcheggio
);

CREATE TABLE rifornimenti
(
    targa          varchar(7) references Vettura (targa),
    chilometraggio numeric,
    data           date    NOT NULL,
    litri          numeric NOT NULL,
    PRIMARY KEY (chilometraggio, targa)
);

CREATE TABLE carta
(
    numero       numeric(16, 0) NOT NULL,
    circuito     varchar(16)    NOT NULL,
    intestatario varchar(30)    NOT NULL,
    scadenza     date           NOT NULL,
    CHECK (scadenza > NOW()),
    PRIMARY KEY (numero, circuito, intestatario, scadenza)
);

CREATE TABLE rid
(
    iban         char(27)    NOT NULL,
    intestatario varchar(30) NOT NULL,
    PRIMARY KEY (iban, intestatario)
);

CREATE TABLE metodo_pagamento
(
    smart_card         serial PRIMARY KEY,
    versato            numeric,
    numero_carta       numeric(16, 0),
    intestatario_carta varchar(30),
    circuito_carta     varchar(10),
    scadenza_carta     date,
    iban               char(27),
    intestatario_conto varchar(30),
    FOREIGN KEY (iban, intestatario_conto)
        REFERENCES rid (iban, intestatario)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (numero_carta, circuito_carta, intestatario_carta, scadenza_carta)
        REFERENCES carta (numero, circuito, intestatario, scadenza)
        ON UPDATE CASCADE
        ON DELETE CASCADE

);

CREATE TABLE tipo
(
    periodo       varchar(20) PRIMARY KEY,
    n_giorni      int,
    costo         numeric NOT NULL,
    riduzione_eta numeric
);

CREATE TABLE abbonamento
(
    data_inizio        timestamp     NOT NULL,
    data_fine          timestamp     NOT NULL,
    data_bonus         date,
    bonus_rottamazione numeric(3, 0),
    pin_carta          numeric(4, 0) NOT NULL,
    smart_card         integer       NOT NULL references metodo_pagamento,
    tipo               varchar(20)   NOT NULL references tipo,
    PRIMARY KEY (smart_card),
    UNIQUE (smart_card, data_inizio),
    CHECK (data_inizio < data_fine)
);

CREATE TABLE utente
(
    email      varchar(30) PRIMARY KEY,
--    CHECK (email ~ $$[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$$),
    piva       integer REFERENCES azienda
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    cf         char(16) REFERENCES persona
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    smart_card int REFERENCES metodo_pagamento
);

CREATE TABLE fatturazione
(
    numero_fattura      serial PRIMARY KEY,
    penale              numeric,
    totale_fatt         numeric,
    chilometri_percorsi numeric,
    tempo_non_usufruito numeric,
    tempo_usufruito     numeric,
    tempo_annullato     numeric,
    CHECK (tempo_usufruito + tempo_non_usufruito > 0)
);

CREATE TABLE prenotazione
(
    numero_prenotazione serial PRIMARY KEY,
    smart_card          int       NOT NULL,
    nome_vettura        varchar(10) REFERENCES vettura,
    data_ora_inizio     timestamp NOT NULL,
    data_ora_fine       timestamp NOT NULL,
    numero_fattura      int
        REFERENCES fatturazione
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    FOREIGN KEY (smart_card)
        REFERENCES abbonamento (smart_card),
    CHECK (data_ora_inizio <= data_ora_fine)
);

CREATE TABLE modifica_prenotazione
(
    numero_prenotazione   int REFERENCES prenotazione,
    data_ora_rinuncia     timestamp,
    nuova_data_ora_inizio timestamp,
    nuova_data_ora_fine   timestamp,
    PRIMARY KEY (numero_prenotazione),
    CHECK (nuova_data_ora_inizio < nuova_data_ora_fine)
);

CREATE TABLE utilizzo
(
    numero_prenotazione       int           NOT NULL
        REFERENCES Prenotazione
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    chilometraggio_ritiro     numeric(6, 0) NOT NULL,
    data_ora_ritiro           timestamp     NOT NULL,
    data_ora_riconsegna       timestamp,
    chilometraggio_riconsegna numeric(6, 0),
    PRIMARY KEY (numero_prenotazione, data_ora_ritiro),
    CHECK (data_ora_ritiro < data_ora_riconsegna),
    CHECK (chilometraggio_ritiro < chilometraggio_riconsegna)
);

CREATE TABLE sinistro
(
    numero_prenotazione int REFERENCES prenotazione (numero_prenotazione),
    data_ora            timestamp,
    danni               varchar      NOT NULL,
    dinamica            varchar      NOT NULL,
    conducente          varchar(40)  NOT NULL,
    luogo               varchar(100) NOT NULL,
    PRIMARY KEY (numero_prenotazione, data_ora)
);

CREATE TABLE testimoni
(
    contatto      varchar(30) PRIMARY KEY,
    nome          varchar(10) NOT NULL,
    cognome       varchar(15) NOT NULL,
    data_nascita  date        NOT NULL,
    luogo_nascita varchar(20) NOT NULL
);

CREATE TABLE sinistro_testimoni
(
    numero_prenotazione int         NOT NULL,
    data_ora            timestamp   NOT NULL,
    contatto            varchar(20) NOT NULL REFERENCES testimoni,
    FOREIGN KEY (numero_prenotazione, data_ora) REFERENCES sinistro (numero_prenotazione, data_ora)
);

CREATE TABLE terzi (
	targa char(7) PRIMARY KEY,
	conducente varchar(25) NOT NULL
);

CREATE TABLE sinistro_terzi (
	numero_prenotazione serial NOT NULL,
	data_ora timestamp NOT NULL,
	targa char(7) NOT NULL REFERENCES terzi,
	FOREIGN KEY(numero_prenotazione, data_ora) REFERENCES Sinistro(numero_prenotazione, data_ora)
);
