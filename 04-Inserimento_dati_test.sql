-- Inserimento documenti
SELECT inserisci_documento('AAAAAAA', '2000-01-01'::date, '2010-01-01'::date, 'Inventore', 'Tony', 'Stark', false,
                           'Malibu', '2000-01-01'::date, 'B', 'USA', 'Malibu', 12345, 1234, 'xxxxxx');
SELECT inserisci_documento('PAAAAAA', '2000-01-01'::date, '2010-01-01'::date, 'Inventore', 'Tony', 'Stark', false,
                           'Malibu', '2000-01-01'::date, 'B', 'USA', 'Malibu', 12345, 1234, 'xxxxxx');
SELECT inserisci_documento('BBBBBBB', '2000-01-01'::date, '2010-01-01'::date, 'Segretaria', 'Pepper', 'Potts', false,
                           'Malibu', '2000-01-01'::date, 'B', 'USA', 'Malibu', 12345, 1234, 'xxxxxx');
SELECT inserisci_documento('PBBBBBB', '2000-01-01'::date, '2010-01-01'::date, 'Segretaria', 'Pepper', 'Potts', false,
                           'Malibu', '2000-01-01'::date, 'B', 'USA', 'Malibu', 12345, 1234, 'xxxxxx');
SELECT inserisci_documento('CCCCCCC', '2000-01-01'::date, '2010-01-01'::date, 'Militare', 'James', 'Rhodes', false,
                           'Malibu', '2000-01-01'::date, 'B', 'USA', 'Idaho', 12345, 1234, 'iiiiiiii');
SELECT inserisci_documento('PCCCCCC', '2000-01-01'::date, '2010-01-01'::date, 'Militare', 'James', 'Rhodes', false,
                           'Malibu', '2000-01-01'::date, 'B', 'USA', 'Idaho', 12345, 1234, 'iiiiiiii');
SELECT inserisci_documento('DDDDDDD', '2000-01-01'::date, '2010-01-01'::date, 'Imprendirore', 'Obadiah', 'Stane', false,
                           'Malibu', '2000-01-01'::date, 'B', 'USA', 'Michigan', 12345, 1234, 'mmmmmm');
SELECT inserisci_documento('PDDDDDD', '2000-01-01'::date, '2010-01-01'::date, 'Imprenditore', 'Obadiah', 'Stane', false,
                           'Malibu', '2000-01-01'::date, 'B', 'USA', 'Michigan', 12345, 1234, 'mmmmmm');
SELECT inserisci_documento('EEEEEEE', '2000-01-01'::date, '2010-01-01'::date, 'Interprete', 'Ho', 'Yinsen', false,
                           'Afghanistan', '2000-01-01'::date, 'B', 'Afghanistan', 'yyyy', 12345, 1234, 'yyyy');
SELECT inserisci_documento('PEEEEEE', '2000-01-01'::date, '2010-01-01'::date, 'Interprete', 'Ho', 'Yinsen', false,
                           'Afghanistan', '2000-01-01'::date, 'B', 'Afghanistan', 'yyyy', 12345, 1234, 'yyyy');

-- Inserimento persone fisiche
SELECT registra_persona('AAAAAA00A00A000A', '0000000000', 'AAAAAAA', 'PAAAAAA');
SELECT registra_persona('BBBBBB00B00B000B', '0000000000', 'BBBBBBB', 'PBBBBBB');
SELECT registra_persona('CCCCCC00C00C000C', '0000000000', 'CCCCCCC', 'PCCCCCC');
SELECT registra_persona('DDDDDD00D00D000D', '0000000000', 'DDDDDDD', 'PDDDDDD');
SELECT registra_persona('EEEEEE00E00E000E', '0000000000', 'EEEEEEE', 'PEEEEEE');

SELECT aggiungi_conducente_secondario('AAAAAA00A00A000A', 'BBBBBBB');

-- Inserimento azienda
INSERT INTO rappresentante
VALUES ('Star', 'Butterfly', '2000-01-01', 'Mewni'),
       ('Rick', 'Sanchez', '1968-01-01', 'Terra C-132'),
       ('Mabel', 'Pines', '1982-01-01', 'California');

INSERT INTO referente
VALUES ('0000000000', 'Camilla', 'Diaz'),
       ('0000000001', 'Morty', 'Smith'),
       ('0000000002', 'Dipper', 'Pines');

