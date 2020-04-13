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
