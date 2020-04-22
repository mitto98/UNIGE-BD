# Progetto basi di dati
Abbiamo utilizzato lo snake case siccome, a meno che non sia delimitato da apici, postgresql è case-insensitive.

Si assume che tutte le misure siano espresse in centimetri
## Vincoli sul dominio degli attributi
1.  In `sede` il campo `tipo sede` può valere `legale` o `operativa`
2.  In `documento` il campo `scadenza` deve essere successivo ad oggi
3.  In `documento` il campo `data_nascita` deve essere precedente a 18 anni fa
4.  In `persona` il campo `cf` deve rispettare la regex (vedi il vincolo)
5.  In `persona` il campo `eta` deve essere maggiore o uguale a 18
6.  In `modello` il campo `lunghezza` deve essere compreso tra 0 e 500
7.  In `modello` il campo `larghezza` deve essere compreso tra 0 e 250
8.  In `modello` il campo `altezza` deve essere compreso tra 0 e 250
9.  In `modello` il campo `n_porte` deve essere compreso tra 2 e 5
10. In `modello` il campo `velocita` deve essere compreso tra 30 e 350
11. In `vettura` il campo `targa` deve rispettare la regex (vedi il vincolo)
12. In `carta` il campo `scadenza` deve essere successivo ad oggi
13. In `abbonamento`, `data_inizio` deve essere minore di `data_fine`
14. In `utente` il campo `email` deve rispettare la regex (vedi il vincolo)
15. In `fatturazione`, `tempo_usufruito + tempo_non_usufruito` deve essere maggiore di 0
16. In `prenotazione`, `data_ora_inizio` deve essere prima di `data_ora_fine`
17. In `modifica_prenotazione`, `nuova_data_ora_inizio` deve essere prima di `nuova_data_ora_fine`
18. In `utilizzo`, `data_ora_ritiro` deve essere prima di `data_ora_riconsegna`
19. In `utilizzo`, `chilometraggio_ritiro` deve essere prima di `chilometraggio_riconsegna`

## Vincoli di stato
1.  Una prenotazione puo essere fatta solo entro 15 minuti dal ritiro
2.  Logging modifiche e chiusura prenotazione
3.  Coerenza date modifica prenotazione
4.  Non si può inserire una carta scaduta


## Roadmap
### Giorno 1 ✔
CREATE TABLES
Gestione delle diverse tipologie di utenti, conducenti, bonus e modalità di pagamento.  
Per le parti non assegnate coprire solo na porzione minimale  

### Giorno 2 ~
Fare i trigger per rispettare i vincoli:
* Coprire la porzione di basi di dati relativa a vetture, modelli, parcheggi, abbonamenti, prenotazioni e effettivi utilizzi.
* Gestione delle diverse tipologie di utenti, conducenti abilitati, bonus e modalità di pagamento.

### Giorno 3 ✔
Inserire i valori dentro le tabelle base

### Giorno 4 ❌
Inserire valori di test dentro le tabelle

### Giorno 5 ❌
CREARE ALMENO TRE PROCEDURE/FUNZIONI

* Vista fatturazione: Per ogni utilizzo concluso mostra le tariffe (se applicabili), senza tenere conto delle penali

* Partendo dal punto precedente ottenere il prezzo minore e applicare penali e bonus

* SELECT semplici (una con differenza e una con outer join)
  * Determinare i parcheggi in una zona, di una categoria categoria, che abbano una vattura disponibile nelle prossime tre ore
  * Ottenere coppia utente / veicolo dei noleggi attualmente in corso e l'orario previsto di riconsegna
  * Determinare i parcheggi che non abbiano nemmeno una prenotazione nella prossima ora 

### Giorno 6 ❌
* SELECT -> 3 inserimenti, 3 cancellazioni e 3 modifiche significative
* SELECT complesse (una con GROUP BY, una con sottointerrogazione e una con divisione
  * Data una vettura, determinare i suoi utilizzi nell'ultima settimana, calcolando i minuti effettivi d'uso e di prenotazione in cui non era usata
  * Determinare il parcheggio con tempo di noleggio medio maggiore
  * determinare gli utenti che hanno utilizzato tutte le vetture almeno una volta