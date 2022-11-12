SELECT anon.init();

CREATE MATERIALIZED VIEW "Underground".passengers_benefits AS
SELECT
  anon.fake_last_name() as surname,
  anon.fake_first_name() as name,
  benefits.organization as organization,
  anon.random_date_between('2022-10-01 10:23:54+03','2022-10-30 10:23:54+03') as start_date,
  anon.random_date_between('2023-10-01 10:23:54+03','2023-10-30 10:23:54+03') as expiration_date
FROM "Underground"."Benefits" as benefits;