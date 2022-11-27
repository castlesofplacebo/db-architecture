create table "Underground"."passengers_surnameA_G" (
    check ( 'A' <= left(surname, 1) and  left(surname, 1) <= 'G')
) inherits ("Underground"."Passengers");

create table "Underground"."passengers_surnameH_N" (
    check ( 'H' <= left(surname, 1) and left(surname, 1) <= 'N')
) inherits ("Underground"."Passengers");

create table "Underground"."passengers_surnameO_U" (
    check ( 'O' <= left(surname, 1) and left(surname, 1) <= 'U')
) inherits ("Underground"."Passengers");

create table "Underground"."passengers_surnameV_Z" (
    check ( 'V' <= left(surname, 1) and left(surname, 1) <= 'Z')
) inherits ("Underground"."Passengers");