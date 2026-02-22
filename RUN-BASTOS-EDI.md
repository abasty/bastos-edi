# Lancer le backend BASTOS-EDI

## Créer le contexte

À ne faire que la première fois pour initialiser le contexte de lancement du
conteneur `bastos-edi`.

```
$ mkdir bastos
$ cd bastos
$ mkdir disk
$ docker run -d --rm --name bastos-init bastos-edi:latest
$ docker cp bastos-init:/opt/host/Makefile .
$ docker cp bastos-init:/opt/host/docker-compose.yml .
$ docker stop -t1 bastos-init
```

## Lancer l'image BASTOS-EDI

Depuis le répertoire créé la première fois (`bastos` dans cet exemple) :

```
$ make run
```

Pour arrêter le _backend_ :

```
$ make stop
```

# Lancer le frontend BASTOS-EDI

## Chrome/Chromium (Mode Application)

Mode application sans bordures :

```bash
chromium --app=http://localhost:9000 --start-fullscreen --new-window
```

Ou avec Google Chrome :

```bash
google-chrome --app=http://localhost:9000 --start-fullscreen --new-window
```

## Firefox (Plein écran)

```bash
firefox --kiosk http://localhost:9000
```
