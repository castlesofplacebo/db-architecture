CREATE MATERIALIZED VIEW "Underground".generalized_passengers AS
SELECT
  'REDACTED'::TEXT AS surname,
  name,
  anon.generalize_daterange(birth,'decade') AS birth
FROM "Underground"."Passengers";