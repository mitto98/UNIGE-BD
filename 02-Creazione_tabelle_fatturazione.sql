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