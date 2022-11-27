with x as (
    delete from only "Underground"."Passengers"
           where left(surname, 1) between 'A' and 'G' returning *)
insert into "Underground"."passengers_surnameA_G"
select * from x;

with x as (
    delete from only "Underground"."Passengers"
           where left(surname, 1) between 'H' and 'N' returning *)
insert into "Underground"."passengers_surnameH_N"
select * from x;

with x as (
    delete from only "Underground"."Passengers"
           where left(surname, 1) between 'O' and 'U' returning *)
insert into "Underground"."passengers_surnameO_U"
select * from x;

with x as (
    delete from only "Underground"."Passengers"
           where left(surname, 1) between 'V' and 'Z' returning *)
insert into "Underground"."passengers_surnameV_Z"
select * from x;