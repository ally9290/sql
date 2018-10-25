--SQL query to identify records that have an incorrect address type
SELECT a.spriden_id as "Banner ID",
       a.spriden_first_name||' '||a.spriden_last_name as "Name",      
       a.spriden_entity_ind as "Entity Indicator",
       b.spraddr_atyp_code as "Address Type",
       b.spraddr_from_date as "From Date",
       b.spraddr_to_date as "To Date",
       b.spraddr_street_line1 as "Street Line 1",
       b.spraddr_street_line2 as "Street Line 2",
       b.spraddr_street_line3 as "Street Line 3",
       b.spraddr_city as "City",
       b.spraddr_stat_code as "State",
       b.spraddr_zip as "Zip"
FROM   spriden a,
       spraddr b
WHERE  a.spriden_pidm = b.spraddr_pidm
       AND a.spriden_change_ind IS NULL
       AND ( ( a.spriden_entity_ind = 'C'
               AND a.spriden_id LIKE '9%'
               AND b.spraddr_status_ind IS NULL
               AND b.spraddr_atyp_code IN ( 'H1', 'H2', 'H3', 'H4', 'W1', 'W3', 'W4', 'S1', 'R1') )
               OR ( spriden_entity_ind = 'P'
                   AND spraddr_atyp_code IN ( 'C1', 'C2', 'C3', 'C4' )
                   AND spraddr_status_ind IS NULL) )
