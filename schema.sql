-- AgroNorte S.A. - Estructura de la base de datos

CREATE DATABASE IF NOT EXISTS agronorte
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE agronorte;

-- Regiones del país
CREATE TABLE IF NOT EXISTS regions (
    id_region   INT          AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50)  NOT NULL
);

-- Clientes
CREATE TABLE IF NOT EXISTS customers (
    id_customer  INT          AUTO_INCREMENT PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(100) UNIQUE NOT NULL,
    city         VARCHAR(60)  NOT NULL,
    id_region    INT          NOT NULL,
    created_at   DATE         NOT NULL,
    CONSTRAINT fk_customer_region FOREIGN KEY (id_region) REFERENCES regions(id_region)
);

-- Categorías de productos
CREATE TABLE IF NOT EXISTS categories (
    id_category  INT         AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(60) NOT NULL
);

-- Productos con precio y stock
CREATE TABLE IF NOT EXISTS products (
    id_product   INT            AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100)   NOT NULL,
    id_category  INT            NOT NULL,
    unit_price   DECIMAL(10,2)  NOT NULL,
    stock        INT            NOT NULL DEFAULT 0,
    CONSTRAINT fk_product_category FOREIGN KEY (id_category) REFERENCES categories(id_category)
);

-- Vendedores por región
CREATE TABLE IF NOT EXISTS sellers (
    id_seller   INT          AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    id_region   INT          NOT NULL,
    hire_date   DATE         NOT NULL,
    CONSTRAINT fk_seller_region FOREIGN KEY (id_region) REFERENCES regions(id_region)
);

-- Órdenes de compra
CREATE TABLE IF NOT EXISTS orders (
    id_order     INT    AUTO_INCREMENT PRIMARY KEY,
    id_customer  INT    NOT NULL,
    id_seller    INT    NOT NULL,
    order_date   DATE   NOT NULL,
    status       ENUM('completed','cancelled','pending') NOT NULL DEFAULT 'completed',
    CONSTRAINT fk_order_customer FOREIGN KEY (id_customer) REFERENCES customers(id_customer),
    CONSTRAINT fk_order_seller   FOREIGN KEY (id_seller)   REFERENCES sellers(id_seller)
);

-- Detalle de orden (productos y cantidad)
CREATE TABLE IF NOT EXISTS order_items (
    id_item      INT            AUTO_INCREMENT PRIMARY KEY,
    id_order     INT            NOT NULL,
    id_product   INT            NOT NULL,
    quantity     INT            NOT NULL,
    unit_price   DECIMAL(10,2)  NOT NULL,
    CONSTRAINT fk_item_order   FOREIGN KEY (id_order)   REFERENCES orders(id_order),
    CONSTRAINT fk_item_product FOREIGN KEY (id_product) REFERENCES products(id_product)
);
