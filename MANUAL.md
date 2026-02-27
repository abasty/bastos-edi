# MANUEL BASTOS-EDI

## Fonctionnalités générales

BASTOS-EDI est un éditeur BASIC orienté Minitel, conçu pour écrire, tester et exécuter des programmes BASTOS dans un environnement web. Les points principaux :

- Éditeur de code avec coloration syntaxique BASTOS
- Barre d'outils avec recherche, formatage, thèmes et préférences
- Gestion de fichiers (chargement, sauvegarde, suppression)
- Exécution directe via un serveur local
- Visionneuse Minitel avec clavier intégré

## Manuel utilisateur

### Onglet Minitel

Cet onglet affiche un Minitel virtuel avec son clavier. Il sert à visualiser l'exécution des programmes et à interagir comme sur un vrai terminal.

Fonctions :
- Affichage du Minitel (écran)
- Clavier Minitel intégré

### Onglet Fichiers

Cet onglet permet de gérer les fichiers BASIC dans le dossier de travail.

Fonctions :
- Liste des fichiers
- Chargement d'un fichier dans l'éditeur
- Suppression d'un fichier
- Exécution d'un fichier

### Onglet Programme

C'est l'éditeur principal. Vous y écrivez, modifiez et lancez vos programmes BASIC.

Fonctions principales :
- Édition du code
- Coloration syntaxique BASTOS
- Recherche et remplacement
- Formatage (mots clés en majuscules, variables en minuscules)
- Affichage des numéros de ligne
- Retour à la ligne automatique
- Thème clair ou sombre
- Choix de police

#### Barre d'outils (toolbar)

La barre d'outils contient des boutons pour les actions courantes :

- Sélecteur de langage (Bastos / texte brut)
- Annuler / Rétablir
- Rechercher / Remplacer
- Basculer thème clair ou sombre
- Basculer police (Minitel / monospace)
- Taille de police (A- / A+)
- Formater le code (mots-clés en majuscules, variables en minuscules)
- Renuméroter les lignes sélectionnées
- Numéros de ligne
- Retour ligne

#### Barre du bas (bottombar)

Cette barre permet de gérer les fichiers courants et l'exécution :

- Nouveau programme
- Envoyer / sauvegarder
- Exécuter
- Nom du fichier actif
- État (modifié, envoyé, etc.)

#### Renumérotation des lignes

La fonction de renumérotation permet de renumériser les numéros de ligne d'un programme BASIC.

**Fonctionnement :**
- Sélectionnez les lignes à renuméroter
- Cliquez sur le bouton de renumérotation : une boîte de dialogue s'ouvre systématiquement
- Le champ **Premier numéro** est prérempli avec le numéro de la première ligne numérotée de la sélection
- Le champ **Incrément** est prérempli à `10` (modifiable)
- Validez pour appliquer la renumérotation, ou annulez pour ne rien changer
- Si la sélection ne contient aucune ligne numérotée, la boîte de dialogue indique que la renumérotation est impossible
- Tous les numéros de ligne sélectionnés sont recalculés selon les valeurs saisies
- Les lignes sans numéro sont ignorées
- Les références `GOTO`, `GOSUB` et `THEN` sont automatiquement mises à jour dans **tout le document**

**Exemple :**
```
Avant :
10 PRINT "Début"
20 GOTO 50
30 PRINT "Milieu"
50 PRINT "Fin"

Sélection : lignes avec numéros 10, 20, 30, 50
Dans la boîte de dialogue : Premier numéro = 100, Incrément = 10

Après :
100 PRINT "Début"
110 GOTO 150
120 PRINT "Milieu"
150 PRINT "Fin"
```

## Conseils d'usage

- Utilisez le formatage pour normaliser la casse des mots clés.
- Sauvegardez régulièrement avant exécution (Ctrl+S).
- Le thème sombre est recommandé pour un usage prolongé.
