-- Tests unitaires pour le modèle business_categorie

-- Test 1: Non-nullabilité sur les colonnes clés
select 'test_not_null' as test_name, *
from {{ ref('business_categorie') }}
where "Period" is null
   or classification is null

union all

-- Test 2: Valeurs acceptées pour la colonne classification
select 'test_classification_values' as test_name, *
from {{ ref('business_categorie') }}
where classification not in ('nouveau', 'ancien')

union all

-- Test 3: Logique de classification correcte
select 'test_classification_logic' as test_name, *
from {{ ref('business_categorie') }}
where ("Period" > 2013 and classification != 'nouveau')
   or ("Period" <= 2013 and classification != 'ancien')

union all

-- Test 4: Valeurs de Period positives et raisonnables
select 'test_period_positive' as test_name, *
from {{ ref('business_categorie') }}
where "Period" <= 0
   or "Period" > year(current_date())
