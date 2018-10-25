--Full Middle Name population for NTYP_CODE = 'ALL'
select spr.spriden_id as SPRIDEN1,
       spr.spriden_pidm as PIDM1,
       spb.spbpers_name_prefix as PREFX1,
       spr.spriden_last_name as LNAME1,
       spr.spriden_first_name as FNAME1,
       spr.spriden_mi as MI1,
       spb.spbpers_name_suffix as SUFFX1,
       spr.spriden_ntyp_code as NTYP1,
       sub.spriden_pidm as PIDM2,
       sub.spbpers_name_prefix as PREFX2,
       sub.spriden_last_name as LNAME2,
       sub.spriden_first_name as FNAME2,
       sub.spriden_mi as MI2,
       sub.spbpers_name_suffix as SUFFX2
  from spriden spr
  join (select spr.spriden_id,
               spr.spriden_pidm,
               spb.spbpers_name_prefix,
               spr.spriden_last_name,
               spr.spriden_first_name,
               spr.spriden_mi,
               spb.spbpers_name_suffix,
               spr.spriden_ntyp_code
          from spriden spr, spbpers spb
         where 1 = 1
           and spr.spriden_pidm = spb.spbpers_pidm
           and (spr.spriden_mi not like ('_') and spr.spriden_mi not like ('_.%'))
        ) sub
    on spr.spriden_pidm = sub.spriden_pidm
  join spbpers spb
    on spr.spriden_pidm = spb.spbpers_pidm
 where 1 = 1
   and spr.spriden_ntyp_code in ('ALL')
   and substr(spr.spriden_mi,0,1) = substr(sub.spriden_mi,0,1)
   and(spr.spriden_mi like ('_') or spr.spriden_mi like ('_.'))
   and spr.spriden_last_name <> sub.spriden_mi 
   --and spr.spriden_first_name = sub.spriden_first_name
 group by spr.spriden_id,
       spr.spriden_pidm,
       spb.spbpers_name_prefix,
       spr.spriden_last_name,
       spr.spriden_first_name,
       spr.spriden_mi,
       spb.spbpers_name_suffix,
       spr.spriden_ntyp_code,
       sub.spriden_pidm,
       sub.spbpers_name_prefix,
       sub.spriden_last_name,
       sub.spriden_first_name,
       sub.spriden_mi,
       sub.spbpers_name_suffix
 order by spr.spriden_pidm, spr.spriden_last_name
