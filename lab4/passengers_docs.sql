CREATE MATERIALIZED VIEW "Underground".passengers_docs AS
SELECT
  pass.surname as surname,
  pass.name as name,
  doc_types.name as doc_type_name,
  anon.hash(docs.document_id) as doc_id
FROM "Underground"."Documents" as docs
INNER JOIN "Underground"."Document_Types" as doc_types on doc_types.name = docs.document_type_name
INNER JOIN "Underground"."Passengers" as pass on pass.id = docs.passenger_id;