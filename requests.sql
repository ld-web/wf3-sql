-- Création de table : requête DDL CREATE TABLE
-- nom du champ, type, NULL ou NOT NULL, etc...
-- NULL signifie que la colonne pourra recevoir la valeur NULL
-- Toutes les requêtes SQL se terminent par un ';'
CREATE TABLE rayon (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(255) NOT NULL,
  emplacement VARCHAR(255) NOT NULL,
  capacite INT NULL
) ENGINE = INNODB;
--
--
-- Insertion d'un élément dans la table rayon
-- On énumère après le nom de la table les colonnes pour lesquelles on
-- va fournir une valeur
-- Guillemets simples ou doubles pour des chaînes de caractères
INSERT INTO rayon (nom, emplacement, capacite)
VALUES ('Livres', 'Culture', 500);
--
--
-- Insertion de plusieurs éléments en une seule requête
INSERT INTO rayon (nom, emplacement, capacite)
VALUES ('DVD', 'Divertissement', 250),
  ('Jardin', 'Maison', 75),
  ('Boucherie', 'Traiteur', 150),
  ('Pizza', 'Surgelés', 50),
  ('Haricots', 'Conserves', 100);
--
--
-- Insertion sans préciser un champ nullable : une valeur NULL est appliquée par défaut
INSERT INTO rayon (nom, emplacement)
VALUES ('CD', 'Culture');
--
--
-- On peut omettre un champ non nullable, à condition qu'il ait une valeur par défaut
INSERT INTO rayon (nom)
VALUES ('Légumes');
--
--
-- SELECT [colonnes] FROM [table]
-- '*' est un alias pour sélectionner toutes les colonnes de la table.
-- Par défaut, si aucun filtre n'est indiqué, le serveur va renvoyer toutes les lignes. Donc l'ensemble de départ d'une requête SELECT représente toutes les lignes de la table.
SELECT *
FROM rayon;
--
--
-- sélectionner une ou plusieurs colonnes
SELECT nom
FROM rayon;
SELECT nom,
  emplacement,
  capacite
FROM rayon;
--
--
-- On peut demander à MySQL de retourner les valeurs distinctes d'une colonne
SELECT DISTINCT nom
FROM rayon;
--
--
-- Filtre WHERE sur une requête : on va réduire l'ensemble de départ, selon une ou plusieurs conditions
SELECT id,
  nom,
  emplacement
FROM rayon
WHERE capacite = 50;
--
SELECT id,
  nom,
  emplacement
FROM rayon
WHERE capacite < 50
  OR capacite > 250;
-- pour les valeurs NULL, on va utiliser IS NULL ou IS NOT NULL
SELECT *
FROM rayon
WHERE capacite IS NOT NULL;
-- Pour chercher dans une chaîne de caractères, on peut utiliser l'opérateur LIKE
-- Le caractère '%' agit comme "n'importe quelle chaîne" avant ou après l'extrait de chaîne recherché
SELECT *
FROM rayon
WHERE nom LIKE "%ri%";
--
--
-- Tri des résultats avec le mot-clé ORDER BY
-- On peut trier les résultats par ordre croissant (par défaut) ou décroissant
-- Pour trier par ordre croissant, on utilisera ASC (pour ordre ASCendant)
-- Pour trier par ordre décroissant, on utilisera DESC (pour ordre DESCendant)
-- On peut également trier les résultats sur plusieurs niveaux (ou plusieurs colonnes), dans ce cas, séparer les colonnes par des virgules
SELECT id,
  nom,
  capacite
FROM rayon
WHERE capacite IS NOT NULL
ORDER BY capacite DESC,
  id DESC;
--
--
-- Pour limiter le nombre de résultats, utiliser LIMIT
SELECT *
FROM rayon
ORDER BY nom
LIMIT 3;
-- Si je veux le nom et la capacité des 3 premiers rayons dont le nom commence par "B", triés par ordre alphabétique
-- OFFSET permet de commencer la sélection de X résultats à partir d'un certain endroit.
-- Ici par exemple, j'ai 4 enregistrements qui commencent par "T".
-- Je souhaite limiter mon nombre d'enregistrements à 3.
-- Mes offsets commencent à 0, ainsi, je peux décider de renvoyer les 3 premiers résultats, ou bien les 3 premiers en partant du second, du troisième, etc...
-- Souvent utilisé pour implémenter un système de pagination
SELECT nom,
  capacite
FROM rayon
WHERE nom LIKE "T%"
ORDER BY nom
LIMIT 3 OFFSET 2;
--
-- Exercices :
-- Afficher les noms des rayons ayant une capacité NULL par ordre alphabétique
SELECT nom
FROM rayon
WHERE capacite IS NULL
ORDER BY nom ASC;
-- Afficher les noms, emplacements et les capacités des rayons dont le nom finit par "s", par capacité décroissante
SELECT nom,
  emplacement,
  capacite
FROM rayon
WHERE nom LIKE "%s"
  AND capacite IS NOT NULL
ORDER BY capacite DESC;
--
--
-- On peut utiliser des fonctions dans notre SELECT
-- pour récupérer directement des valeurs "calculées"
-- Valeur max
SELECT MAX(capacite),
  -- valeur minimale
  MIN(capacite),
  -- Somme
  SUM(capacite),
  -- Moyenne
  AVG(capacite)
FROM rayon;
--
-- Afficher le nom et l'emplacement du rayon ayant la capacité maximale
-- Utilisation d'une sous-requête : on veut les informations
-- du rayon dont la capacité est égale au maximum des capacités de mes rayons.
-- Pour avoir le maximum des capacités de rayons, que je ne peux connaître à l'avance, je dois lancer une sous-requête pour récupérer la valeur
SELECT nom,
  emplacement,
  capacite
FROM rayon
WHERE capacite = (
    SELECT MAX(capacite)
    FROM rayon
  );