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
    INSERT INTO modifica_prenotazione(numero_prenotazione, data_ora_rinuncia, nuova_data_ora_inizio, nuova_data_ora_rest)
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
    IF bData > now()::timestamp AND new.nuova_data_ora_inizio < new.nuova_data_ora_rest
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