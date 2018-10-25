--Duplicate Records with Same Name and Same Email Address
select t.spriden_pidm,
       t.spriden_id,
       s.spbpers_name_prefix,
       t.spriden_first_name,
       t.spriden_mi,
       t.spriden_last_name,
       e.goremal_email_address,
       sub.spriden_id,
       sub.spbpers_name_prefix,
       sub.spriden_first_name,
       sub.spriden_mi,
       sub.spriden_last_name,
       sub.goremal_email_address
  from spriden t, spbpers s, goremal e, aprcatg c,
  (select t.spriden_pidm,
                      t.spriden_id,
                      s.spbpers_name_prefix,
                      t.spriden_first_name,
                      t.spriden_mi,
                      t.spriden_last_name,
                      e.goremal_email_address
                 from spriden t, spbpers s, goremal e, aprcatg c
                where 1 = 1
                  and t.spriden_change_ind is null
                  and t.spriden_pidm = s.spbpers_pidm
                  and t.spriden_pidm = e.goremal_pidm
                  and t.spriden_pidm = c.aprcatg_pidm
                  and c.aprcatg_donr_code <> 'DUPP'
        ) sub
 where 1 = 1
   and ( t.spriden_pidm <> sub.spriden_pidm
   and s.spbpers_name_prefix <> sub.spbpers_name_prefix
   and t.spriden_first_name = sub.spriden_first_name
   and e.goremal_email_address = sub.goremal_email_address )
   and t.spriden_change_ind is null
   and t.spriden_pidm = s.spbpers_pidm
   and t.spriden_pidm = e.goremal_pidm
   and t.spriden_pidm = c.aprcatg_pidm
   and c.aprcatg_donr_code <> 'DUPP'
 group by t.spriden_pidm,
       t.spriden_id,
       s.spbpers_name_prefix,
       t.spriden_first_name,
       t.spriden_mi,
       t.spriden_last_name,
       e.goremal_email_address,
       sub.spriden_id,
       sub.spbpers_name_prefix,
       sub.spriden_first_name,
       sub.spriden_mi,
       sub.spriden_last_name,
       sub.goremal_email_address
 order by t.spriden_last_name;
