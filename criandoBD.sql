 create tablespace TBS_DADOS datafile 'C:\oraclexe\oradata\XE\TBS_DADOS.DBF'
 size 100m autoextend on next 50m
 maxsize 500m
 online
 permanent
 extent management local autoallocate
 segment space management auto; 

 create tablespace TBS_INDICES datafile 'C:\oraclexe\oradata\XE\TBS_INDICES.DBF'
 size 30m autoextend on next 10m
 maxsize 300m
 online
 permanent
 extent management local autoallocate
 segment space management auto; 

create user UFEMASS
 identified by UFEMASS00
 default tablespace TBS_DADOS
 temporary tablespace TEMP; 

grant dba to UFEMASS; 

alter user UFEMASS quota unlimited on TBS_DADOS; 

alter user UFEMASS quota unlimited on TBS_INDICES;