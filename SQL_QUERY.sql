select * from departement;
select * from villes_france_free; 

-- la liste des 10 villes les plus peuplées en 2012

Select ville_nom, ville_population_2012 
from villes_france_free 
ORDER BY ville_population_2012 desc
Limit (10);


-- la liste des 50 villes ayant la plus faible superficie

Select ville_nom, ville_surface 
from villes_france_free
order by ville_surface asc 
limit 50; 

-- la liste des départements d’outres-mer, c’est-à-dire ceux dont le numéro de département commencent par “97”

Select * 
from departement 
where departement_code LIKE '97%';

-- le nom des 10 villes les plus peuplées en 2012, ainsi que le nom du département associé

Select *
from villes_france_free left join  departement 
on  villes_france_free.ville_departement = departement.departement_code
order by ville_population_2012 desc
limit 10;

-- la liste du nom de chaque département, associé à son code et du nombre de commune au sein de ces département, en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes

Select departement_nom,  ville_departement, count(*) as `nbr_items` 
from villes_france_free left join  departement 
on  villes_france_free.ville_departement = departement.departement_code
GROUP BY ville_departement
ORDER BY `nbr_items` DESC;

-- Obtenir la liste des 10 plus grands départements, en terme de superficie

Select departement_nom, ville_departement, SUM(ville_surface) As  Surface_departement 
from `villes_france_free` 
LEFT JOIN departement ON departement_code = ville_departement
Group by departement_nom 
order by Surface_departement;

-- le nombre de villes dont le nom commence par “Saint”

Select count(ville_nom) 
from `villes_france_free`
where ville_nom like 'Saint%';

-- Obtenir la liste des villes qui ont un nom existants plusieurs fois, et trier afin d’obtenir en premier celles dont le nom est le plus souvent utilisé par plusieurs communes

Select ville_nom, count(*) as nbre_items 
from `villes_france_free`
group by ville_nom
order by nbre_items desc;

-- Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieur à la superficie moyenne

Select * from `villes_france_free` where ville_surface > ( Select avg(ville_surface)  from `villes_france_free`);


-- Obtenir la liste des départements qui possèdent plus de 2 millions d’habitant

Select ville_departement, sum('ville_population_2012') as somme_habitants 
from 'villes_france_free' 
Group by 'ville_departement'
Having somme_habitants > 200000
Order by somme_habitants desc;

-- Remplacer les tirets par un espace vide, pour toutes les villes commençant par “SAINT-”

UPDATE villes_france_free 
SET ville_nom = REPLACE(ville_nom, '-', ' ') 
WHERE `ville_nom` LIKE 'SAINT-%';







