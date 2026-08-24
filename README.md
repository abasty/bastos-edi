# README BASTOS-EDI

## Documentation utilisateur

Ce document décrit l'installation de BASTOS-EDI, un environnement de
développement intégré pour BASTOS, qui s'exécute sur un ordinateur de bureau. Il
nécessite un navigateur web avec JavaScript activé pour sa partie interface
utilisateur, et Docker pour exécuter l'interpréteur BASTOS. La documentation
utilisateur de BASTOS-EDI est disponible en ligne sur [MANUEL
BASTOS-EDI](https://abasty.github.io/bastos-edi/).

BASTOS est un dialecte Basic pour terminaux Minitel. Les programmes BASTOS
développés dans cet EDI sont exécutables sans changement sur [Sonoff Basic
R2/R3/R4](https://github.com/abasty/minwifi-esp01). La documentation utilisateur
BASTOS est disponible en ligne sur [Documentation
BASTOS](https://abasty.github.io/minwifi-esp01/).

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

## Lancer BASTOS-EDI

### Lancer le backend BASTOS-EDI

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

### Lancer le frontend BASTOS-EDI

#### Mode fenêtré

Lancer simplement un navigateur sur `http://localhost:9000` (ou Ctrl+Click sur
l'URL visible dans la console après un `make start`).

#### Chrome/Chromium (Mode Application)

Mode application sans bordures :

```bash
$ chromium --app=http://localhost:9000 --start-fullscreen --new-window
```

Ou avec Google Chrome :

```bash
$ google-chrome --app=http://localhost:9000 --start-fullscreen --new-window
```

#### Firefox (Plein écran)

```bash
$ firefox --kiosk http://localhost:9000
```

### Arrêter le backend BASTOS-EDI

```bash
$ make stop
Stopping BASTOS-EDI backend
[+] down 1/1
 ✔ Container bastos-edi Removed
 ✓ Container stopped
```
