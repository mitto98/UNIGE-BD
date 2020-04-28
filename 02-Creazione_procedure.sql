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
    RETURN (costo_day * giorni) + (costo_km * chilometri);
END;
$$ LANGUAGE plpgsql;

-- Tariffa settimanale
CREATE OR REPLACE FUNCTION tariffa_week(giorni numeric, costo_week numeric, costo_day numeric, costo_km numeric,
                                        chilometri numeric)
    RETURNS Numeric AS
$$
BEGIN
    RETURN ROUND(giorni / 7) * costo_week + tariffa_day(MOD(giorni, 7), costo_day, costo_km, chilometri);
END;
$$ LANGUAGE plpgsql;

-- Tariffa conveniente
CREATE OR REPLACE FUNCTION tariffa_conveniente(durata numeric, costo_orario numeric, costo_day numeric,
                                               costo_week numeric, costo_km numeric, chilometri numeric)
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
            RETURN tariffa_week(durata / 24, costo_week, costo_day, costo_km, chilometri);
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;

-------------------------
-- Metodo di pagamento --
-------------------------
CREATE OR REPLACE FUNCTION aggiunti_metodo_pagamento(int, numeric)
    RETURNS VOID AS
$$
    BEGIN
        INSERT INTO metodo_pagamento(smart_card, versato) VALUES ($1, $2);
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION aggiunti_metodo_pagamento(int, numeric, varchar(30), varchar(10), date)
    RETURNS VOID AS
$$
    BEGIN
        INSERT INTO carta
        VALUES ($2,$3,$4,$5);
        INSERT INTO metodo_pagamento(smart_card, numero_carta, intestatario_carta, circuito_carta, scadenza_carta)
        VALUES ($1, $2, $3, $4, $5);
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION aggiunti_metodo_pagamento(int, char(27), varchar(30))
    RETURNS VOID AS
$$
    BEGIN
        INSERT INTO rid
        VALUES ($2,$3);
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
    FUNCTION registra_utente(char(16), varchar(11), varchar(10), varchar(10))
    RETURNS VOID AS
$$
DECLARE
    eta date;
BEGIN

    SELECT DATE_PART('year', NOW()) - DATE_PART('year', documento.data_nascita)
    INTO eta
    FROM documento
    WHERE documento.n_documento = $3;

    INSERT INTO Persona (cf, telefono, eta, n_documento, n_patente)
    VALUES ($1, $2, eta, $3, $4);

    RETURN;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION aggiungi_conducente_secondario(char(16), char(16))
    RETURNS VOID AS
$$
DECLARE
    owner_address     RECORD;
    secondary_address RECORD;
BEGIN
    SELECT count(*) = 1
    FROM persona p
             JOIN documento d on p.n_documento = d.n_documento
    WHERE p.cf = $1
       OR cf = $2;


/*
    IF docConduc = NULL
    THEN
        INSERT INTO Persona
        VALUES (codFisc, id_conducente1, telefono, calcolaEta(datanascita), nrDocumento1, nrPatente);
    ELSE
        IF isSameAddress(nrPatente, docConduc)
        THEN
            INSERT INTO Persona
            VALUES (codFisc, id_conducente1, telefono, calcolaEta(datanascita), nrDocumento1, nrPatente);
        ELSE
            RAISE EXCEPTION 'Inserimento abortito '
                USING HINT = 'Il conducente scelto non Abita insieme o non esistente';
        END IF;
    END IF;
 */
END;
$$ LANGUAGE plpgsql;