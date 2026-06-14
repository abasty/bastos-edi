# README BASTOS-EDI

Ce document décrit l'installation de BASTOS-EDI, un environnement de
développement intégré pour BASTOS, qui s'exécute sur un ordinateur de bureau. Il
nécessite un navigateur web avec JavaScript activé pour sa partie interface
utilisateur, et Docker pour exécuter l'interpréteur BASTOS.

BASTOS est un dialecte Basic pour terminaux Minitel. Les programmes BASTOS
développés dans cet EDI sont exécutables sans changement sur [Sonoff Basic
R2/R3/R4](https://github.com/abasty/minwifi-esp01/tree/master).

- Lire [MANUEL
  BASTOS-EDI](https://github.com/abasty/bastos-edi/blob/master/MANUAL.md) pour
  utiliser BASTOS-EDI
- Lire [QUICK-START
  BASTOS](https://github.com/abasty/minwifi-esp01/blob/master/doc/BASTOS-QUICK-START-fr.md)
  pour faire les premiers pas en BASTOS, télécharger et exécuter un jeu
- Lire [MANUEL
  BASTOS](https://github.com/abasty/minwifi-esp01/blob/master/doc/BASTOS-MANUAL-fr.md)
  pour écrire ses propres programmes en BASTOS

## Installer BASTOS-EDI (image Docker)

- Docker doit être installé et doit pouvoir exécuter des conteneurs Linux. Le
  _launcher_ BASTOS-EDI utilise `docker compose`
- Uniquement testé sur Debian 13.3. L'image Docker `bastos-edi` est basée sur
  `debian:13-slim`

```bash
$ mkdir bastos
$ cd bastos
$ docker run -d --rm --name bastos-init abasty/bastos-edi:latest
$ docker cp bastos-init:/opt/host/Makefile .
$ docker cp bastos-init:/opt/host/docker-compose.yml .
$ docker stop -t1 bastos-init
```

## Lancer le backend BASTOS-EDI

Pour démarrer le _backend_ :

```bash
$ make start
Starting BASTOS-EDI backend
[+] up 1/1
 ✔ Container bastos-edi Created
bastos-edi  | Starting vsftpd...
bastos-edi  | Starting BASTOS-EDI server...
bastos-edi  | 🚀 BASTOS-EDI Server started on http://localhost:9000
bastos-edi  | 📁 Disk folder: /app/disk
✓ Container started
```

Pour arrêter le _backend_ :

```bash
$ make stop
Stopping BASTOS-EDI backend
[+] down 1/1
 ✔ Container bastos-edi Removed
 ✓ Container stopped
```

## Lancer le frontend BASTOS-EDI

### Mode fenêtré

Lancer simplement un navigateur sur `http://localhost:9000` (ou Ctrl+Click sur
l'URL visible dans la console après un `make start`).

### Chrome/Chromium (Mode Application)

Mode application sans bordures :

```bash
$ chromium --app=http://localhost:9000 --start-fullscreen --new-window
```

Ou avec Google Chrome :

```bash
$ google-chrome --app=http://localhost:9000 --start-fullscreen --new-window
```

## Firefox (Plein écran)

```bash
$ firefox --kiosk http://localhost:9000
```

## Tips pour l'émulateur BASTOS-EDI

- Le mot de passe des réseaux émulés Wi-Fi est `changeme`
- Pour sortir d'un programme BASTOS en exécution ou du mode connecté, **appuyer 2
  fois sur la touche ESC** (Emprunté aux Amstrad CPC)
- Si on est bloqué dans l'émulateur ou si on n'arrive pas à reprendre la main,
  il suffit de recharger la page avec Shift+F5
- Pour que les commandes "Exécuter" fonctionnent correctement (Tabs Fichiers et
  Programme), il faut que, dans l'émulateur, on soit sorti du mode exécution ou
  connecté (appuyer 2 fois sur ESC si ce n'est pas le cas)
- Annulation est Ctrl+A, les raccourcis sont visibles dans la partie
  configuration de l'émulateur
