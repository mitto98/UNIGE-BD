-- Determinare i parcheggi in una zona, di una categoria,
--   che abbiano una vettura disponibile nelle prossime tre ore
SELECT p.*
FROM parcheggio AS p,
     vettura AS v,
     prenotazione,
     modello AS m,
     categoria AS c
WHERE c.categoria = 'Electric'
  AND p.nome_parcheggio = v.sede
  AND v.nome_vettura = prenotazione.nome_vettura
  AND v.modello = m.nome_modello
  AND m.categoria = c.categoria
  AND EXTRACT(HOUR FROM current_date) + 3 = EXTRACT(HOUR FROM prenotazione.data_ora_inizio::date);


-- Determinare i parcheggi che hanno una prenotazione nella prossima ora
SELECT p.nome_parcheggio, cat.categoria
FROM parcheggio AS p,
     vettura AS v,
     prenotazione AS pren,
     modello AS m,
     categoria AS cat
WHERE p.nome_parcheggio = v.sede
  AND v.nome_vettura = pren.nome_vettura
  AND v.modello = m.nome_modello
  AND m.categoria = cat.categoria
  AND EXTRACT(hour FROM current_date) = EXTRACT(hour FROM pren.data_ora_inizio)
GROUP BY p.nome_parcheggio, cat.categoria
HAVING count(*) >= 1;


-- Ottenere coppia utente / veicolo dei noleggi attualmente in corso e l'orario previsto di riconsegna
SELECT u.*, v.nome_vettura, v.targa, utilizzo.data_ora_riconsegna
FROM utente AS u
         NATURAL JOIN metodo_pagamento AS mdp
         NATURAL JOIN abbonamento AS a
         NATURAL JOIN prenotazione AS pr
         NATURAL JOIN vettura AS v,
     utilizzo,
     prenotazione
WHERE prenotazione.smart_card = a.smart_card
  AND prenotazione.numero_prenotazione = utilizzo.numero_prenotazione
  AND utilizzo.data_ora_ritiro::date < utilizzo.data_ora_riconsegna::date;

-- Determinare i parcheggi che non abbiano nemmeno una prenotazione nella prossima ora ma ne abbiano nell'ora successiva
SELECT p.nome_parcheggio, cat.categoria
FROM parcheggio AS p,
     vettura AS v,
     prenotazione AS pren,
     modello AS m,
     categoria AS cat
WHERE p.nome_parcheggio = v.sede
  AND v.nome_vettura = pren.nome_vettura
  AND v.modello = m.nome_modello
  AND m.categoria = cat.categoria
  AND EXTRACT(hour FROM current_date) + 1 = EXTRACT(hour FROM pren.data_ora_inizio)
GROUP BY p.nome_parcheggio, cat.categoria
HAVING count(*) >= 1;


--Numero di prenotazioni per utente
SELECT u.smart_card, u.email, count(*) as numero_prenotazioni
FROM utente u
         JOIN prenotazione p on u.smart_card = p.smart_card
GROUP BY u.smart_card, u.email;

--Numero di utenti che sono aziende
SELECT count(*)
FROM utente u
WHERE u.piva IS NOT NULL

-- Vettura con più chilometri
SELECT vettura.*
FROM vettura
WHERE vettura.chilometraggio = (SELECT MAX(v.chilometraggio) FROM vettura v);

-- Vettura con meno chilometri
SELECT vettura.*
FROM vettura
WHERE vettura.chilometraggio = (SELECT MIN(v.chilometraggio) FROM vettura v);

-- Vetture con prenotazioni che hanno tra 10000 e 20000 km
SELECT v.*
FROM vettura v
         RIGHT OUTER JOIN prenotazione p
                          ON v.nome_vettura = p.nome_vettura
WHERE v.chilometraggio > 10000
  AND v.chilometraggio <= 20000;

  -- determinare le vetture attrezzate al trasporto anche di animali
SELECT vettura.*
FROM vettura
WHERE vettura.animali IS TRUE;


