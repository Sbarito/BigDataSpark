CREATE TABLE mock_data (
  id                       BIGINT,
  customer_first_name      TEXT,
  customer_last_name       TEXT,
  customer_age             INTEGER,
  customer_email           TEXT,
  customer_country         TEXT,
  customer_postal_code     TEXT,
  customer_pet_type        TEXT,
  customer_pet_name        TEXT,
  customer_pet_breed       TEXT,
  seller_first_name        TEXT,
  seller_last_name         TEXT,
  seller_email             TEXT,
  seller_country           TEXT,
  seller_postal_code       TEXT,
  product_name             TEXT,
  product_category         TEXT,
  product_price            NUMERIC,
  product_quantity         INTEGER,
  sale_date                DATE,
  sale_customer_id         BIGINT,
  sale_seller_id           BIGINT,
  sale_product_id          BIGINT,
  sale_quantity            INTEGER,
  sale_total_price         NUMERIC,
  store_name               TEXT,
  store_location           TEXT,
  store_city               TEXT,
  store_state              TEXT,
  store_country            TEXT,
  store_phone              TEXT,
  store_email              TEXT,
  pet_category             TEXT,
  product_weight           NUMERIC,
  product_color            TEXT,
  product_size             TEXT,
  product_brand            TEXT,
  product_material         TEXT,
  product_description      TEXT,
  product_rating           NUMERIC,
  product_reviews          INTEGER,
  product_release_date     DATE,
  product_expiry_date      DATE,
  supplier_name            TEXT,
  supplier_contact         TEXT,
  supplier_email           TEXT,
  supplier_phone           TEXT,
  supplier_address         TEXT,
  supplier_city            TEXT,
  supplier_country         TEXT
);

CREATE TABLE dim_customer (
  customer_sk    SERIAL PRIMARY KEY,
  customer_id    BIGINT UNIQUE,
  first_name     TEXT NOT NULL,
  last_name      TEXT NOT NULL,
  age            INT,
  email          TEXT,
  country        TEXT,
  postal_code    TEXT,
  load_ts TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_seller (
  seller_sk      SERIAL PRIMARY KEY,
  seller_id      BIGINT UNIQUE,
  first_name     TEXT NOT NULL,
  last_name      TEXT NOT NULL,
  email          TEXT,
  country        TEXT,
  postal_code    TEXT,
  load_ts TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_product (
  product_sk         SERIAL PRIMARY KEY,
  product_id         BIGINT UNIQUE,
  name               TEXT NOT NULL,
  category           TEXT,
  weight             NUMERIC,
  color              TEXT,
  size               TEXT,
  brand              TEXT,
  material           TEXT,
  description        TEXT,
  rating             NUMERIC,
  reviews            INT,
  release_date       DATE,
  expiry_date        DATE,
  unit_price         NUMERIC,
  load_ts TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_store (
  store_sk       SERIAL PRIMARY KEY,
  name           TEXT UNIQUE,
  location       TEXT,
  city           TEXT,
  state          TEXT,
  country        TEXT,
  phone          TEXT,
  email          TEXT,
  load_ts TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_supplier (
  supplier_sk    SERIAL PRIMARY KEY,
  name           TEXT UNIQUE,
  contact        TEXT,
  email          TEXT,
  phone          TEXT,
  address        TEXT,
  city           TEXT,
  country        TEXT,
  load_ts TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_date (
  date_sk      SERIAL PRIMARY KEY,
  sale_date    DATE UNIQUE NOT NULL,
  year         INT NOT NULL,
  quarter      INT NOT NULL,
  month        INT NOT NULL,
  month_name   TEXT NOT NULL,
  day_of_month INT NOT NULL,
  day_of_week  INT NOT NULL,
  week_of_year INT NOT NULL,
  is_weekend   BOOLEAN NOT NULL,
  load_ts TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fact_sales (
  sale_sk               SERIAL PRIMARY KEY,
  date_sk               INT NOT NULL,
  customer_sk           INT NOT NULL,
  seller_sk             INT NOT NULL,
  product_sk            INT NOT NULL,
  store_sk              INT NOT NULL,
  supplier_sk           INT NOT NULL,
  sale_quantity         INT,
  sale_total_price      NUMERIC,
  transaction_unit_price NUMERIC,
  load_ts TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_date FOREIGN KEY (date_sk) REFERENCES dim_date(date_sk),
  CONSTRAINT fk_customer FOREIGN KEY (customer_sk) REFERENCES dim_customer(customer_sk),
  CONSTRAINT fk_seller FOREIGN KEY (seller_sk) REFERENCES dim_seller(seller_sk),
  CONSTRAINT fk_product FOREIGN KEY (product_sk) REFERENCES dim_product(product_sk),
  CONSTRAINT fk_store FOREIGN KEY (store_sk) REFERENCES dim_store(store_sk),
  CONSTRAINT fk_supplier FOREIGN KEY (supplier_sk) REFERENCES dim_supplier(supplier_sk)
);