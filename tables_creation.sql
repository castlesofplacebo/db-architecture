CREATE SCHEMA IF NOT EXISTS "Underground"
    AUTHORIZATION postgres;

CREATE TABLE IF NOT EXISTS "Underground"."Card_Types"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    name text COLLATE pg_catalog."default" NOT NULL,
    price numeric(7,2) NOT NULL,
    can_return_card boolean NOT NULL,
    max_count_pass smallint NOT NULL,
    days_for_return smallint,
    CONSTRAINT "Card_Types_pkey" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS "Underground"."Card_Entities"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    is_blocked boolean NOT NULL,
    is_duplicated boolean NOT NULL,
    current_count_pass smallint NOT NULL,
    first_bought_date date NOT NULL,
    first_bought_location text COLLATE pg_catalog."default" NOT NULL,
    card_type_id uuid NOT NULL,
    CONSTRAINT "Card_Entities_pkey" PRIMARY KEY (id),
    CONSTRAINT card_type_id FOREIGN KEY (card_type_id)
        REFERENCES "Underground"."Card_Types" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE IF NOT EXISTS "Underground"."Groups"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Groups_pkey" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS "Underground"."Groups_Of_Card_Types"
(
    card_type_id uuid NOT NULL,
    group_id uuid NOT NULL,
    CONSTRAINT card_type_id FOREIGN KEY (card_type_id)
        REFERENCES "Underground"."Card_Types" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT group_id FOREIGN KEY (group_id)
        REFERENCES "Underground"."Groups" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Underground"."Ticket_Types"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    name text COLLATE pg_catalog."default" NOT NULL,
    still_produced boolean NOT NULL,
    time_out smallint NOT NULL,
    CONSTRAINT "Ticket_Types_pkey" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS "Underground"."Ticket_Types_Of_Card_Entities"
(
    card_entity_id uuid NOT NULL,
    ticket_type_id uuid NOT NULL,
    CONSTRAINT card_entitiy_id FOREIGN KEY (card_entity_id)
        REFERENCES "Underground"."Card_Entities" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ticket_type_id FOREIGN KEY (ticket_type_id)
        REFERENCES "Underground"."Ticket_Types" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Underground"."Passengers"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    surname text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    patronymic text COLLATE pg_catalog."default",
    birth date NOT NULL,
    photo_url text COLLATE pg_catalog."default",
    CONSTRAINT "Passengers_pkey" PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS "Underground"."Benefits"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    passenger_id uuid NOT NULL,
    group_id uuid NOT NULL,
    organization text COLLATE pg_catalog."default" NOT NULL,
    start_date date,
    expiration_date date,
    CONSTRAINT "Benefits_pkey" PRIMARY KEY (id),
    CONSTRAINT group_id FOREIGN KEY (group_id)
        REFERENCES "Underground"."Groups" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT passenger_id FOREIGN KEY (passenger_id)
        REFERENCES "Underground"."Passengers" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Underground"."Ticket_Entites"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    ticket_type_id uuid NOT NULL,
    passenger_id uuid,
    start_date date NOT NULL,
    expiration_date date NOT NULL,
    CONSTRAINT "Ticket_Entites_pkey" PRIMARY KEY (id),
    CONSTRAINT passenger_id FOREIGN KEY (passenger_id)
        REFERENCES "Underground"."Passengers" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ticket_type_id FOREIGN KEY (ticket_type_id)
        REFERENCES "Underground"."Ticket_Types" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Underground"."Remaining_Resource"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    ticket_entity_id uuid NOT NULL,
    is_resource_active boolean NOT NULL,
    money numeric(7,2),
    "time" smallint NOT NULL,
    rides smallint,
    CONSTRAINT "Remaining_Resource_pkey" PRIMARY KEY (id),
    CONSTRAINT ticket_entity_id FOREIGN KEY (ticket_entity_id)
        REFERENCES "Underground"."Ticket_Entites" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Underground"."Card_Presentation"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    ticket_entity_id uuid NOT NULL,
    "timestamp" timestamp without time zone NOT NULL DEFAULT now(),
    was_success boolean NOT NULL,
    was_baggage_paid boolean NOT NULL,
    CONSTRAINT "Card_Presentation_pkey" PRIMARY KEY (id),
    CONSTRAINT ticket_entity_id FOREIGN KEY (ticket_entity_id)
        REFERENCES "Underground"."Ticket_Entites" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "Underground"."Document_Types"
(
    name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Document_Types_pkey" PRIMARY KEY (name)
);

CREATE TABLE IF NOT EXISTS "Underground"."Documents"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    passenger_id uuid NOT NULL,
    document_type_name text COLLATE pg_catalog."default" NOT NULL,
    document_id text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Documents_pkey" PRIMARY KEY (id),
    CONSTRAINT document_id UNIQUE (document_id),
    CONSTRAINT document_type_name FOREIGN KEY (document_type_name)
        REFERENCES "Underground"."Document_Types" (name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT passenger_id FOREIGN KEY (passenger_id)
        REFERENCES "Underground"."Passengers" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);