-- Vetture con (almeno) 5 porte
SELECT v.*
FROM vettura v
         JOIN modello m on v.modello = m.nome_modello
WHERE m.n_porte >=5

-- I parcheggi con vetture elettriche e conteggio
SELECT p.*, count(v) AS numero_elettrici
FROM parcheggio p
         JOIN vettura v on p.nome_parcheggio = v.sede
         JOIN modello m on v.modello = m.nome_modello
WHERE m.categoria = 'Electric'
GROUP BY p.nome_parcheggio;


-- Vetture con più di 100000 km
SELECT v.*
FROM vettura v
WHERE v.chilometraggio > 100000


-- Determinare gli utenti che hanno utilizzato tutte le vetture almeno una volta
SELECT u.email, u.smart_card
from utente u
         JOIN prenotazione p on u.smart_card = p.smart_card
GROUP BY u.smart_card, u.email
HAVING count(p.nome_vettura) = ALL (SELECT count(*) FROM vettura v)


--  Data una vettura, determinare i suoi utilizzi nell'ultima settimana,
--    calcolando i minuti effettivi d'uso e di prenotazione in cui non era usata
SELECT vettura.nome_vettura,
       sum(DATE_PART('day', u.data_ora_riconsegna - u.data_ora_ritiro) * 24 +
           DATE_PART('hour', u.data_ora_riconsegna - u.data_ora_ritiro))       as ore_uso,

       sum(DATE_PART('day', p.data_ora_fine - p.data_ora_inizio) * 24 +
           DATE_PART('hour', p.data_ora_fine - p.data_ora_inizio))
           - sum(DATE_PART('day', u.data_ora_riconsegna - u.data_ora_ritiro) * 24 +
                 DATE_PART('hour', u.data_ora_riconsegna - u.data_ora_ritiro)) as ore_ferma
FROM vettura
         JOIN prenotazione p on vettura.nome_vettura = p.nome_vettura
         JOIN utilizzo u on p.numero_prenotazione = u.numero_prenotazione
WHERE p.data_ora_inizio >= now() - interval '1 month' -- todo mettere 1 settimana
GROUP BY vettura.nome_vettura;

-- Determinare il parcheggio con tempo di noleggio medio maggiore
SELECT nome_parcheggio, uso_medio
FROM (SELECT parcheggio.nome_parcheggio,
             avg(DATE_PART('day', p.data_ora_fine - p.data_ora_inizio) * 24 +
                 DATE_PART('hour', p.data_ora_fine - p.data_ora_inizio)) as uso_medio
      FROM parcheggio
               JOIN vettura v on parcheggio.nome_parcheggio = v.sede
               JOIN prenotazione p on v.nome_vettura = p.nome_vettura
      GROUP BY parcheggio.nome_parcheggio) parcheggi
where uso_medio = (SELECT max(uso_medio)
                   FROM (SELECT avg(DATE_PART('day', p.data_ora_fine - p.data_ora_inizio) * 24 +
                                    DATE_PART('hour', p.data_ora_fine - p.data_ora_inizio)) as uso_medio
                         FROM parcheggio
                                  JOIN vettura v
                                       on parcheggio.nome_parcheggio = v.sede
                                  JOIN prenotazione p on v.nome_vettura = p.nome_vettura
                         GROUP BY parcheggio.nome_parcheggio) parcheggi);

-- Determinare gli utenti che non hanno utilizzato tutte le vetture almeno una volta
SELECT u.email, u.smart_card
from utente u
         JOIN prenotazione p on u.smart_card = p.smart_card
GROUP BY u.smart_card, u.email
HAVING count(p.nome_vettura) != ALL (SELECT count(*) FROM vettura v)

-- Determinare gli utenti che hanno utilizzato tutte le vetture almeno una volta
SELECT u.email, u.smart_card
from utente u
         JOIN prenotazione p on u.smart_card = p.smart_card
GROUP BY u.smart_card, u.email
HAVING count(p.nome_vettura) = ALL (SELECT count(*) FROM vettura v)
