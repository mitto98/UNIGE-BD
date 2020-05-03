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
       ('Semestrale',150,25, 15),
       ('Mensile', 30, 5, 1);

-- Modelli veicoli
INSERT INTO modello
VALUES ('Fiat 500', 10, 10, 10, 5, 0, 50, 0, 0, 1, 10, 50, 0.50, 5, 'City Car', true, true, true),
       ('Fiat seicento', 10, 10, 10, 3, 0, 50, 0, 0, 1, 10, 50, 0.50, 5, 'City Car', false, true, true),
       ('Fiat Tipo', 10, 10, 10, 5, 0, 50, 0, 0, 1, 10, 50, 0.50, 5, 'Comfort', true, true, true),
       ('Tesla model 3', 10, 10, 10, 5, 0, 50, 0, 0, 1, 10, 50, 0.50, 5, 'Electric', true, true, true),
       ('Cybertruck', 10, 10, 10, 4, 0, 50, 0, 0, 1, 10, 50, 0.50, 5, 'Cargo', false, false, false);

-- Inserimento indirizzi dei parcheggi
INSERT INTO indirizzo
VALUES ('Italia', 'Genova', 16121, 12, 'Piazza Dante'),
       ('Italia', 'Genova', 16137, 8, 'Via piacenza'),
       ('Italia', 'Genova', 16149, 15, 'Via fiumara');

INSERT INTO parcheggio
VALUES ('Piazza Dante', 5, 'san Vincenzo', 44.4044215, 8.9278249, 'Italia', 'Genova', 16121, 12, 'Piazza Dante'),
       ('Staglieno', 9, 'Staglieno', 44.4281326, 8.9510245, 'Italia', 'Genova', 16137, 8, 'Via piacenza'),
       ('Fiumara', 6, 'Sampierdarena', 44.4108538, 8.8809957, 'Italia', 'Genova', 16149, 15, 'Via fiumara');

INSERT INTO categoria_parcheggio (categoria, nome_parcheggio)
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
VALUES ('Ginevra', 'AA000AA', 12000, 1, 'Bianca', true, 'Tesla model 3', 'Staglieno'),
       ('Giada', 'AA000AB', 12000, 0, 'Verde', true, 'Fiat seicento', 'Staglieno'),
       ('Caterina', 'AA000AC', 9000, 0, 'Nera', true, 'Tesla model 3', 'Staglieno'),
       ('Valeria', 'AA000AD', 20090, 0, 'Rossa', true, 'Tesla model 3', 'Staglieno'),
       ('Andrea', 'AA000AE', 12000, 0, 'Blu', true, 'Fiat Tipo', 'Staglieno'),
       ('Giovanna', 'AA000AF', 12000, 0, 'Grigia', true, 'Fiat Tipo', 'Staglieno'),
       ('Alice', 'AA000AG', 12000, 2, 'Rossa', true, 'Fiat 500', 'Staglieno'),
       ('Sara', 'AA000AH', 12000, 0, 'Argento', true, 'Cybertruck', 'Staglieno'),
       ('Lucia', 'AA000AI', 12000, 0, 'Argento', true, 'Cybertruck', 'Staglieno'),
       ('Olivia', 'AA000AJ', 1000, 2, 'Rossa', true, 'Fiat 500', 'Piazza Dante'),
       ('Claudia', 'AA000AK', 12000, 1, 'Azzurra', true, 'Fiat 500', 'Piazza Dante'),
       ('Ivana', 'AA000AL', 21000, 0, 'Gialla', true, 'Fiat seicento', 'Piazza Dante'),
       ('Alessia', 'AA000AM', 12000, 1, 'Bianca', true, 'Tesla model 3', 'Piazza Dante'),
       ('Lara', 'AA000AN', 12000, 0, 'Grigia', true, 'Tesla model 3', 'Piazza Dante'),
       ('Camilla', 'AA000AO', 9000, 1, 'Blu', true, 'Fiat Tipo', 'Fiumara'),
       ('Valentina', 'AA000AP', 12000, 0, 'Nera', true, 'Fiat Tipo', 'Fiumara'),
       ('Beatrice', 'AA000AQ', 12000, 1, 'Argento', true, 'Cybertruck', 'Fiumara'),
       ('Adele', 'AA000AR', 12000, 0, 'Argento', true, 'Cybertruck', 'Fiumara'),
       ('Anna', 'AA000AS', 12000, 0, 'Rossa', true, 'Tesla model 3', 'Fiumara'),
       ('Francesca', 'AA000AT', 12000, 2, 'Bianca', true, 'Tesla model 3', 'Fiumara');
