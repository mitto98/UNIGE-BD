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