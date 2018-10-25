--Non-Alums with UNH Degrees
select t.spriden_pidm,
       t.spriden_id,
       s.spbpers_name_prefix,
       t.spriden_first_name,
       t.spriden_mi,
       t.spriden_last_name,
       d.*
  from spriden t, spbpers s, apradeg d
 where 1 = 1
   and t.spriden_change_ind is null
   and t.spriden_pidm = s.spbpers_pidm
   and t.spriden_pidm = d.apradeg_pidm
   and t.spriden_pidm not in (
   select c.aprcatg_pidm from aprcatg c where 1=1
   and c.aprcatg_donr_code in ('ALUM','NGRD','DUPP'))
   and d.apradeg_sbgi_code in ('003918','002094','U00089')
   and d.apradeg_degc_code <> '000000'
   and d.apradeg_degc_code not in ('PBACC', 'C')
order by t.spriden_last_name;