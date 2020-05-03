CREATE OR REPLACE VIEW fatturazione_x AS
SELECT p.numero_prenotazione,
       p.smart_card,
       p.nome_vettura,
       diff_in_ore(p.data_ora_inizio, p.data_ora_fine),
       tariffa_oraria(
               diff_in_ore(p.data_ora_inizio, p.data_ora_fine),
               m.t_oraria,
               m.t_chilometrica,
               u.chilometraggio_riconsegna - u.chilometraggio_ritiro
           ),
       tariffa_day(
               diff_in_ore(p.data_ora_inizio, p.data_ora_fine) / 24,
               m.t_giornaliera,
               m.t_chilometrica,
               u.chilometraggio_riconsegna - u.chilometraggio_ritiro
           ),
       tariffa_week(
               diff_in_ore(p.data_ora_inizio, p.data_ora_fine) / 24,
               m.t_settimanale,
               m.t_giornaliera_aggiuntiva,
               m.t_chilometrica,
               u.chilometraggio_riconsegna - u.chilometraggio_ritiro
           ),
       tariffa_conveniente(
               diff_in_ore(p.data_ora_inizio, p.data_ora_fine),
               m.t_oraria,
               m.t_giornaliera,
               m.t_giornaliera_aggiuntiva,
               m.t_settimanale,
               m.t_chilometrica,
               u.chilometraggio_riconsegna - u.chilometraggio_ritiro
           )
FROM prenotazione p
         JOIN vettura v on p.nome_vettura = v.nome_vettura
         JOIN modello m on v.modello = m.nome_modello
         JOIN utilizzo u on p.numero_prenotazione = u.numero_prenotazione
WHERE data_ora_fine < now();