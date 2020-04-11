# Progetto basi di dati
  
## Giorno 1
CREATE TABLE  

Gestione delle diverse tipologie di utenti, conducenti, bonus e modalità di pagamento.  
Per le parti non assegnate coprire solo na porzione minimale  

## Giorno 2
Fare i trigger per rispettare i vincoli

## Giorno 3
INSERT  
Inserire i valori dentro le tabelle

## Giorno 4
CREARE ALMENO TRE PROCEDURE/FUNZIONI

* Vista fatturazione: Per ogni utilizzo concluso mostra le tariffe (se applicabili), senza tenere conto delle penali

* Partendo dal punto precedente ottenere il prezzo minore e applicare penali e bonus

* SELECT semplici (una con differenza e una con outer join)
  * Determinare i parcheggi in una zona, di una categoria categoria, che abbano una vattura disponibile nelle prossime tre ore
  * Ottenere coppia utente / veicolo dei noleggi attualmente in corso e l'orario previsto di riconsegna
  * Determinare i parcheggi che non abbiano nemmeno una prenotazione nella prossima ora 
* SELECT -> 3 inserimenti, 3 cancellazionik e 3 modifiche significative
* SELECT complesse (una con GROUP BY, una con sottointerrogazione e una con divisione
  * Data una vettura, determinare i suoi utilizzi nell'ultima settimana, calcolando i minuti effettivi d'uso e di prenotazione in cui non era usata
  * Determinare il parcheggio con tempo di noleggio medio maggiore
  * determinare gli utenti che hanno utilizzato tutte le vetture almeno una volta