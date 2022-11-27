create trigger insert_surnames
    before insert on "Underground"."Passengers"
    for each row execute function surnames_insert_trigger();