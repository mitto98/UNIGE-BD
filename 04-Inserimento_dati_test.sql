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

SELECT aggiungi_conducente_secondario('AAAAAA00A00A000A', 'BBBBBBB')

-- Inserimento azienda
           INSERT
INTO rappresentante
VALUES ('Star', 'Butterfly', '2000-01-01', 'Mewni'),
       ('Rick', 'Sanchez', '1968-01-01', 'Terra C-132'),
       ('Mabel', 'Pines', '1982-01-01', 'California');

INSERT INTO referente
VALUES ('0000000000', 'Marco', 'Diaz'),
       ('0000000001', 'Morty', 'Smith'),
       ('0000000002', 'Dipper', 'Pines');

INSERT INTO azienda
VALUES (00000000, 'Star vs the force of evil', '0000000000', '0000000000', 'Star', 'Butterfly', '2000-01-01'),
       (11111111, 'Rick and morty', '1111111111', '0000000001', 'Rick', 'Sanchez', '1968-01-01'),
       (22222222, 'Gravity falls', '2222222222', '0000000002', 'Mabel', 'Pines', '1982-01-01');

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
VALUES ('Italia', 'Genova', 16121, 13, 'Via XX Settembre'),
       ('Italia', 'Genova', 16137, 8, 'Via Lodi'),
       ('Italia', 'Genova', 16149, 15, 'Via Piacenza');

INSERT INTO sede (piva, nazione, citta, cap, civico, via, tipo_sede)
VALUES (00000000, 'Italia', 'Genova', 16100, 13, 'Via XX Settembre', 'legale'),
       (00000000, 'Italia', 'Genova', 16100, 13, 'Via Lodi', 'legale'),
       (00000000, 'Italia', 'Genova', 16100, 13, 'Via Piacenza', 'legale');

-- INSERIMENTO METODI PAGAMENTO, ABBONAMENTI E PRENOTAZIONE
SELECT aggiungi_metodo_pagamento(1, 'MW0000000000000000000000000', 'Moon Butterfly');
SELECT aggiungi_metodo_pagamento(2, 950);
SELECT aggiungi_metodo_pagamento(3, 1234123412341234, 'Stan Pines', 'Mastercard', '2024-06-12'::date);
SELECT aggiungi_metodo_pagamento(4, 'US0000000000000000000000000', 'Award Stark');
SELECT aggiungi_metodo_pagamento(5, 1234123412341235, 'Stan Pines', 'VISA', '2026-11-13'::date);
SELECT aggiungi_metodo_pagamento(6, 50);
SELECT aggiungi_metodo_pagamento(7, 2000);
SELECT aggiungi_metodo_pagamento(8, 230);

SELECT insertAbbonamento(now()::timestamp, now()::date, 30, 0000, 1, 'Annuale');
SELECT insertAbbonamento(now()::timestamp, NULL, 0, 0000, 2, 'Annuale');
SELECT insertAbbonamento(now()::timestamp, NULL, 0, 0000, 3, 'Annuale');
SELECT insertAbbonamento(now()::timestamp, NULL, 0, 0000, 4, 'Annuale');
SELECT insertAbbonamento(now()::timestamp, NULL, 0, 0000, 5, 'Annuale');
SELECT insertAbbonamento(now()::timestamp, NULL, 0, 0000, 6, 'Annuale');
SELECT insertAbbonamento(now()::timestamp, NULL, 0, 0000, 7, 'Annuale');
SELECT insertAbbonamento(now()::timestamp, NULL, 0, 0000, 8, 'Annuale');
