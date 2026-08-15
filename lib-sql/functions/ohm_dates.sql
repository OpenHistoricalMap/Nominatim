-- SPDX-License-Identifier: GPL-2.0-only
--
-- This file is part of the OpenHistoricalMap fork of Nominatim.

-- pad_date and isodatetodecimaldate come from DateFunctions-plpgsql,
-- which the deploy image loads before this file.
CREATE OR REPLACE FUNCTION ohm_set_decdates()
  RETURNS TRIGGER
  AS $$
BEGIN
  NEW.start_decdate := isodatetodecimaldate(
      pad_date(nullif(NEW.extratags->'start_date', ''), 'start'), false);
  NEW.end_decdate := isodatetodecimaldate(
      pad_date(nullif(NEW.extratags->'end_date', ''), 'end'), false);
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;
