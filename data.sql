-- AgroNorte S.A. - Datos

USE agronorte;

-- Regiones productoras de soja en Argentina

INSERT INTO regions (name) VALUES
    ('Pampa Húmeda'),
    ('NOA'),
    ('NEA'),
    ('Cuyo'),
    ('Patagonia');

-- Categorías de productos

INSERT INTO categories (name) VALUES
    ('Semillas de Soja'),
    ('Fertilizantes'),
    ('Herbicidas'),
    ('Inoculantes'),
    ('Maquinaria y Equipos');

-- Productos (semillas, fertilizantes, herbicidas, etc.)

INSERT INTO products (name, id_category, unit_price, stock) VALUES
    ('Soja DM 4670 RSF (bolsa 40kg)',       1,  185.00,  200),
    ('Soja NK 7059 (bolsa 40kg)',            1,  195.00,  180),
    ('Soja A 5009 RG (bolsa 40kg)',          1,  175.00,  220),
    ('Soja SPS 4x4 (bolsa 40kg)',            1,  190.00,  150),
    ('Soja Nidera 4990 (bolsa 40kg)',        1,  180.00,  170),
    ('Urea granulada (bolsa 50kg)',          2,   95.00,  300),
    ('Fosfato diamónico DAP (bolsa 50kg)',   2,  120.00,  250),
    ('Sulfato de azufre (bolsa 25kg)',       2,   60.00,  400),
    ('Glifosato 48% (bidón 20L)',            3,   75.00,  350),
    ('Atrazina 50% (bidón 20L)',             3,   85.00,  280),
    ('Cletodim 24% (bidón 10L)',             3,   90.00,  200),
    ('Inoculante líquido Soja (500ml)',      4,   35.00,  500),
    ('Inoculante turba Soja (dosis 100kg)',  4,   28.00,  450),
    ('Pulverizadora 600L arrastre',          5, 4200.00,    8),
    ('Sembradora monograno 6 surcos',        5, 8500.00,    4),
    ('Tanque de agua 5000L',                 5,  950.00,   15),
    ('Kit mantenimiento sembradora',         5,  320.00,   30),
    ('Medidor de humedad de granos',         5,  480.00,   20);

-- Vendedores por región

INSERT INTO sellers (full_name, id_region, hire_date) VALUES
    ('Lucía Fernández',   1, '2020-03-15'),
    ('Martín Gómez',      2, '2019-07-01'),
    ('Valeria Ruiz',      3, '2021-01-10'),
    ('Diego Herrera',     4, '2020-11-20'),
    ('Camila Suárez',     5, '2022-05-05'),
    ('Tomás Aguirre',     1, '2018-09-12'),
    ('Florencia Méndez',  2, '2021-08-30');

-- Clientes (cooperativas y establecimientos agropecuarios)

INSERT INTO customers (full_name, email, city, id_region, created_at) VALUES
    ('Cooperativa Agrícola San Martín',  'csanmartin@agro.com',   'Rosario',        1, '2021-02-10'),
    ('Establecimiento Don Julio S.A.',   'donjulio@campo.com',    'Córdoba',        1, '2021-05-22'),
    ('Agropecuaria Los Alamos',          'losalamos@agro.com',    'Pergamino',      1, '2020-07-05'),
    ('Granos del Norte S.R.L.',          'granosn@mail.com',      'Salta',          2, '2022-03-14'),
    ('Finca La Esperanza',               'laesperanza@campo.com', 'Tucumán',        2, '2021-11-01'),
    ('Cooperativa Chaqueña Ltda.',       'coopchaqu@agro.com',    'Resistencia',    3, '2020-05-19'),
    ('Agro NEA S.A.',                    'agroneasa@mail.com',    'Corrientes',     3, '2022-06-08'),
    ('Finca Los Olivos',                 'losolivos@campo.com',   'Mendoza',        4, '2021-09-25'),
    ('Distribuidora Sur Agro',           'suragro@mail.com',      'Neuquén',        5, '2020-12-03'),
    ('El Trigal Agropecuaria',           'eltrigal@agro.com',     'Entre Ríos',     1, '2022-01-17'),
    ('Semillas del Plata',               'semplata@mail.com',     'Buenos Aires',   1, '2021-04-30'),
    ('Campo Verde S.A.',                 'campoverde@agro.com',   'Santa Fe',       1, '2019-08-11'),
    ('Agropecuaria Jujeña',              'agrojujuy@mail.com',    'Jujuy',          2, '2022-07-22'),
    ('Los Robles Agro',                  'losrobles@campo.com',   'La Pampa',       1, '2020-10-14'),
    ('Patagonia Granos S.R.L.',          'patgranos@mail.com',    'Río Negro',      5, '2021-06-27');