INSERT INTO azienda
VALUES (00000000, 'Star vs the force of evil', '0000000000', '0000000000', 'Star', 'Butterfly', '2000-01-01'),
       (11111111, 'Rick and morty', '1111111111', '0000000001', 'Rick', 'Sanchez', '1968-01-01'),
       (22222222, 'Gravity falls', '2222222222', '0000000002', 'Mabel', 'Pines', '1982-01-01');

-- INSERIMENTO METODI PAGAMENTO,
SELECT aggiungi_metodo_pagamento(1, 'MW0000000000000000000000000', 'Moon Butterfly');
SELECT aggiungi_metodo_pagamento(2, 950);
SELECT aggiungi_metodo_pagamento(3, 1234123412341234, 'Stan Pines', 'Mastercard', '2024-06-12'::date);
SELECT aggiungi_metodo_pagamento(4, 'US0000000000000000000000000', 'Award Stark');
SELECT aggiungi_metodo_pagamento(5, 1234123412341235, 'Stan Pines', 'VISA', '2026-11-13'::date);
SELECT aggiungi_metodo_pagamento(6, 50);
SELECT aggiungi_metodo_pagamento(7, 2000);
SELECT aggiungi_metodo_pagamento(8, 230);

-- Utenti
INSERT INTO utente
VALUES ('star@mewni.gov', 00000000, NULL, 1),
       ('rick@ricktastic.com', 11111111, NULL, 2),
       ('buy@misteryshack.org', 22222222, NULL, 3),
       ('Tony@starkindustries.com', NULL, 'AAAAAA00A00A000A', 4),
       ('ceo@starkindustries.com', NULL, 'BBBBBB00B00B000B', 5),
       ('Rhodes@army.gov', NULL, 'CCCCCC00C00C000C', 6),
       ('Stane@starkindustries.com', NULL, 'DDDDDD00D00D000D', 7),
       ('hoyinsen@gmail.com', NULL, 'EEEEEE00E00E000E', 8);

-- Inserimento conducenti aziende
SELECT inserisci_documento('FFFFFFF', '2000-01-01'::date, '2010-01-01'::date, 'Principessa', 'Star', 'Butterfly', false,
                           'Mewni', '2000-01-01'::date, 'B', 'Mewni', 'yyyy', 12345, 1234, 'yyyy');
SELECT inserisci_documento('PFFFFFF', '2000-01-01'::date, '2010-01-01'::date, 'Principessa', 'Star', 'Butterfly', false,
                           'Mewni', '2000-01-01'::date, 'B', 'Mewni', 'yyyy', 12345, 1234, 'yyyy');
SELECT inserisci_documento('GGGGGGG', '2000-01-01'::date, '2010-01-01'::date, 'Scienziato', 'Rick', 'Sanchez', false,
                           'C-132', '2000-01-01'::date, 'B', 'C-132', 'yyyy', 12345, 1234, 'yyyy');
SELECT inserisci_documento('PGGGGGG', '2000-01-01'::date, '2010-01-01'::date, 'Scienziato', 'Rick', 'Sanchez', false,
                           'C-132', '2000-01-01'::date, 'B', 'C-132', 'yyyy', 12345, 1234, 'yyyy');
SELECT inserisci_documento('HHHHHHH', '2000-01-01'::date, '2010-01-01'::date, 'Commerciante', 'Stan', 'Pines', false,
                           'California', '2000-01-01'::date, 'B', 'California', 'yyyy', 12345, 1234, 'yyyy');
SELECT inserisci_documento('PHHHHHH', '2000-01-01'::date, '2010-01-01'::date, 'Commerciante', 'Stan', 'Pines', false,
                           'California', '2000-01-01'::date, 'B', 'California', 'yyyy', 12345, 1234, 'yyyy');

INSERT INTO conducente(piva, n_documento, n_patente)
VALUES (00000000, 'FFFFFFF', 'PFFFFFF'),
       (11111111, 'GGGGGGG', 'PGGGGGG'),
       (22222222, 'HHHHHHH', 'PHHHHHH');

