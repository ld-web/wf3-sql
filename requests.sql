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
-- On peut également trier les résultats sur plusieurs niveaux (ou plusieurs colonnes)
SELECT *
FROM rayon
WHERE capacite IS NOT NULL
ORDER BY capacite DESC,
  id DESC;