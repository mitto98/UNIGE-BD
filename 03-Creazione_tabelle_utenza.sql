CREATE TABLE utente
(
    email      varchar(30) PRIMARY KEY,
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
        REFERENCES abbonamento (smart_card)
);

CREATE TABLE modifica_prenotazione
(
    numero_prenotazione    int REFERENCES prenotazione,
    data_ora_rinuncia      timestamp,
    nuovaD_data_ora_inizio timestamp,
    nuova_data_ora_rest    timestamp,
    PRIMARY KEY (numero_prenotazione)
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
    PRIMARY KEY (numero_prenotazione, data_ora_ritiro)
);