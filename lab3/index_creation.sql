CREATE INDEX card_presentation_idx ON "Underground"."Card_Presentation"(ticket_entity_id, timestamp DESC);

CREATE INDEX ticket_entities_idx ON "Underground"."Ticket_Entites"(id, passenger_id);