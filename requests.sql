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
-- IN avec une clause WHERE, peut permettre de chercher par une énumération de valeurs
SELECT *
FROM rayon
WHERE id IN (6, 26, 8, 150);
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
--
--
-- COUNT permet de compter le nombre de lignes dans la table
-- On peut y associer une clause WHERE pour compter le nombre de lignes
-- correspondant à un certain critère (ou une certaine condition)
SELECT COUNT(*)
FROM rayon;
--
--
-- On peut utiliser le mot-clé 'AS' pour appliquer un alias sur la colonne demandée
-- Le serveur utilise donc cet alias en tant que libellé d'en-tête
-- Les alias sont optionnels, on peut en définir sur 0, 1 ou plusieurs colonnes de manière indépendante
SELECT MAX(capacite) AS 'max',
  -- valeur minimale
  MIN(capacite) AS 'min',
  -- Somme
  SUM(capacite) AS 'somme',
  -- Moyenne
  AVG(capacite) AS 'moyenne'
FROM rayon;
--
--
-- Agrégation de résultats :
-- Avec la clause GROUP BY, on va agréger (ou assembler, ou regrouper) des résultats
-- afin de pouvoir effectuer des calculs dessus
-- Ce regroupement va s'effectuer selon une donnée précise
-- Ci-dessous : l'emplacement.
-- Ainsi, dans l'exemple ci-dessous, le fait d'agréger les résultats par emplacement
-- nous permet de calculer la moyenne des capacités par emplacement
SELECT emplacement,
  ROUND(AVG(capacite), 2) AS 'moyenne'
FROM rayon
GROUP BY emplacement;
--
--
-- Pour supprimer une table
DROP TABLE test;
--
--
-- Création table produit avec création de la clé étrangère directement dans la directive CREATE TABLE
CREATE TABLE produit (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(255) NOT NULL,
  prix_ht DECIMAL(10, 2) NOT NULL,
  content_desc TEXT,
  illustration VARCHAR(255),
  quantite INT NOT NULL,
  rayon_id INT,
  FOREIGN KEY (rayon_id) REFERENCES rayon(id)
) ENGINE = INNODB;
--
--
-- DELETE permet d'effacer une ou plusieurs lignes
-- ATTENTION : sa forme ressemble à SELECT
-- Mais il n'est pas nécessaire de préciser de colonnes
-- En effet, si on est en train d'effacer des lignes, on ne va pas se poser la question des colonnes de ces lignes
-- La commande de base agirait donc sur l'ensemble de la table
-- (DELETE FROM table)
-- On peut ensuite y ajouter une clause WHERE pour réduire l'ensemble concerné
-- et donc supprimer quelques lignes bien ciblées
DELETE FROM rayon
WHERE emplacement = "Pâtisserie";
--
--
-- Création d'un rayon Pâtisserie
INSERT INTO rayon (nom, emplacement, capacite)
VALUES ("Pâtisserie", "Rez-de-chaussée", 400);
--
--
-- JOINTURE : à partir d'un ensemble donné, ici la table produit,
-- on va joindre un second ensemble, ici rayon.
-- La directive INNER JOIN signifie que l'on conservera les résultats se trouvant à l'intersection des deux ensembles.
-- Le mot-clé ON, lui, permet de préciser ce qu'on appelle le critère de jointure.
-- Avec ON, on indique à MySQL sur quel critère joindre un produit et un rayon.
-- Donc, sur quel critère faire basculer un résultat dans l'intersection des deux ensembles.
SELECT produit.nom,
  produit.prix_ht,
  rayon.nom
FROM produit
  INNER JOIN rayon ON produit.rayon_id = rayon.id;
--
--
-- LEFT JOIN, lui, à la différence de INNER JOIN, va conserver tous les éléments de l'ensemble de gauche.
-- Dans le cas ci-dessous, on va donc retrouver tous les produits, c'est-à-dire même ceux qui n'ont pas de rayon associé
SELECT produit.nom,
  produit.prix_ht,
  rayon.nom
FROM produit
  LEFT JOIN rayon ON produit.rayon_id = rayon.id;
--
-- Combien de produits pour un rayon donné ?
SELECT rayon.nom,
  COUNT(produit.id) AS "nombre de produits"
FROM rayon
  LEFT JOIN produit ON rayon.id = produit.rayon_id
WHERE rayon.id = 6;
--
-- Afficher le nombre de produits par rayon : afficher le nom du rayon et son nombre de produits
SELECT rayon.nom,
  COUNT(produit.id) AS "Nombre"
FROM rayon
  LEFT JOIN produit ON rayon.id = produit.rayon_id
GROUP BY rayon.id;
--
-- Afficher le nom et le nombre de produits des rayons non vides, par ordre alphabétique
--
-- Utilisation de HAVING pour ajouter une condition sur l'agrégat.
-- Ici, j'agrège les résultats par ID de rayon, puis
-- je ne conserve que les rayons ayant un nombre de produits correspondants suppérieur à 0
SELECT rayon.nom,
  COUNT(produit.id) AS "Nombre"
FROM rayon
  LEFT JOIN produit ON rayon.id = produit.rayon_id
GROUP BY rayon.id
HAVING COUNT(produit.id) > 0
ORDER BY rayon.nom;
-- Autre solution : probablement la meilleure dans ce cas-là
-- Parce que dans ce cas-là, on utilise directement INNER JOIN
-- qui va exclure les rayons n'ayant pas de produit correspondant
-- On n'a donc pas besoin de faire un LEFT JOIN pour inclure
-- les rayons n'ayant pas de produits, et ensuite les exclure via un HAVING par exemple. Ce serait inutile
SELECT rayon.nom,
  COUNT(produit.id) AS "Nombre"
FROM rayon
  INNER JOIN produit ON rayon.id = produit.rayon_id
GROUP BY rayon.id
ORDER BY rayon.nom;
-- Autre solution, dans la veine de la première.
-- On conserve notre LEFT JOIN puis on exclut les rayons n'ayant pas de produits
-- cette fois-ci en reproduisant un INNER JOIN avec produit.id IS NOT NULL
SELECT rayon.nom,
  COUNT(produit.id) AS "Nombre"
FROM rayon
  LEFT JOIN produit ON rayon.id = produit.rayon_id
WHERE produit.id IS NOT NULL
GROUP BY rayon.id
ORDER BY rayon.nom;