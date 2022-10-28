CREATE OR REPLACE VIEW "Underground".card_presentation AS
    SELECT
        card.ticket_entity_id AS ticket_entity_id,
        ticket_type.name AS ticket_name,
        card.timestamp AS timestamp,
        card.was_success AS was_success,
        ticket_entities.passenger_id AS passenger_id
    FROM "Underground"."Card_Presentation" AS card
    INNER JOIN "Underground"."Ticket_Entites" AS ticket_entities ON ticket_entities.id = card.ticket_entity_id
    INNER JOIN "Underground"."Ticket_Types" AS ticket_type ON ticket_type.id = ticket_entities.ticket_type_id;

SELECT *
FROM "Underground".card_presentation;