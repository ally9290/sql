--Childless Parents with first name, last name, state, and street match

WITH addr as (
        select sor.sorfolk_pidm,
        cs.spriden_id as child_id,
        c.spraddr_pidm  AS parent_pidm,
        sor.sorfolk_parent_first,
        sor.sorfolk_parent_last
        from sorfolk sor, spraddr b, spraddr c, spriden cs
        where sor.sorfolk_pidm = b.spraddr_pidm
        and c.spraddr_atyp_code = 'H1'
        and c.spraddr_to_date is null 
        and b.spraddr_atyp_code = sor.sorfolk_atyp_code
        and b.spraddr_stat_code = c.spraddr_stat_code
        and b.spraddr_street_line1 = c.spraddr_street_line1
        AND sor.sorfolk_pidm = cs.spriden_pidm
        AND cs.spriden_change_ind is null)
select spr.spriden_pidm,
       spr.spriden_id,
       spr.spriden_last_name,
       spr.spriden_first_name,
       spr.spriden_mi,
       (select listagg(addr.child_id, ', ') WITHIN GROUP (ORDER BY 1) from addr where addr.parent_pidm = spr.spriden_pidm and addr.sorfolk_parent_first = spr.spriden_first_name and addr.sorfolk_parent_last = spr.spriden_last_name) as child_ids
  from spriden spr
   inner join aprcatg apr
    on (spr.spriden_pidm = apr.aprcatg_pidm and
       spr.spriden_change_ind is null)
 where 1 = 1
   and apr.aprcatg_donr_code = 'PRNT'
   and spr.spriden_pidm not in
       (select aprx.aprxref_pidm
          from aprxref aprx
         where 1 = 1
           and aprx.aprxref_xref_code = 'CHD')
and exists(select 1 from addr where addr.parent_pidm = spr.spriden_pidm and addr.sorfolk_parent_first = spr.spriden_first_name and addr.sorfolk_parent_last = spr.spriden_last_name)
   order by spr.spriden_last_name,
          spr.spriden_first_name;

