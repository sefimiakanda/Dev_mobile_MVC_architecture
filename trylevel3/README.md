# Application d'émissions de streaming

Application Flutter affichant une grille d'émissions, une recherche, des favoris et une fiche détaillée avec animation Hero.

## Exécuter

Depuis le dossier `trylevel3` :

```bash
flutter pub get
flutter run
```

## Tester

```bash
flutter test
```

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