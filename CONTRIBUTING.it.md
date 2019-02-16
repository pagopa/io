# Contribuire al progetto

Grazie per l'interesse mostrato nei confronti del progetto ! 🎉

Cittadinanza Digitale è un progetto aperto a tutti:
sono benvenuti contributi, suggerimenti e richieste di nuove caratteristiche.

Sebbene lo scopo precipuo sia erogare un servizio per i Cittadini,
tra gli obiettivi del progetto si pone quello di fornire alle Amministrazioni
e ai loro fornitori software "pronto da utilizzare": un prezioso strumento
che faciliti l'integrazione con le "[piattaforme abilitanti
](https://pianotriennale-ict.italia.it/piattaforme-abilitanti/)" previste dal
[piano triennale per l'informatica nella PA](https://pianotriennale-ict.italia.it/).

Cittadinanza Digitale, pertanto, non solo abbraccia il paradigma open source
e del [riuso](https://lg-acquisizione-e-riuso-software-per-la-pa.readthedocs.io/it/latest/)
così come proposto nella community di [developers.italia.it](https://developers.italia.it/it/progetti),
ma vuol porsi come implementazione di riferimento per l'integrazione con i sotto-sistemi:

* [SPID](https://www.spid.gov.it/), il Sistema Pubblico di Identità Digitale
* [PagoPA](http://www.agid.gov.it/agenda-digitale/pubblica-amministrazione/pagamenti-elettronici),
  il sistema dei pagamenti a tutte le Pubbliche Amministrarzioni
* [ANPR](https://www.anpr.interno.it/portale/), l'Anagrafe Nazionale della Popolazione Residente
* il [Sistema di avvisi e notifiche di cortesia](https://pianotriennale-ict.italia.it/piattaforme-abilitanti/)

A tale scopo è importante l'aiuto di tutti:
solo tramite un processo di miglioramento continuo
sarà possibile raggiungere alti standard che riguardano:

* la qualità del software e della documentazione a corredo
* la sicurezza delle componenti del sistema
* un'esperienza utente efficace e soddisfacente, che segua i principi
  sulla progettazione dei servizi dettati da [designers.italia.it](https://designers.italia.it)

Quel che segue è un insieme di linee guida per poter contribuire
all'evoluzione delle componenti che costituiscono il frontend
(App mobile) e il backend (API) di Cittadinanza Digitale,
scrivendo codice o integrando la documentazione,
nonché una descrizione della metodologia di lavoro
che vuol esser trasparente (e possibilmente esemplare :wink:).

## Come segnalare un bug o proporre una feature

Se hai domande o proposte ti suggeriamo di condividerle sul forum nella sezione dedicata:
https://forum.italia.it/c/progetto-io/

In alternativa puoi trovarci su Slack nel
canale [#io-pa](https://slack.developers.italia.it/) di developers.italia.it.

# Risorse

Lo sviluppo dell'app e del suo backend avviene su [GitHub](http://github.com).

Prima di iniziare ti consigliamo di leggere i README contenuti nella directory radice
dei repository elencati in questa sezione. Potrai trovare:

* la descrizione dell'architettura del backend e le scelte che ne hanno portato la definizione
* la descrizione dettagliata del funzionamento del software e l'interazione tra le componenti
* le procedure per sviluppare localmente e le dipendenze da installare

## Repository GitHub

Repository principale con la descrizione dell'infrastruttura:  
https://github.com/teamdigitale/io

Sorgenti delle API di notifica / preferenze (Azure Functions):  
https://github.com/teamdigitale/io-functions

Sorgenti dell'App mobile:  
https://github.com/teamdigitale/io-app

Sorgenti del backend dell'App:  
https://github.com/teamdigitale/io-backend

Sorgenti del proxy per le API di PagoPa:  
https://github.com/teamdigitale/io-pagopa-proxy

Sorgenti del client API PagoPA:  
https://github.com/teamdigitale/io-pagopa-api

Utilità per l'onboarding nel developer portal:  
https://github.com/teamdigitale/io-onboarding

Sorgenti del sito web di presentazione dell'App:  
https://github.com/teamdigitale/io-landing

## Sito web dell'App

Sito Web rivolto ai Cittadini per spiegare i benefici dell'App:

[io.italia.it](http://io.italia.it)

# Pianificazione delle attività: Pivotal Tracker (ITA)

Per pianificare le attività e tracciarne il progresso utilizziamo
[Pivotal Tracker](http://pivotaltracker.com) scrivendo in italiano.

Esiste un progetto su Pivotal Tracker per ogni componente sviluppata
(o ancora da sviluppare :-).

I membri di uno specifico progetto hanno in carico la creazione
delle singole attività. Le attività vengono inizialmente inserite
nella "Icebox" dopodiché quelle considerate più urgenti sono
spostate nel "Backlog". Chi lavora su un progetto sceglie un'attività
dal backlog e la assegna a sè stesso quando inizia a lavorarla.

Può capitare che sia il maintainer del singolo progetto
ad assegnare le attività ai membri; questi riceveranno
una notifica al momento dell'assegnazione.

Gli stati di lavorazione assegnabili a ogni "feature" sono:

* **started**: l'attività è stata presa in carico ed è ora in lavorazione
* **finished**: è stata effettuata una Pull Request che è in attesa di Code Review
* **delivered**: la Pull Request ha passato la Code Review
* **accepted**: la PR è stata incorporata nel branch "master" e il codice è in esecuzione sull'ambiente di test

Le attività possono esser classificate come:

* **feature**: attività che corrispondono a "user stories"; sono espresse necessariamente nella forma
  `Come <.. personas... > voglio <... feature da implementare ...> in modo da <... valore aggiunto ...>`
* **chore**: attività che non portano direttamente un valore aggiunto per gli utenti del sistema,
  ma risultano utili nella fase di sviluppo (es. refactoring, modifiche dell'infrastruttura)
* **bug**: un malfunzionamento che deve essere corretto
* **release**: milestone il rilascio in produzione di una specifica versione del componente

Gli attori del sistema (_personas_) che utilizziamo nelle _user stories_ sono:

* **CIT**: i Cittadini che interagiscono con il frontend (es. App mobile)
* **SAS**: soggetti aderenti al sistema; ad esempio le PA che possono utilizzare le API di notifica e preferenze
* **AMS**: l'amministratore del sistema (Team Digitale / AgID / gestore del servizio)

Ogni attività appartiene a una **epic** (es. `epic-security`) che la colloca in uno specifico contesto.
Le _chore_ trasversali a più epic sono classificate nella epic `epic-technical-debt`.

**Crea sempre un issue su Pivotal Tracker prima di iniziare a lavorare su un'attività !**

Come buona pratica ogni attività deve essere _atomica_ e realizzabile
in un tempo relativamente breve (indicativamente: max 7gg).

Ovunque possibile evita di creare attività che ne comprendono
più di una al loro interno. Ad esempio una Feature del tipo:

> Come CIT voglio visualizzare la lista completa dei miei metodi di pagamento (solo carte di credito),
> la lista delle opearazioni di pagamento associate a ciascun metodo,
> i dettagli di ciascuna operazione e una pagina statica di aiuto sul portafoglio

va necessariamente divisa in quattro attività differenti.

Altre _best practice_ nella pianificazione delle attività:

* crea sempre una issue corrispondente a ogni commento "TODO" o "FIXME" nel codice
* assegna sempre una epic alle issue (al limite: `epic-technical-debt`)
* imposta sempre eventuali issue bloccanti (_blockers_)
* crea sempre l'attività di granularità maggiore, completabile nel più breve tempo possibile
* ogni attività deve poter avere un criterio chiaro per poter essere considerata terminata
* non lasciare le issue aperte troppo a lungo

## Lista dei progetti su Pivotal Tracker

### Frontend - Pivotal Tracker

* [App mobile](https://www.pivotaltracker.com/n/projects/2048617)

### Backend - Pivotal Tracker

* [API backend](https://www.pivotaltracker.com/n/projects/2088623)
* [API proxy](https://www.pivotaltracker.com/n/projects/2116794)
* [PagoPA Proxy](https://www.pivotaltracker.com/n/projects/2161158)

### Backoffice - Pivotal Tracker

* [Admin backoffice](https://www.pivotaltracker.com/n/projects/2146891)
* [SAS backoffice](https://www.pivotaltracker.com/n/projects/2147268)
* [Developer portal](https://www.pivotaltracker.com/n/projects/2147248)

# Analisi e progettazione

## Google Drive (ITA)

Per analizzare le decisioni da intraprendere che hanno un impatto
sull'architettura del sistema o sull'organizzazione del software
utilizziamo l'editing collaborativo di documenti
(CDM - Cittadinanza Digitale Memos, in italiano)
tramite Google Drive:

[CDM](https://drive.google.com/drive/folders/1nmPZqEzH9aN_5qFJbd36vS3v7leUcJx0).

I task trasversali alle diverse attività quali logging, autenticazione, integrazioni tra componenti, etc.
vengono inizialmente schematizzati in uno specifico documento che viene condiviso con il resto del team.
Tutti i membri sono invitati a elaborare proposte e/o porre domande sugli aspetti meno definiti
tramite gli strumenti forniti da Google Docs.

Lo stesso meccanismo viene usato per attività di alto livello che non riguardano necessariamente
lo sviluppo del software; ad esempio: tutto ciò che concerne aspetti legati alla normativa
o all'interazione con soggetti pubblici.

Limitatamente alle decisioni che riguardano l'architettura,
queste vengono successivamente documentate (in inglese) in
[Architecture Decision Record](https://github.com/joelparkerhenderson/architecture_decision_record#architecture-decision-record-adr) (ADR):

[ADR](https://github.com/teamdigitale/io/tree/master/architecture/decisions).

# Comunicazione

## Slack

Per le comunicazioni sincrone utilizziamo Slack:  
[slack.developers.italia.it](https://slack.developers.italia.it/)

Sul canale `#io-devel` trovi i membri del team di sviluppo e
i maintainer dei sotto-progetti, oltre a coloro che si occupano
di aspetti non direttamente legati allo sviluppo
(_product management_, esperienza utente (_UX_), coordinamento).

Il canale `#io-pa` è invece dedicato al supporto per
fornitori e tecnici delle Pubbliche Amministrazioni
aderenti al servizio.

Alcune regole per le discussioni in chat:

* usa i [thread](https://get.slack.help/hc/en-us/articles/115000769927-Message-threads)
  per raggruppare messaggi afferenti uno stesso argomento o attività
* menziona i membri interessati ai messaggi utilizzando la sintassi `@<nome>`
* limita l'utilizzo di `@channel` solo a comunicazione particolamente urgenti

### Daily scrum: Howdy

Su Slack, gli sviluppatori e i maintainer dei singoli progetti
ricevono quotidianamente, alle 10:00 del mattino (GMT+1), alcuni messaggi privati
provenienti da un bot [Howdy](https://howdy.ai/): è obbligatorio rispondere
ai messaggi ogni giorno, anche in maniera sintentica, in modo
da comunicare al resto del team le attività svolte, ancora da svolgere
ed, eventualmente, se vi sono impedimenti bloccanti.

## Weekly meeting: Google Meet

I membri del team sono invitati a partecipare
ai Google Meet pianificati con cadenza settimanale:

* [App mobile, frontend e backend](https://meet.google.com/xdd-mryo-bfe): ogni martedi alle 10:15 (GMT+1)

Durante le conferenze vengono condivise le informazioni
con i maintaner di progetto in modo da pianificare
le attività per la settimana e prendere decisioni
sulle questioni ancora aperte.

# Sviluppo e rilascio del codice

Tutto il codice è pubblicato su [GitHub](http://github.com/teamdigitale).

L'ambiente cloud attualmente utilizzato
per il dispiegamento dell'infrastruttura è [Microsoft Azure](https://azure.com).
Nel repository principale sono presenti gli script [Terraform](https://terraform.io/docs/providers/azurerm/)
che permettono di replicare l'intera infrastruttura su un qualsiasi account Azure.

L'amministratore fornisce un account per accedere all'ambiente di test
ai membri del team che lavorano a una specifica componente.
L'account appartiene alla subscription Azure utilizzata per il progetto.

Nei README degli specifici progetti troverai le istruzioni da seguire
per poter predisporre un ambiente di sviluppo locale.

## Principi generali per lo sviluppo del codice

Ogni sotto-progetto ha le proprie "regole"
(definite nello corrispondente README) che variano
a seconda delle tecnologie e dei linguaggi impiegati.

Alcune buone pratiche da applicare durante la stesura del codice
risultano tuttavia trasversali ai diversi progetti:

* non utilizzare classi se non assolutamente necessario; tieni separati dati (strutture) e comportamenti (funzioni)
* utilizza sempre [tipi strutturati](https://github.com/gcanti/io-ts): non passare in input alle funzioni dati non strutturati
  (es. JSON o request.Express)
* utilizza [tagged types](https://blog.mariusschulz.com/2016/11/03/typescript-2-0-tagged-union-types) e
  [tipi algebrici](https://stackoverflow.com/questions/33915459/algebraic-data-types-in-typescript) al posto delle classi
* utilizza [discriminated unions](http://www.typescriptlang.org/docs/handbook/advanced-types.html#discriminated-unions) al posto 
  dell'ereditarietà
* privilegia strutture immutabili: usa `const` al posto di `let`, `map` / `filter` al posto dei cicli `for` o `while`,
  [spread operator](https://davidwalsh.name/merge-objects) al posto di assegnamenti diretti, etc.
* se usi le classi non fornire metodi _setter_: fa in modo che tutti i membri siano readonly
* privilegia l'utilizzo di [funzioni "pure"](https://medium.com/@jamesjefferyuk/javascript-what-are-pure-functions-4d4d5392d49c)
* utilizza [Option](https://tech.evojam.com/2016/02/22/practical-intro-to-monads-in-javascript/) ed evita i check
  su `null` / `undefined`
* per gestire gli errori ritorna degli [Either](https://tech.evojam.com/2016/03/21/practical-intro-to-monads-in-javascript-either/)
  al posto di lanciare Eccezioni
* utilizza le `Promise` al posto delle callback per il codice asincrono. limita l'utilizzo delle callback all'interazione con 
  librerie esistenti
* considera l'utilizzo di `async` / `await` al posto di `then` se può rendere il codice più leggibile

Per il codice Typescript utilizza:

* [italia-ts-commons](https://github.com/teamdigitale/io-ts-commons) per la definizione dei
  tipi personalizzati (NonEmptyString, DateFromString, EmailString, etc.)
* [io-ts](https://github.com/gcanti/io-ts) per la definizione dei tipi e la validazione a runtime
* [fp-ts](https://github.com/gcanti/fp-ts) per l'implementazione di
  [Option](https://github.com/gcanti/fp-ts/blob/master/docs/api/md/Option.md)
  ed [Either](https://github.com/gcanti/fp-ts/blob/master/docs/api/md/Either.md)

Se devi introdurre un nuovo tipo, controlla sempre che non sia già presente
in [italia-ts-commons](https://github.com/teamdigitale/io-ts-commons).

Per quanto riguarda le API, i tipi vengono estratti dallo schema JSON (OpenAPI) e convertiti
nella loro rappresentazione Typescript / io-ts tramite i tool forniti dal pacchetto
[italia-utils](https://github.com/teamdigitale/io-ts-commons).

Per la progettazione delle specifiche API (swagger / OpenAPI) ci ispiriamo alle  
[linee guida di Zalando per le scrittura di API](http://zalando.github.io/restful-api-guidelines/).

### Gestione degli errori tramite Either od Option

Alcune regole generali per la gestione degli errori:

* se una funzione può ritornare un valore `null` o `undefined`, il tipo di ritorno sarà una `Option`
* se una funzione può ritornare un errore, il tipo di ritorno sarà un `Either<ErrorType, ResultType>`
* se una funzione può ritornare un errore oppure un valore `null` o `undefined`,
  il tipo di ritorno sarà `Either<ErrorType, Option<ResultType>>`
* se la funzione è asincrona, il tipo di ritorno sarà una Promise di uno dei tre suddetti tipi

Per quanto riguarda il _naming_ delle variabili suggeriamo i seguenti pattern:

| Tipo del valore ritornato da f()        | Nome della costante                 |
| --------------------------------------- | ----------------------------------- |
| `Option<ResultType>`                    | `const maybeResult = f(...)`        |
| `Either<ErrorType, ResultType>`         | `const errorOrResult = f(...)`      |
| `Either<ErrorType, Option<ResultType>>` | `const errorOrMaybeResult = f(...)` |

dove `Result` va sostituito con un nome adeguato al contesto.

Puoi trovare un esempio di questi pattern nel codice di alcuni controller Express già implementati: https://github.com/teamdigitale/io-functions/blob/master/lib/controllers/messages.ts#L262

## Editor: linting e indentazione

Sei libero di utilizzare qualsiasi editor di testo.
Tuttavia, all'interno di alcuni repository, troverai delle configurazioni
per [Visual Studio Code](https://code.visualstudio.com/) (VSC).
VSC è un editor open source e possiede alcune caratteristiche
imprescindibili per lo sviluppo di questo progetto:

* un ottimo supporto per [Typescript](http://www.typescriptlang.org)
* un'efficace integrazione con [tslint](https://palantir.github.io/tslint/)
* il supporto all'indentazione _on-save_ tramite [prettier](https://github.com/prettier/prettier)

Se sei indeciso su quale editor usare, ti consigliamo pertanto
di provare [VSC](https://code.visualstudio.com/).

Prima di ogni PR, assicurati che tutto il codice Typescript (o Javascript)
sia indentato tramite [prettier](https://github.com/prettier/prettier).
La configurazione è contenuta nei file `.prettierrc` presenti nella
directory radice dei progetti. Se usi VSC, integra prettier nell'editor tramite la
[relativa estensione](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode).

## Qualità del codice

Per monitorare la qualità del codice usiamo alcuni tool
per i quali è stata predisposta l'integrazione automatica
al momento del rilascio su GitHub:

* [Codecov](https://codecov.io): percentuale di copertura degli unit test
* [Codacy](https://www.codacy.com/): qualità del codice
* [Codeclimate](https://codeclimate.com): manutenibilità del codice
* [Snyk](https://snyk.io): sicurezza delle dipendenze npm

Monitora sempre i report associati alle Pull Request
e attua le modifiche necessarie o suggerite dai tool
di monitoraggio.

## Test

Ogni funzionalità richiede la stesura di _unit test_ corrispondenti.

La _code coverage_ richiesta è alta (> 90%).
Puoi far riferimento ai test già contenuti nelle
directory `__tests__` esistenti per scriverne di nuovi.

I file contenenti gli unit test hanno il formato
`<file_sorgente>.test.<estensione>`, ad esempio [`errors.test.ts`](https://github.com/teamdigitale/io-functions/blob/master/lib/utils/__tests__/errors.test.ts)
e sono contenuti nelle directory `__tests__` presenti allo stesso livello dei sorgenti.

Gli unit test vengono eseguiti tramite [Jest](https://facebook.github.io/jest/),
sia durante lo sviluppo locale che durante le [build automatiche via CircleCI](#build-su-circleci).

## Rilascio del codice su GitHub

### Pull Request

Su GitHub scriviamo in inglese (issue, commenti, descrizioni delle Pull Request).

L'evoluzione dei componenti avviene integrando nuovo codice tramite
[Pull Request](https://help.github.com/articles/about-pull-requests/):

1.  scegli una issue su Pivotal Tracker e segnala come "Started"
1.  integra il tuo codice in un nuovo _branch_ chiamato `<id issue Pivotal>-<descrizione in inglese della issue>`
    ad esempio `123456-fix-api-response`
1.  includi sempre all'inizio della descrizione (in inglese) dei commit _e_ nei titoli delle Pull Request
    il numero di issue Pivotal corrispondente nel formato `[#<id issue>]`, es. `[#123456] fixed api response`
1.  quando sei a buon punto, anche se non hai terminato il lavoro, effettua una Pull Request in modo che
    gli altri membri del team possano visualizzare le tue integrazioni; includi un marcatore `WIP`
    (work in progress) nei titoli di queste PR es. `[#123456] WIP: fix api response`
1.  includi nelle PR una descrizione delle modifche introdotte, il perché sono necessarie
    e altri dettagli che aiutino i revisori a capire meglio la patch
1.  richiedi la _code review_ su GitHub di almeno uno tra i maintaner del componente e attendi
    eventuali commenti: affinchè il codice possa essere integrato è richiesta l'approvazione di almeno
    uno dei revisori
1.  scrivi _unit test_ per le funzionalità introdotte e assicurati che tutti i test passino
1.  quando hai terminato il lavoro e il codice è pronto per essere integrato, rimuovi il marcatore `WIP`
1.  effettua un [rebase](https://help.github.com/articles/about-git-rebase/)
    dei commit assicurandoti di incorporare le ultime modifiche sul master
1.  assicurati che il numero dei commit all'interno della PR non sia eccessivo e che ogni commit
    abbia una messaggio significativo
1.  controlla eventuali messaggi (warning) provenienti da [DangerJS](https://github.com/danger/danger-js)
    o da uno dei tool di monitoraggio della coverage e della qualità del software
1.  una volta incorporate le richieste di modifica da parte dei revisori, aspetta l'approvazione
    di almeno uno di loro (o risolvi eventuali altri richieste)
1.  la PR viene approvata ed integrata nel codice

#### Buone pratiche per le PR

1.  una PR corrisponde a una e una sola storia su Pivotal
1.  una PR implementa un'unica feature (o *chore*)
1.  se i primi due punti sono difficili da ottenere, considera di aggiungere storie e ripianificarle
1.  la probabilità che una PR venga rigettata è direttamente proporzionale alla complessità e lunghezza del codice che contiene
1.  quando effettui una PR scrivi una descrizione che aiuti i reviewer a tener traccia di *tutti* i cambiamenti
1.  aggiungi sempre dei commenti inline a tutto il codice che non è auto-esplicativo

### Code review

Se devi effettuare una review puoi far riferimento ai principi espressi in  
https://blog.digitalocean.com/how-to-conduct-effective-code-reviews/

Ad esempio:

> If you're nitpicking, explain your reasons for doing so.
> On our team, we often preface nit-picky comments with (`nit`)

### Build automatiche

I processi di monitoraggio della qualità del codice,
della _coverage_ e delle PR sono eseguiti tramite la piattaforma
[CircleCI](https://circleci.com/gh/teamdigitale)
nell'account del Team Digitale. Ogni progetto contiene
la configurazione delle build automatiche in una
directory `.circleci`.

I processi vengono eseguiti automaticamente per ogni Pull Request
(e successive push del codice sullo stesso branch)
solo se queste provengono da branch appartenenti
al repository principale dei progetti.
Ciò significa che i tool di monitoraggio non vengono
eseguiti in caso di PR provenienti da _fork_ del repository.

Per i controlli automatici delle "best practice"
da seguire durante le PR utilizziamo
[DangerJS](https://github.com/danger/danger-js).

Assicurati di controllare il report prodotto
da DangerJS e seguirne gli eventuali suggerimenti
prima di chiudere una issue.

# Maintainer

Se hai domande su uno specifico componente puoi contattare i maintainer su Slack o
menzionarli nelle issue su Pivotal Tracker (riceveranno una notifica automatica).

Trovi l'elenco dei maintainer nel file `AUTHORS.md`
contenuto nei repository di ogni progetto.

# Letture e riferimenti

* [Mostly adequate guide to Functional Programming (in javascript)](https://mostly-adequate.gitbooks.io/mostly-adequate-guide/)
* [The Two Pillars of JavaScript Part 1: How to Escape the 7th Circle of Hell](https://medium.com/javascript-scene/the-two-pillars-of-javascript-ee6f3281e7f3)
* [The Two Pillars of JavaScript Part 2: Functional Programming](https://medium.com/javascript-scene/the-two-pillars-of-javascript-pt-2-functional-programming-a63aa53a41a4)
* [A Functional Programmer’s Introduction
  to JavaScript](https://medium.com/javascript-scene/a-functional-programmers-introduction-to-javascript-composing-software-d670d14ede30)
* [Functional TypeScript: Either vs Validation](https://medium.com/@gcanti/functional-typescript-either-vs-validation-66c52f28ce1f)
* [Type-Driven Development with TypeScript](http://www.olioapps.com/blog/type-driven-development-with-typescript/)
* [Checking Types Against the Real World in TypeScript](http://www.olioapps.com/blog/checking-types-real-world-typescript/)
* [Union Types in Flow & Reason](https://blog.jez.io/union-types-flow-reason/)
