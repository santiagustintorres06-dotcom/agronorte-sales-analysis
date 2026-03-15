-- AgroNorte S.A. - Consultas de análisis de ventas

USE agronorte;

-- 1. RESUMEN DE INGRESOS

-- Ingresos totales de órdenes completadas
SELECT
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS ingresos_totales
FROM order_items oi
JOIN orders o ON oi.id_order = o.id_order
WHERE o.status = 'completed';


-- Ingresos por mes
SELECT
    YEAR(o.order_date)                             AS anio,
    MONTH(o.order_date)                            AS mes,
    MONTHNAME(o.order_date)                        AS nombre_mes,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos_mes
FROM orders o
JOIN order_items oi ON o.id_order = oi.id_order
WHERE o.status = 'completed'
GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY anio, mes;


-- Comparación anual 2023 vs 2024
SELECT
    YEAR(o.order_date)                         AS anio,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS ingresos_anuales,
    COUNT(DISTINCT o.id_order)                 AS total_ordenes
FROM orders o
JOIN order_items oi ON o.id_order = oi.id_order
WHERE o.status = 'completed'
GROUP BY YEAR(o.order_date)
ORDER BY anio;

-- 2. PRODUCTOS

-- Top 5 productos por ingresos
SELECT
    p.name                                         AS producto,
    c.name                                         AS categoria,
    SUM(oi.quantity)                               AS unidades_vendidas,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos
FROM order_items oi
JOIN products p   ON oi.id_product  = p.id_product
JOIN categories c ON p.id_category  = c.id_category
JOIN orders o     ON oi.id_order    = o.id_order
WHERE o.status = 'completed'
GROUP BY p.id_product, p.name, c.name
ORDER BY ingresos DESC
LIMIT 5;


-- Ingresos por categoría con porcentaje
SELECT
    c.name                                         AS categoria,
    SUM(oi.quantity)                               AS unidades_vendidas,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos,
    ROUND(
        SUM(oi.quantity * oi.unit_price) * 100.0 /
        SUM(SUM(oi.quantity * oi.unit_price)) OVER (), 2
    )                                              AS porcentaje
FROM order_items oi
JOIN products p   ON oi.id_product  = p.id_product
JOIN categories c ON p.id_category  = c.id_category
JOIN orders o     ON oi.id_order    = o.id_order
WHERE o.status = 'completed'
GROUP BY c.id_category, c.name
ORDER BY ingresos DESC;


-- Productos con stock bajo (menos de 15 unidades)
SELECT
    p.name       AS producto,
    c.name       AS categoria,
    p.stock      AS stock_actual,
    p.unit_price AS precio
FROM products p
JOIN categories c ON p.id_category = c.id_category
WHERE p.stock < 15
ORDER BY p.stock ASC;

-- 3. CLIENTES

-- Top 10 clientes por gasto total
SELECT
    c.full_name                                    AS cliente,
    c.city                                         AS ciudad,
    COUNT(DISTINCT o.id_order)                     AS total_ordenes,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS total_gastado
FROM customers c
JOIN orders o      ON c.id_customer = o.id_customer
JOIN order_items oi ON o.id_order   = oi.id_order
WHERE o.status = 'completed'
GROUP BY c.id_customer, c.full_name, c.city
ORDER BY total_gastado DESC
LIMIT 10;


-- Ticket promedio por cliente
SELECT
    c.full_name                                                              AS cliente,
    COUNT(DISTINCT o.id_order)                                               AS total_ordenes,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)                               AS total_gastado,
    ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.id_order), 2)  AS ticket_promedio
FROM customers c
JOIN orders o       ON c.id_customer = o.id_customer
JOIN order_items oi ON o.id_order    = oi.id_order
WHERE o.status = 'completed'
GROUP BY c.id_customer, c.full_name
ORDER BY ticket_promedio DESC;


-- Ingresos por región
SELECT
    r.name                                         AS region,
    COUNT(DISTINCT c.id_customer)                  AS clientes,
    COUNT(DISTINCT o.id_order)                     AS total_ordenes,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos
FROM regions r
JOIN customers c    ON r.id_region   = c.id_region
JOIN orders o       ON c.id_customer = o.id_customer
JOIN order_items oi ON o.id_order    = oi.id_order
WHERE o.status = 'completed'
GROUP BY r.id_region, r.name
ORDER BY ingresos DESC;

-- 4. VENDEDORES

-- Ranking de vendedores por ingresos generados
SELECT
    s.full_name                                    AS vendedor,
    r.name                                         AS region,
    COUNT(DISTINCT o.id_order)                     AS ordenes_cerradas,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos_generados,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS ranking
FROM sellers s
JOIN regions r      ON s.id_region  = r.id_region
JOIN orders o       ON s.id_seller  = o.id_seller
JOIN order_items oi ON o.id_order   = oi.id_order
WHERE o.status = 'completed'
GROUP BY s.id_seller, s.full_name, r.name
ORDER BY ranking;


-- Tasa de cancelación por vendedor
SELECT
    s.full_name                                                      AS vendedor,
    COUNT(o.id_order)                                                AS total_ordenes,
    SUM(CASE WHEN o.status = 'cancelled' THEN 1 ELSE 0 END)         AS canceladas,
    ROUND(
        SUM(CASE WHEN o.status = 'cancelled' THEN 1 ELSE 0 END) * 100.0
        / COUNT(o.id_order), 1
    )                                                                AS tasa_cancelacion
