select from only "Underground"."Passengers";

select surname from only "Underground"."passengers_surnameO_U"
where surname = 'Sheludchenko';

explain analyse select * from "Underground"."Passengers"
where left(surname,1)='S';