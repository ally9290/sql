SELECT spriden_pidm,
  spriden_id,
  trim(spriden_first_name
  || ' '
  ||
  CASE
    WHEN spriden_mi IS NULL
    THEN NULL
    ELSE spriden_mi
      || ' '
  END
  || spriden_last_name) spriden_name,
  stvcoll_desc apbcons_coll_code_pref,
  apbcons_pref_clas,
  apbcons_activity_date,
  (SELECT listagg(apradeg_degc_code
    || ' ('
    || TO_CHAR(apradeg_date, 'MM/yyyy')
    || ')', ', ') within GROUP(
  ORDER BY apradeg_date)
  FROM apradeg
  WHERE apradeg_pidm      = apbcons_pidm
    AND apradeg_sbgi_code = '003918'
  ) degree_dates
FROM apbcons
LEFT OUTER JOIN stvcoll
ON stvcoll_code = apbcons_coll_code_pref,
  spriden
WHERE spriden_pidm        = apbcons_pidm
  AND spriden_change_ind IS NULL
  AND NOT EXISTS
  (SELECT 1
  FROM apradeg
  WHERE apradeg_sbgi_code             = '003918'
    AND apradeg_pidm                  = apbcons_pidm
    AND TO_CHAR(apradeg_date, 'yyyy') = apbcons_pref_clas
  )
  AND EXISTS
  (SELECT 1
  FROM apradeg
  WHERE apradeg_sbgi_code = '003918'
    AND apradeg_pidm      = apbcons_pidm
  )
ORDER BY apbcons_pref_clas;