FROM sellers s
JOIN orders o ON s.id_seller = o.id_seller
GROUP BY s.id_seller, s.full_name
ORDER BY tasa_cancelacion DESC;

-- 5. ANÁLISIS AVANZADO

-- Ingresos acumulados por mes
SELECT
    anio,
    nombre_mes,
    ingresos_mes,
    ROUND(SUM(ingresos_mes) OVER (ORDER BY anio, mes ROWS UNBOUNDED PRECEDING), 2) AS ingresos_acumulados
FROM (
    SELECT
        YEAR(o.order_date)                             AS anio,
        MONTH(o.order_date)                            AS mes,
        MONTHNAME(o.order_date)                        AS nombre_mes,
        ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos_mes
    FROM orders o
    JOIN order_items oi ON o.id_order = oi.id_order
    WHERE o.status = 'completed'
    GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date)
) mensual
ORDER BY anio, mes;


-- Producto más vendido por categoría
SELECT categoria, producto, unidades_vendidas, ingresos
FROM (
    SELECT
        c.name                                         AS categoria,
        p.name                                         AS producto,
        SUM(oi.quantity)                               AS unidades_vendidas,
        ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos,
        RANK() OVER (
            PARTITION BY c.id_category
            ORDER BY SUM(oi.quantity * oi.unit_price) DESC
        )                                              AS rnk
    FROM order_items oi
    JOIN products p   ON oi.id_product  = p.id_product
    JOIN categories c ON p.id_category  = c.id_category
    JOIN orders o     ON oi.id_order    = o.id_order
    WHERE o.status = 'completed'
    GROUP BY c.id_category, c.name, p.id_product, p.name
) ranked
WHERE rnk = 1
ORDER BY ingresos DESC;


-- Clientes inactivos (sin compras en los últimos 6 meses)
SELECT
    c.full_name           AS cliente,
    c.email,
    c.city                AS ciudad,
    MAX(o.order_date)     AS ultima_compra,
    DATEDIFF(CURDATE(), MAX(o.order_date)) AS dias_inactivo
FROM customers c
JOIN orders o ON c.id_customer = o.id_customer
WHERE o.status = 'completed'
GROUP BY c.id_customer, c.full_name, c.email, c.city
HAVING MAX(o.order_date) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY dias_inactivo DESC;


-- Crecimiento de ingresos mes a mes
SELECT
    anio,
    nombre_mes,
    ingresos_mes,
    ingresos_mes_anterior,
    CASE
        WHEN ingresos_mes_anterior IS NULL THEN NULL
        ELSE ROUND((ingresos_mes - ingresos_mes_anterior) * 100.0 / ingresos_mes_anterior, 1)
    END AS crecimiento_pct
FROM (
    SELECT
        YEAR(o.order_date)                             AS anio,
        MONTH(o.order_date)                            AS mes,
        MONTHNAME(o.order_date)                        AS nombre_mes,
        ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos_mes,
        LAG(ROUND(SUM(oi.quantity * oi.unit_price), 2))
            OVER (ORDER BY YEAR(o.order_date), MONTH(o.order_date)) AS ingresos_mes_anterior
    FROM orders o
    JOIN order_items oi ON o.id_order = oi.id_order
    WHERE o.status = 'completed'
    GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date)
) crecimiento
ORDER BY anio, mes;

-- 6. VISTA

-- Vista de ingresos mensuales
CREATE OR REPLACE VIEW vista_ingresos_mensuales AS
SELECT
    YEAR(o.order_date)                             AS anio,
    MONTH(o.order_date)                            AS mes,
    MONTHNAME(o.order_date)                        AS nombre_mes,
    COUNT(DISTINCT o.id_order)                     AS total_ordenes,
    ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS ingresos
FROM orders o
JOIN order_items oi ON o.id_order = oi.id_order
WHERE o.status = 'completed'
GROUP BY YEAR(o.order_date), MONTH(o.order_date), MONTHNAME(o.order_date);

SELECT * FROM vista_ingresos_mensuales ORDER BY anio, mes;


-- 7. STORED PROCEDURE

-- SP que recibe el ID de un vendedor y devuelve su historial de ventas
DELIMITER $$

CREATE PROCEDURE reporte_vendedor(IN p_id_seller INT)
BEGIN
    SELECT
        s.full_name                                    AS vendedor,
        c.full_name                                    AS cliente,
        o.order_date                                   AS fecha,
        ROUND(SUM(oi.quantity * oi.unit_price), 2)     AS total_orden
    FROM orders o
    JOIN sellers s      ON o.id_seller   = s.id_seller
    JOIN customers c    ON o.id_customer = c.id_customer
    JOIN order_items oi ON o.id_order    = oi.id_order
    WHERE o.status = 'completed'
      AND o.id_seller = p_id_seller
    GROUP BY o.id_order, s.full_name, c.full_name, o.order_date
    ORDER BY o.order_date;
END$$

DELIMITER ;

-- Ejemplos de uso:
CALL reporte_vendedor(1); -- Lucía Fernández
CALL reporte_vendedor(2); -- Martín Gómez
