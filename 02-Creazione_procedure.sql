-------------------------------
-- Procedure calcolo fattura --
-------------------------------

-- Tariffa oraria
CREATE OR REPLACE FUNCTION tariffa_oraria(durata numeric, costo_orario numeric, costo_km numeric, chilometri numeric)
    RETURNS numeric AS
$$
BEGIN
    RETURN (costo_orario * durata) + (costo_km * chilometri);
END;
$$ LANGUAGE plpgsql;

-- Tariffa giornaliera
CREATE OR REPLACE FUNCTION tariffa_day(giorni numeric, costo_day numeric, costo_km numeric, chilometri numeric)
    RETURNS numeric AS
$$
BEGIN
    IF giorni < 1
    THEN
        RETURN -1;
    END IF;
    RETURN (costo_day * giorni) + (costo_km * chilometri);
END;
$$ LANGUAGE plpgsql;

-- Tariffa settimanale
CREATE OR REPLACE FUNCTION tariffa_week(giorni numeric, costo_week numeric, costo_day numeric, costo_km numeric,
                                        chilometri numeric)
    RETURNS Numeric AS
$$
BEGIN
    IF giorni < 7
    THEN
        RETURN -1;
    END IF;
    RETURN ROUND(giorni / 7) * costo_week + tariffa_day(MOD(giorni, 7), costo_day, costo_km, chilometri);
END;
$$ LANGUAGE plpgsql;

-- Tariffa conveniente
CREATE OR REPLACE FUNCTION tariffa_conveniente(durata numeric, costo_orario numeric, costo_day numeric,
                                               costo_day_agg numeric, costo_week numeric, costo_km numeric,
                                               chilometri numeric)
    RETURNS numeric AS
$$
BEGIN
    IF durata < 24
    THEN
        RETURN tariffa_oraria(durata, costo_orario, costo_km, chilometri);
    ELSE
        IF (durata / 24) < 7
        THEN
            RETURN tariffa_day(durata / 24, costo_day, costo_km, chilometri);
        ELSE
            RETURN tariffa_week(durata / 24, costo_week, costo_day_agg, costo_km, chilometri);
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;

-------------------------
-- Metodo di pagamento --
-------------------------
CREATE OR REPLACE FUNCTION aggiungi_metodo_pagamento(int, numeric)
    RETURNS VOID AS
$$
BEGIN
    INSERT INTO metodo_pagamento(smart_card, versato) VALUES ($1, $2);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION aggiungi_metodo_pagamento(int, numeric, varchar(30), varchar(10), date)
    RETURNS VOID AS
$$
BEGIN
    INSERT INTO carta
    VALUES ($2, $4, $3, $5);
    INSERT INTO metodo_pagamento(smart_card, numero_carta, intestatario_carta, circuito_carta, scadenza_carta)
    VALUES ($1, $2, $3, $4, $5);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION aggiungi_metodo_pagamento(int, char(27), varchar(30))
    RETURNS VOID AS
$$
BEGIN
    INSERT INTO rid
    VALUES ($2, $3);
    INSERT INTO metodo_pagamento(smart_card, iban, intestatario_conto)
    VALUES ($1, $2, $3);
END;
$$ LANGUAGE plpgsql;

--------------------------
-- Procedure di utilità --
--------------------------
CREATE OR REPLACE
    FUNCTION inserisci_documento(varchar(10), date, date, varchar(30), varchar(10), varchar(15), bool, varchar(20),
                                 date, char(1), varchar(20), varchar(20), numeric(5, 0), numeric(4, 0), varchar(20))
    RETURNS VOID AS
$$
BEGIN
    INSERT INTO Indirizzo VALUES ($11, $12, $13, $14, $15) ON CONFLICT DO NOTHING;
    INSERT INTO Documento
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15);
END;
$$ LANGUAGE plpgsql;

-- Creazione utente
CREATE OR REPLACE
    FUNCTION registra_persona(char(16), varchar(11), varchar(10), varchar(10))
    RETURNS VOID AS
$$
DECLARE
    eta numeric;
BEGIN

    SELECT DATE_PART('year', NOW()) - DATE_PART('year', documento.data_nascita)
    INTO eta
    FROM documento
    WHERE documento.n_documento = $3;

    INSERT INTO persona (cf, telefono, eta, n_documento, n_patente)
    VALUES ($1, $2, eta, $3, $4);

    INSERT INTO conducente (n_documento, n_patente)
    VALUES ($3, $4);

    RETURN;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION aggiungi_conducente_secondario(char(16), varchar(11))
    RETURNS VOID AS
$$
DECLARE
    own_add RECORD;
    sec_add RECORD;
BEGIN
    SELECT d.nazione, d.citta, d.cap, d.civico, d.via
    INTO own_add
    FROM persona p
             JOIN documento d on p.n_documento = d.n_documento
    WHERE p.cf = $1;

    SELECT d.nazione, d.citta, d.cap, d.civico, d.via
    INTO sec_add
    FROM documento d
    WHERE d.n_documento = $2;

    IF own_add.nazione = sec_add.nazione
        AND own_add.citta = sec_add.citta
        AND own_add.cap = sec_add.cap
        AND own_add.civico = sec_add.civico
        AND own_add.via = sec_add.via
    THEN
        UPDATE persona
        SET id_conducente = (SELECT id_conducente
                             from conducente
                             where conducente.n_documento = $2
                                OR conducente.n_patente = $2)
        WHERE cf = $1;
        RETURN;
    ELSE
        RAISE EXCEPTION 'Non sono conviventi';
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sottoscrivi_abbonamento(timestamp, date, numeric, numeric, numeric, varchar)
    RETURNS VOID AS
$$
DECLARE
    durata int;
BEGIN
    SELECT n_giorni INTO durata FROM tipo WHERE periodo = $6;

    --    SELECT eta
--    INTO eta
--    FROM utente
--             NATURAL JOIN persona
--    WHERE smart_card = card;

--    IF eta > 26
--    THEN
    INSERT INTO abbonamento(data_inizio, data_fine, data_bonus, bonus_rottamazione, pin_carta, smart_card, tipo)
    VALUES ($1, $1 + durata * INTERVAL '1 day', $2, $3, $4, $5, $6);
    --    ELSE

--    END IF;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION diff_in_ore(date, date)
    RETURNS numeric AS
$$
BEGIN
    return DATE_PART('day', $2 - $1) * 24 + DATE_PART('hour', $2 - $1);
END;
$$ LANGUAGE plpgsql;
