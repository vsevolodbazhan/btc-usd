CREATE SCHEMA IF NOT EXISTS dictionary;

CREATE TABLE IF NOT EXISTS dictionary.exchange_rates (
    "from" CHAR(3) NOT NULL,
    "to" CHAR(3) NOT NULL,
    "date" DATE NOT NULL,
    "rate" DECIMAL NOT NULL,
    PRIMARY KEY ("from", "to", "date")
);
