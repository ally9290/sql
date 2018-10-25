--SQL query to find constituents that have degrees before their birth date or before age 18
select t.spriden_pidm,
       t.spriden_id,
       s.spbpers_name_prefix,
       t.spriden_first_name,
       t.spriden_mi,
       t.spriden_last_name,
       extract(year from d.apradeg_date) - extract(year from s.spbpers_birth_date) as "age_at_degree",
       s.spbpers_birth_date,
       d.apradeg_date,
       d.apradeg_coll_code
  from spriden t, spbpers s, apradeg d
 where 1 = 1
   and t.spriden_change_ind is null
   and t.spriden_pidm = s.spbpers_pidm
   and t.spriden_pidm = d.apradeg_pidm
   and (d.apradeg_date <= s.spbpers_birth_date OR
       extract(year from d.apradeg_date) -
       extract(year from s.spbpers_birth_date) <= 18)
   and t.spriden_pidm not in
       (select c.aprcatg_pidm
          from aprcatg c
         where c.aprcatg_donr_code = 'HOCM')
 order by t.spriden_last_name