-- Órdenes de compra 2023-2024

INSERT INTO orders (id_customer, id_seller, order_date, status) VALUES
    ( 1, 1, '2023-01-15', 'completed'),
    ( 2, 6, '2023-01-28', 'completed'),
    ( 3, 1, '2023-02-10', 'completed'),
    ( 4, 2, '2023-02-20', 'cancelled'),
    ( 5, 7, '2023-03-05', 'completed'),
    ( 6, 3, '2023-03-18', 'completed'),
    ( 7, 3, '2023-04-02', 'completed'),
    ( 8, 4, '2023-04-22', 'completed'),
    ( 9, 5, '2023-05-09', 'completed'),
    (10, 6, '2023-05-30', 'completed'),
    (11, 1, '2023-06-14', 'completed'),
    (12, 6, '2023-06-25', 'cancelled'),
    (13, 2, '2023-07-08', 'completed'),
    (14, 1, '2023-07-19', 'completed'),
    (15, 5, '2023-08-03', 'completed'),
    ( 1, 6, '2023-08-21', 'completed'),
    ( 3, 1, '2023-09-10', 'completed'),
    ( 5, 7, '2023-09-27', 'completed'),
    ( 7, 3, '2023-10-15', 'completed'),
    ( 9, 5, '2023-10-29', 'completed'),
    (11, 1, '2023-11-11', 'completed'),
    (13, 2, '2023-11-24', 'completed'),
    ( 2, 6, '2023-12-05', 'completed'),
    ( 4, 2, '2023-12-18', 'completed'),
    ( 6, 3, '2024-01-09', 'completed'),
    ( 8, 4, '2024-01-23', 'completed'),
    (10, 6, '2024-02-06', 'completed'),
    (12, 1, '2024-02-19', 'completed'),
    (14, 1, '2024-03-04', 'completed'),
    (15, 5, '2024-03-17', 'completed'),
    ( 1, 6, '2024-04-01', 'completed'),
    ( 3, 1, '2024-04-14', 'cancelled'),
    ( 5, 7, '2024-04-28', 'completed'),
    ( 7, 3, '2024-05-12', 'completed'),
    ( 9, 5, '2024-05-26', 'completed'),
    (11, 1, '2024-06-09', 'completed'),
    (13, 2, '2024-06-23', 'completed'),
    ( 2, 6, '2024-07-07', 'completed'),
    ( 4, 2, '2024-07-21', 'completed'),
    ( 6, 3, '2024-08-04', 'completed'),
    ( 8, 4, '2024-08-18', 'completed'),
    (10, 6, '2024-09-01', 'completed'),
    (12, 1, '2024-09-15', 'completed'),
    (14, 1, '2024-09-29', 'completed'),
    (15, 5, '2024-10-13', 'completed'),
    ( 1, 6, '2024-10-27', 'completed'),
    ( 3, 1, '2024-11-10', 'completed'),
    ( 5, 7, '2024-11-24', 'completed'),
    ( 7, 3, '2024-12-08', 'completed'),
    ( 9, 5, '2024-12-22', 'completed');

-- Detalle de productos por orden

