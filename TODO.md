# BASTOS-EDI

## Principe

* Un conteneur Docker contient toutes les fonctions principales pour l'édition
  de programmes BASTOS
* On édite des scripts ou programme BASTOS sur son PC host et on les sauve sur
  le disque partagé BASTOS entre host et conteneur
* On accède à un émulateur depuis un navigateur sur le PC hôte par une URL
  mappée sur un service du conteneur (genre "localhost:1967") => l'émulateur
  minitel servi par le conteneur se connecte sur une websocket locale au
  conteneur qui sert BASTOS

## Docker émulateur BASTOS

* [x] BASTOS-WS servi sur websocket (voir avec websocat ou websockets) en local
  sur le docker : `websocat -t -E --no-line ws-l:127.0.0.1:1967 exec:bastos`
* [x] Serveur web qui sert minterm-web ou l'emulateur de MiEdit, qui se connecte
  sur BASTOS-WS
* [ ] ATTENTION : Certaines touches ne marchenet pas : Ctrl+Enter (as CLS), DEL
  (as Correction), ESC-ESC pour **break**, flêches clavier, ctrl+G est pris par
  l'UI, Ctrl+A selctionne tout, Cx/Fin agit bizarrement, autres ?
* emuljs, basé sur MiEdit, pourrait intégrer un éditeur de basic
  <https://ace.c9.io/> et MiEdit lui-meme (avec conversion vers code ou variable
  BASTOS)
* Connexion au réseau (pour emul WIFI et commande MINITEL)
* Il faut aussi pouvoir servir un émulateur web qui se connecte à BASTOS par
* Un répertoire partagé pour le disque BASTOS websocket
* Au démarrage de docker on lance le service web qui sert minterm et le service
  BASTOS en websocket

## Machine hôte

* Le disque partagé est aussi servi par ftp sur la machine hôte afin qu'un
  device BASTOS physique puisse s'y connecter. L'autre solution est de fournir
  ce service sur un FTP distant (voir synchro de FTP avec disque partagé BASTOS)

## Alternative à MiEdit : Minterm BASTOS

* Au lancement on se connecte sur BASTOS-WS
* une option pour charger un programme (qui fait un "RUN"),
* un bouton pour recharger le programme
* un buton pour "reset court" et un pour "reset long"

# WebSocket client : intégré à BASTOS

* web sockets client sur TCP en C (Arduino framework)
* définition API client : à partir du HAL Bastos
* Négo connexion client (GET), serveur (101 Switching ...)
* mode client asynchrone basée sur "loop", ping pong, read frame, write frame

# WebSocket serveur : intégré à serveur Minitel

* web sockets serveur sur TCP en Rust
* serveur hybride TCP/Websocket multi-client en Rust
* Mode TCP ou Websocket basé sur l'analyse du flux entrant
* support du mode websockets serveur
* définition modèle minitel : exemple mode rouleau, ou jeu, avec connaissance
  partagée
* Penser à un mode Upload (par exemple pour échanger des programmes Bastos)
* base de données : Turso / Limbo
* Réponse au GET
* Rust benchmark IO asynchrones : <https://github.com/jkarneges/rust-async-bench>

# BASTOS sur websocat

```
wget -qO websocat https://github.com/vi/websocat/releases/latest/download/websocat.x86_64-unknown-linux-musl
```
