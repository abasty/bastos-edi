# Remarques préliminaires

- Docker doit être installé et doit pouvoir exécuter des conteneurs Linux. Le
  _launcher_ BASTOS-EDI utilise `docker compose`
- Uniquement testé sur Debian 13.3. L'image Docker `bastos-edi` est basée sur
  `debian:13-slim`
- Le simulateur BASTOS sur x86 ne supporte pas encore les connexions FTP.
- Lire `MANUAL.md` pour utiliser BASTOS-EDI
- Pas de documentation BASTOS pour l'instant, il faut lire les exemples :)
- Le module BASTOS sur esp32 est entièrement compatible avec l'émulateur. Il
  supporte les connexions FTP et WebSockets

# Installer BASTOS-EDI (image Docker)

```bash
$ mkdir bastos
$ cd bastos
$ mkdir disk
$ docker run -d --rm --name bastos-init abasty/bastos-edi:latest
$ docker cp bastos-init:/opt/host/Makefile .
$ docker cp bastos-init:/opt/host/docker-compose.yml .
$ docker cp bastos-init:/opt/host/MANUAL.md .
$ docker cp bastos-init:/opt/host/disk.tgz .
$ docker stop -t1 bastos-init
$ tar zxvf disk.tgz
$ rm disk.tgz
```

# Lancer le backend BASTOS-EDI

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
bastos-edi  | 🌐 Press Ctrl+C to stop the server
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

# Lancer le frontend BASTOS-EDI

## Mode fenêtré

Lancer simplement un navigateur sur `http://localhost:9000` (ou Ctrl+Click sur
l'URL visible dans la console après un `make start`).

## Chrome/Chromium (Mode Application)

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

# Tips pour l'émulateur BASTOS-EDI

- Le mot de passe des réseaux émulés Wi-Fi est `changeme`
- Le simulateur BASTOS sur x86 ne supporte pas encore les connexions FTP
- Pour sortir d'un programme BASTOS en exécution ou du mode connecté, **appuyer 2
  fois sur la touche ESC** (Emprunté aux Amstrad CPC)
- Si on est bloqué dans l'émulateur ou si on n'arrive pas à reprendre la main,
  il suffit de recharger la page avec Shift+F5
- Pour que les commandes "Exécuter" fonctionnent correctement (Tabs Fichiers et
  Programme), il faut que, dans l'émulateur, on soit sorti du mode exécution ou
  connecté (appuyer 2 fois sur ESC si ce n'est pas le cas)
- Annulation est Ctrl+A, les raccourcis sont visibles dans la partie
  configuration de l'émulateur
