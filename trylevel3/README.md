
Structure des dossiers du projet ( version MVC)

lib/
│
├── models/
│   ├── emission.dart
│   └── diffusion.dart
│
├── views/
│   ├── home_page.dart
│   ├── grille_emissions.dart
│   ├── carte_emission.dart
│   └── detail_page.dart
│
├── controllers/
│   └── emission_controller.dart
│
└── main.dart

# Application d'Émissions de Streaming - Architecture MVC

## 1. Répartition des responsabilités (Modèle, Vue, Contrôleur)

Cette application a été rigoureusement structurée selon le modèle architectural **MVC** afin de séparer les préoccupations :

* **Modèle (Model) - Dossier `models/` :** 
  * Contient les structures de données pures (`Emission` et `Diffusion`).
  * Ne contient **aucune** dépendance vers le framework Flutter (pas de widgets, pas de `BuildContext`).
* **Vue (View) - Dossier `views/` :** 
  * Rassemble tous les éléments visuels de l'interface utilisateur (`HomePage`, `GrilleEmissions`, `CarteEmission`, `DetailPage`).
  * Les vues ne contiennent aucune logique métier lourde et se contentent d'afficher les données fournies par le contrôleur ou les paramètres du constructeur.
* **Contrôleur (Controller) - Dossier `controllers/` :** 
  * Fait la liaison entre le modèle et la vue via la classe `EmissionController`.
  * Gère l'initialisation et le chargement des données mockées (`loadEmissions`) et notifie les écouteurs en cas de modification.

## 2. Comment exécuter et tester l'application

1. **Prérequis :** Assurez-vous d'avoir installé le SDK Flutter et un émulateur fonctionnel (Android/iOS) ou VS Code configuré.
2. **Dépendances :** Ouvrez un terminal à la racine du projet et ajoutez le package de grille réactive :
   ```bash
   flutter pub add responsive_grid