INSERT INTO indirizzo
VALUES ('Italia', 'Genova', 16100, 13, 'Via XX Settembre'),
       ('Italia', 'Genova', 16100, 13, 'Via Lodi'),
       ('Italia', 'Genova', 16100, 13, 'Via Piacenza');

INSERT INTO sede (piva, nazione, citta, cap, civico, via, tipo_sede)
VALUES (00000000, 'Italia', 'Genova', 16100, 13, 'Via XX Settembre', 'LEGALE'),
       (00000000, 'Italia', 'Genova', 16100, 13, 'Via Lodi', 'LEGALE'),
       (00000000, 'Italia', 'Genova', 16100, 13, 'Via Piacenza', 'LEGALE');

-- ABBONAMENTI E PRENOTAZIONE
SELECT sottoscrivi_abbonamento(now()::timestamp, now()::date, 30, 0000, 1, 'Annuale');
SELECT sottoscrivi_abbonamento(now()::timestamp, NULL, 0, 0000, 2, 'Annuale');
SELECT sottoscrivi_abbonamento(now()::timestamp, NULL, 0, 0000, 3, 'Annuale');
SELECT sottoscrivi_abbonamento(now()::timestamp, NULL, 0, 0000, 4, 'Annuale');
SELECT sottoscrivi_abbonamento(now()::timestamp, NULL, 0, 0000, 5, 'Annuale');
SELECT sottoscrivi_abbonamento(now()::timestamp, NULL, 0, 0000, 6, 'Annuale');
SELECT sottoscrivi_abbonamento(now()::timestamp, NULL, 0, 0000, 7, 'Annuale');
SELECT sottoscrivi_abbonamento(now()::timestamp, NULL, 0, 0000, 8, 'Annuale');

INSERT INTO prenotazione (smart_card, nome_vettura, data_ora_inizio, data_ora_fine)
VALUES (1, 'Andrea',   '2020-05-01', '2020-05-03'),
       (1, 'Ginevra',  '2020-05-11', '2020-05-13'),
       (2, 'Caterina', '2020-05-04', '2020-05-20'),
       (2, 'Giada',    '2020-05-01', '2020-05-08'),
       (3, 'Adele',    '2020-04-03', '2020-04-05'),
       (3, 'Claudia',  '2020-04-06', '2020-04-07'),
       (4, 'Camilla',  '2020-04-01', '2020-04-01'),
       (4, 'Ivana',    '2020-03-05', '2020-03-22'),
       (5, 'Andrea',   '2020-03-01', '2020-03-02'),
       (8, 'Lara',     '2020-03-01', '2020-03-28'),
       (6, 'Lucia',    '2020-03-20', '2020-03-22'),
       (6, 'Sara',     '2020-02-18', '2020-02-25'),
       (1, 'Andrea',   '2020-02-01', '2020-02-03'),
       (8, 'Ginevra',  '2020-02-11', '2020-02-13'),
       (2, 'Caterina', '2020-02-04', '2020-02-20'),
       (7, 'Giada',    '2020-02-01', '2020-02-01'),
       (3, 'Adele',    '2020-02-03', '2020-02-17'),
       (3, 'Claudia',  '2020-01-06', '2020-01-07'),
       (4, 'Camilla',  '2020-01-01', '2020-01-01'),
       (8, 'Ivana',    '2020-01-05', '2020-01-22'),
       (5, 'Andrea',   '2020-01-01', '2020-01-02'),
       (5, 'Lara',     '2019-12-01', '2018-12-28'),
       (6, 'Lucia',    '2019-12-20', '2018-12-22'),
       (6, 'Sara',     '2019-12-18', '2018-12-25'),
       (2, 'Caterina', '2019-12-04', '2017-12-20'),
       (2, 'Giada',    '2019-12-01', '2017-12-08'),
       (3, 'Adele',    '2019-12-03', '2017-12-05'),
       (3, 'Claudia',  '2019-11-06', '2017-11-07'),
       (4, 'Camilla',  '2019-11-01', '2017-11-01'),
       (4, 'Ivana',    '2019-11-05', '2017-11-22'),
       (5, 'Andrea',   '2019-11-01', '2017-11-02'),
       (5, 'Lara',     '2019-11-01', '2017-11-28'),
       (6, 'Lucia',    '2019-11-20', '2017-11-22'),
       (6, 'Sara',     '2019-11-18', '2017-11-25');
