# Il s’agit d’un flux de travail de base pour vous aider à démarrer avec actions

nom: CI

# Contrôle quand l’action s’exécute. Déclenche le flux de travail sur la demande push ou pull
# événements, mais seulement pour la branche principale
sur:
  pousser:
    branches: [ principal ]
  pull_request:
    branches: [ principal ]

# Une exécution de flux de travail est composée d’un ou de plusieurs tâches qui peuvent s’exécuter séquentiellement ou en parallèle
emplois:
  # Ce flux de travail contient un seul travail appelé « build »
  construire:
    # Le type de coureur sur lequelle le travail se déroulera
    runs-on: ubuntu-latest

    # Les étapes représentent une séquence de tâches qui seront exécutées dans le cadre du travail
    étapes:
      # Vérifiez votre référentiel sous $GITHUB_WORKSPACE, afin que votre travail puisse y accéder
      - utilisations: actions/checkout@v2

      # Exécute une seule commande à l’aide de l’environnement de ligne de commande des coureurs
      - nom: Exécuter un script d’une ligne
        courir: echo Bonjour, monde !

      # Exécute un ensemble de commandes à l’aide de l’enveloppe des coureurs
      - nom: Exécuter un script multi-lignes
        exécuter: |
 écho Ajouter d’autres actions à construire,
 test d’écho et déployez votre projet.
