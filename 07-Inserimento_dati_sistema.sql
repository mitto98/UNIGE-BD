-- Categorie di veicoli
INSERT INTO categoria
VALUES ('City Car'),
       ('Media'),
       ('Comfort'),
       ('Cargo'),
       ('Electric');

-- Tipi di abbonamento
INSERT INTO tipo
VALUES ('Annuale', 365, 300, 50),
       ('Mensile', 30, 5);

-- Modelli veicoli
INSERT INTO modello
VALUES ('Fiat 500', 0, 0, 0, 5, 0, 0, 0, 0, 1, 10, 50, 0.50, 5, 'City Car', true, true, true),
       ('Fiat seicento', 0, 0, 0, 3, 0, 0, 0, 0, 1, 10, 50, 0.50, 5, 'City Car', false, true, true),
       ('Fiat Tipo', 0, 0, 0, 5, 0, 0, 0, 0, 1, 10, 50, 0.50, 5, 'Comfort', true, true, true),
       ('Tesla model 3', 0, 0, 0, 5, 0, 0, 0, 0, 1, 10, 50, 0.50, 5, 'Electric', true, true, true),
       ('Cybertruck', 0, 0, 0, 4, 0, 0, 0, 0, 1, 10, 50, 0.50, 5, 'Cargo');

-- Inserimento indirizzi dei parcheggi
INSERT INTO indirizzo
VALUES ('Italia', 'Genova', 16121, 12, 'Piazza Dante'),
       ('Italia', 'Genova', 16137, 8, 'Via piacenza'),
       ('Italia', 'Genova', 16149, 15, 'Via fiumara');

INSERT INTO parcheggio
VALUES ('Piazza Dante', 5, 'san Vincenzo', 44.4044215, 8.9278249, 'Italia', 'Genova', 16121, 12, 'Piazza Dante'),
       ('Staglieno', 9, 'Staglieno', 44.4281326, 8.9510245, 'Italia', 'Genova', 16137, 8, 'Via piacenza'),
       ('Fiumara', 6, 'Sampierdarena', 44.4108538, 8.8809957, 'Italia', 'Genova', 16149, 15, 'Via fiumara');

INSERT INTO categoria_parcheggio
VALUES ('City Car', 'Piazza Dante'),
       ('City Car', 'Staglieno'),
       ('City Car', 'Fiumara'),
       ('Media', 'Piazza Dante'),
       ('Media', 'Fiumara'),
       ('Comfort', 'Staglieno'),
       ('Cargo', 'Fiumara'),
       ('Cargo', 'Staglieno'),
       ('Electric', 'Piazza Dante'),
       ('Electric', 'Staglieno'),
       ('Electric', 'Fiumara');

INSERT INTO vettura
VALUES ('Ginevra', 'AA000AA', 12000, 1, 'Bianca', 'Tesla model 3', 'Staglieno'),
       ('Giada', 'AA000AB', 12000, 0, 'Verde', 'Fiat seicento', 'Staglieno'),
       ('Caterina', 'AA000AC', 12000, 0, 'Nera', 'Tesla model 3', 'Staglieno'),
       ('Valeria', 'AA000AD', 12000, 0, 'Rossa', 'Tesla model 3', 'Staglieno'),
       ('Andrea', 'AA000AE', 12000, 0, 'Blu', 'Fiat Tipo', 'Staglieno'),
       ('Giovanna', 'AA000AF', 12000, 0, 'Grigia', 'Fiat Tipo', 'Staglieno'),
       ('Alice', 'AA000AG', 12000, 2, 'Rossa', 'Fiat 500', 'Staglieno'),
       ('Sara', 'AA000AH', 12000, 0, 'Argento', 'Cybertruck', 'Staglieno'),
       ('Lucia', 'AA000AI', 12000, 0, 'Argento', 'Cybertruck', 'Staglieno'),
       ('Olivia', 'AA000AJ', 12000, 2, 'Rossa', 'Fiat 500', 'Piazza Dante'),
       ('Claudia', 'AA000AK', 12000, 1, 'Azzurra', 'Fiat 500', 'Piazza Dante'),
       ('Ivana', 'AA000AL', 12000, 0, 'Gialla', 'Fiat seicento', 'Piazza Dante'),
       ('Alessia', 'AA000AM', 12000, 1, 'Bianca', 'Tesla model 3', 'Piazza Dante'),
       ('Lara', 'AA000AN', 12000, 0, 'Grigia', 'Tesla model 3', 'Piazza Dante'),
       ('Camilla', 'AA000AO', 12000, 1, 'Blu', 'Fiat Tipo', 'Fiumara'),
       ('Valentina', 'AA000AP', 12000, 0, 'Nera', 'Fiat Tipo', 'Fiumara'),
       ('Beatrice', 'AA000AQ', 12000, 1, 'Argento', 'Cybertruck', 'Fiumara'),
       ('Adele', 'AA000AR', 12000, 0, 'Argento', 'Cybertruck', 'Fiumara'),
       ('Anna', 'AA000AS', 12000, 0, 'Rossa', 'Tesla model 3', 'Fiumara'),
       ('Francesca', 'AA000AT', 12000, 2, 'Bianca', 'Tesla model 3', 'Fiumara');
