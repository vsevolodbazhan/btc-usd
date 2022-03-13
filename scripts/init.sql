CREATE TABLE IF NOT EXISTS exchange_rates (
    "from" CHAR(3) NOT NULL,
    "to" CHAR(3) NOT NULL,
    "date" DATE NOT NULL,
    "rate" DECIMAL NOT NULL,
    PRIMARY KEY ("from", "to", "date")
);
