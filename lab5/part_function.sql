create or replace function
    surnames_insert_trigger()
    returns trigger as $$
declare
    v_partition_name text;
begin
    if (left(new.surname, 1) >= 'A' and
        left(new.surname, 1) <= 'G') then
        v_partition_name := '"Underground"."passengers_surnameA_G"';
    elsif (left(new.surname, 1) >= 'H' and
        left(new.surname, 1) <= 'N') then
        v_partition_name := '"Underground"."passengers_surnameH_N"';
    elsif (left(new.surname, 1) >= 'O' and
        left(new.surname, 1) <= 'U') then
        v_partition_name := '"Underground"."passengers_surnameO_U"';
    elsif (left(new.surname, 1) >= 'V' and
        left(new.surname, 1) <= 'Z') then
        v_partition_name := '"Underground"."passengers_surnameV_Z"';
    end if;
    execute 'INSERT INTO ' || v_partition_name || ' VALUES ( ($1).* )' USING NEW;
    return null;
end;
$$
language plpgsql;
