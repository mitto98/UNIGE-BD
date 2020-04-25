------------------------------
-- Trigger vincoli di stato --
------------------------------

-- Trigger limite tempo inserimetno
-- Una prenotazione puo essere fatta solo entro 15 minuti dal ritiro
CREATE OR REPLACE FUNCTION check_limite_prenotazione()
    RETURNS TRIGGER AS
$check_limite_prenotazione$
BEGIN
    IF NOW() <= NEW.data_ora_inizio - interval '15 minute'
    THEN
        RAISE EXCEPTION 'Non puoi creare una prenotazione con un preavviso minore di 15 minuti';
    ELSE
        RETURN NEW;
    END IF;
END;
$check_limite_prenotazione$ LANGUAGE plpgsql;

CREATE TRIGGER check_limite_prenotazione
    BEFORE INSERT OR UPDATE
    ON prenotazione
    FOR EACH ROW
EXECUTE PROCEDURE check_limite_prenotazione();

-- Log modifica prenotazione
CREATE OR REPLACE FUNCTION log_cambiamento_prenotazione()
    RETURNS TRIGGER AS
$log_cambiamento_prenotazione$
BEGIN
    INSERT INTO modifica_prenotazione(numero_prenotazione, data_ora_rinuncia, nuova_data_ora_inizio, nuova_data_ora_fine)
    VALUES (OLD.numero_prenotazione, now()::timestamp, OLD.data_ora_inizio, OLD.data_ora_fine);
    RETURN NEW;
END;
$log_cambiamento_prenotazione$ LANGUAGE plpgsql;

CREATE TRIGGER log_cambiamento_prenotazione
    BEFORE UPDATE
    ON prenotazione
    FOR EACH ROW
EXECUTE PROCEDURE log_cambiamento_prenotazione();

-- Controllo coerenza date modifica prenotazione
CREATE OR REPLACE FUNCTION check_coerenza_date_prenotazione()
    RETURNS TRIGGER AS
$check_coerenza_date_prenotazione$
DECLARE
    bData timestamp;
BEGIN
    SELECT data_ora_inizio
    INTO bData
    FROM prenotazione
    WHERE prenotazione.numero_prenotazione = new.numero_prenotazione;
    IF bData > now()::timestamp AND new.nuova_data_ora_inizio < new.nuova_data_ora_inizio
    THEN
        new.data_ora_rinuncia = now()::timestamp;
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Le date non sono coerenti';
    END IF;
END;
$check_coerenza_date_prenotazione$ LANGUAGE plpgsql;

CREATE TRIGGER check_coerenza_date_prenotazione
    BEFORE INSERT OR UPDATE
    ON modifica_prenotazione
    FOR EACH ROW
EXECUTE PROCEDURE check_coerenza_date_prenotazione();

-- Una prenotazione puo essere fatta solo entro 15 minuti dal ritiro
CREATE OR REPLACE FUNCTION check_validita_carta()
    RETURNS TRIGGER AS
$check_validita_carta$
BEGIN
    IF NEW.scadenza >= NOW()
    THEN
        RAISE EXCEPTION 'La carta è scaduta';
    ELSE
        RETURN NEW;
    END IF;
END;
$check_validita_carta$ LANGUAGE plpgsql;

CREATE TRIGGER check_validita_carta
    BEFORE INSERT OR UPDATE
    ON carta
    FOR EACH ROW
EXECUTE PROCEDURE check_validita_carta();


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