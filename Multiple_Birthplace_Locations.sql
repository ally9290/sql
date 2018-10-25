/* Birthplace comment and spbpers birthplace */
SELECT spriden_pidm,
  spriden_id,
  trim( spriden_first_name
  || ' '
  ||
  CASE
    WHEN spriden_mi IS NULL
    THEN NULL
    ELSE spriden_mi
      || ' '
  END
  || spriden_last_name ) spriden_name,
  aprsubj_subj_code,
  aprconf_grp_seq_no,
  aprconf_entry_date,
  aprconf_comment,
  spbpers_city_birth,
  spbpers_stat_code_birth
FROM spbpers,
  aprconf,
  aprsubj,
  spriden
WHERE (spbpers_city_birth    IS NOT NULL
  OR spbpers_stat_code_birth IS NOT NULL)
  AND aprconf_pidm            = aprsubj_pidm
  AND aprconf_grp_seq_no      = aprsubj_grp_seq_no
  AND aprsubj_subj_code       = 'BIRTHP'
  AND aprconf_pidm            = spbpers_pidm
  AND aprconf_pidm            = spriden_pidm
  AND spriden_change_ind     IS NULL;



/* Multiple Birthplace comments */
SELECT spriden_pidm,
  spriden_id,
  trim( spriden_first_name
  || ' '
  ||
  CASE
    WHEN spriden_mi IS NULL
    THEN NULL
    ELSE spriden_mi
      || ' '
  END
  || spriden_last_name ) spriden_name,
  aprsubj_subj_code,
  aprconf_grp_seq_no,
  aprconf_entry_date,
  aprconf_comment
FROM aprconf,
  aprsubj,
  spriden
WHERE aprconf_pidm       = aprsubj_pidm
  AND aprconf_grp_seq_no = aprsubj_grp_seq_no
  AND aprsubj_pidm      IN
  (SELECT aprsubj_pidm
  FROM aprsubj
  WHERE aprsubj_subj_code = 'BIRTHP'
  GROUP BY aprsubj_pidm
  HAVING COUNT( 1 ) > 1
  )
  AND aprconf_pidm        = spriden_pidm
  AND spriden_change_ind IS NULL
  AND aprsubj_subj_code   = 'BIRTHP'
ORDER BY spriden_id,
  aprconf_entry_date;