INSERT INTO order_items (id_order, id_product, quantity, unit_price) VALUES
    -- order 1
    (1,  1, 20, 185.00), (1,  6, 10,  95.00),
    -- order 2
    (2,  2, 15, 195.00), (2, 12, 30,  35.00),
    -- order 3
    (3,  3, 25, 175.00), (3,  9, 10,  75.00),
    -- order 4
    (4,  4, 10, 190.00),
    -- order 5
    (5,  5, 20, 180.00), (5, 13, 20,  28.00),
    -- order 6
    (6,  1, 15, 185.00), (6,  7, 8,  120.00),
    -- order 7
    (7,  9, 20,  75.00), (7, 10, 15,  85.00),
    -- order 8
    (8, 14,  1, 4200.00),
    -- order 9
    (9,  2, 10, 195.00), (9, 12, 20,  35.00),
    -- order 10
    (10, 3, 30, 175.00), (10, 8, 15,  60.00),
    -- order 11
    (11, 1, 25, 185.00), (11,6, 20,   95.00),
    -- order 12
    (12, 2, 20, 195.00),
    -- order 13
    (13, 4, 15, 190.00), (13,13,25,   28.00),
    -- order 14
    (14, 5, 20, 180.00), (14,11,10,   90.00),
    -- order 15
    (15,15,  1, 8500.00),
    -- order 16
    (16, 1, 30, 185.00), (16, 7,10,  120.00),
    -- order 17
    (17, 3, 20, 175.00), (17,12,30,   35.00),
    -- order 18
    (18, 5, 15, 180.00), (18, 9,10,   75.00),
    -- order 19
    (19, 2, 25, 195.00), (19,10,20,   85.00),
    -- order 20
    (20, 4, 10, 190.00), (20,13,15,   28.00),
    -- order 21
    (21, 1, 20, 185.00), (21, 8,10,   60.00),
    -- order 22
    (22, 5, 15, 180.00), (22,11,10,   90.00),
    -- order 23
    (23, 3, 30, 175.00), (23,16, 1,  950.00),
    -- order 24
    (24, 2, 20, 195.00), (24, 6,15,   95.00),
    -- order 25
    (25, 1, 25, 185.00), (25, 9,20,   75.00),
    -- order 26
    (26,17,  2, 320.00), (26,12,20,   35.00),
    -- order 27
    (27, 4, 20, 190.00), (27,13,15,   28.00),
    -- order 28
    (28, 3, 15, 175.00), (28, 7,10,  120.00),
    -- order 29
    (29, 5, 25, 180.00), (29,11,15,   90.00),
    -- order 30
    (30,15,  1, 8500.00),
    -- order 31
    (31, 1, 30, 185.00), (31,10,20,   85.00),
    -- order 32
    (32, 2, 20, 195.00),
    -- order 33
    (33, 4, 15, 190.00), (33, 8,10,   60.00),
    -- order 34
    (34, 3, 25, 175.00), (34,18, 1,  480.00),
    -- order 35
    (35, 5, 20, 180.00), (35,12,30,   35.00),
    -- order 36
    (36, 1, 15, 185.00), (36, 6,10,   95.00),
    -- order 37
    (37,14,  1, 4200.00),(37,17, 1,  320.00),
    -- order 38
    (38, 2, 25, 195.00), (38, 9,15,   75.00),
    -- order 39
    (39, 4, 20, 190.00), (39,13,20,   28.00),
    -- order 40
    (40, 3, 30, 175.00), (40, 7,10,  120.00),
    -- order 41
    (41, 5, 15, 180.00), (41,11,10,   90.00),
    -- order 42
    (42, 1, 20, 185.00), (42,10,15,   85.00),
    -- order 43
    (43, 2, 25, 195.00), (43,12,20,   35.00),
    -- order 44
    (44, 4, 10, 190.00), (44, 8,10,   60.00),
    -- order 45
    (45,16,  1, 950.00), (45,13,15,   28.00),
    -- order 46
    (46, 3, 20, 175.00), (46, 6,15,   95.00),
    -- order 47
    (47, 5, 25, 180.00), (47,18, 1,  480.00),
    -- order 48
    (48, 1, 30, 185.00), (48, 9,10,   75.00),
    -- order 49
    (49, 2, 20, 195.00), (49,11,15,   90.00),
    -- order 50
    (50, 4, 15, 190.00), (50,17, 1,  320.00);
