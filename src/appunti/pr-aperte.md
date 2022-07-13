# PR chiuse
## Users #1
### 19/05
- Configurazione del repo per REST invece di GraphQL
- Modello User
- Specs
Mancano i permessi degli utenti della gerarchia e i relativi loro test

(notare che manca il campo organizer_id, presente nell’ER, perché ovviamente il modello Organizer viene creato successivamente)

## Users routes #2
### 26-05
Endpoint relativi al modello degli utenti.

> lasciare TODO in giro per spiegare agli altri scelte particolari

## Modelli sistema di piattaforme e organizzatori #3
### 31/05
- Modello temporaneo dei piani
- Modello delle piattaforme, con validazioni
- Modello degli organizzatori, con associazione a utenti

> occhio ai `dependent: :destroy`

## User associations #4
### 10/06
Rimosso il dependent: destroy da User come detto a voce, modificando controlli e validazioni relative.

## Users authorize #5
### 15/06
Gestione dei permessi degli utenti (base, senza organizer)

## Users organizer authorize #6 (rifiutata)
### 17/06
Cambiata la logica delle autorizzazioni per gli utenti, introducendo i controlli sugli organizzatori e le piattaforme.

Introdotto ~~il default scope~~ uno scope per filtrare gli utenti archiviati.

> non va bene usare la gerarchia (che poi era rovesciata e non espandibile) per valutare i permessi, perché troppo complessa e potrebbe avere evoluzioni

## Users fixes #7
### 20/06
Fix vari nei modelli, specialmente relativi alle associations.

Ereditato lo scope `visible` dal branch `feature/users-organizer-authorize`

## Platforms routes #8
### 20/06
Routes e permessi delle piattaforme e dei piani.

# PR rimaste aperte
## Organizers routes #9 (Approvata)
### 21/06
Controller e permessi relativi agli organizzatori.

## Refined serializers #10
### 22/06
- Inclusi gli url delle immagini nei serializers
- Aggiunti i `list_serializer` per le action `index`

> da rivalutare i nomi dei serializzatori. Non piace che siano dipendenti dal contesto d'uso

## Archived scheduler #11 (Approvata)
### 22/06
Scheduler che elimina gli utenti archiviati.

## Plan improve #12
### 22/06
Modello dei piani uniformato agli altri modelli del sistema, introducendo il tracciamento del creator e lo stato, per la distruzione logica

## Locations #13
### 23/06
Modello, controller e policies delle locations.

## Creator #14
### 24/06
Aggiunto concern Creator, per aggiungere automaticamente le associazioni e validazioni necessarie ai modelli che hanno un creator.

> da trovare una soluzione per il bug dell'eager loading (user che non ha `created_objs` finché non viene caricato l'altro modello)
