-- ============================================================
--  BASE DE DATOS: Monitoreo Lechería Paillaco
--  Origen: monitoreo_lecheria_paillaco_LIMPIO.csv
--  Fecha generación: 2026-03-17
--  Motor compatible: MySQL 8+ / MariaDB / PostgreSQL (ANSI SQL)
-- ============================================================

-- ── CREACIÓN DE BASE DE DATOS ────────────────────────────────
CREATE DATABASE IF NOT EXISTS lecheria_paillaco
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE lecheria_paillaco;

-- ── TABLA 1: VACAS (catálogo) ─────────────────────────────────
-- Entidad base: cada vaca registrada en el sistema
CREATE TABLE IF NOT EXISTS vacas (
    id_vaca      VARCHAR(20)  NOT NULL,
    CONSTRAINT pk_vacas PRIMARY KEY (id_vaca)
);

-- ── TABLA 2: ESTADOS DE SALUD (catálogo) ─────────────────────
CREATE TABLE IF NOT EXISTS estados_salud (
    id_estado    TINYINT      NOT NULL AUTO_INCREMENT,
    descripcion  VARCHAR(50)  NOT NULL UNIQUE,
    CONSTRAINT pk_estados PRIMARY KEY (id_estado)
);

-- ── TABLA 3: REGISTROS DE CONTROL (tabla de hechos) ───────────
CREATE TABLE IF NOT EXISTS registros_control (
    id_registro    INT           NOT NULL AUTO_INCREMENT,
    id_vaca        VARCHAR(20)   NOT NULL,
    fecha_control  DATE          NOT NULL,
    litros_leche   DECIMAL(6,2)  NULL,          -- NULL permitido (imputado en preprocesamiento)
    temp_corporal  DECIMAL(5,2)  NULL,
    id_estado      TINYINT       NOT NULL,
    CONSTRAINT pk_registros   PRIMARY KEY (id_registro),
    CONSTRAINT fk_vaca        FOREIGN KEY (id_vaca)   REFERENCES vacas(id_vaca),
    CONSTRAINT fk_estado      FOREIGN KEY (id_estado) REFERENCES estados_salud(id_estado),
    CONSTRAINT chk_litros     CHECK (litros_leche IS NULL OR litros_leche >= 0),
    CONSTRAINT chk_temp       CHECK (temp_corporal IS NULL OR (temp_corporal BETWEEN 35.0 AND 42.0))
);

-- ── ÍNDICES ───────────────────────────────────────────────────
CREATE INDEX idx_fecha   ON registros_control (fecha_control);
CREATE INDEX idx_vaca    ON registros_control (id_vaca);
CREATE INDEX idx_estado  ON registros_control (id_estado);

-- ============================================================
--  DATOS
-- ============================================================

-- ── Estados de salud ─────────────────────────────────────────
INSERT INTO estados_salud (descripcion) VALUES
    ('Saludable'),
    ('En Observacion'),
    ('Tratamiento');

-- ── Vacas (18 animales únicos) ────────────────────────────────
INSERT INTO vacas (id_vaca) VALUES
    ('VACA-100'), ('VACA-110'), ('VACA-111'), ('VACA-112'),
    ('VACA-119'), ('VACA-120'), ('VACA-121'), ('VACA-123'),
    ('VACA-129'), ('VACA-132'), ('VACA-133'), ('VACA-137'),
    ('VACA-138'), ('VACA-139'), ('VACA-142'), ('VACA-147'),
    ('VACA-149'), ('VACA-150');

-- ── Registros de control (186 filas) ─────────────────────────
-- Columnas: id_vaca, fecha_control, litros_leche, temp_corporal, id_estado
-- id_estado: 1=Saludable  2=En Observacion  3=Tratamiento
INSERT INTO registros_control (id_vaca, fecha_control, litros_leche, temp_corporal, id_estado) VALUES
('VACA-138','2026-03-11',17.60,39.0,3),
('VACA-112','2026-03-02',16.60,38.2,1),
('VACA-133','2026-03-16',15.40,38.1,2),
('VACA-129','2026-03-15',23.10,37.5,3),
('VACA-137','2026-03-24',38.70,37.9,3),
('VACA-111','2026-03-13',19.90,39.4,3),
('VACA-142','2026-03-26',38.20,37.6,2),
('VACA-110','2026-03-21',22.00,38.2,1),
('VACA-110','2026-03-14',35.70,38.0,2),
('VACA-111','2026-03-28',27.00,37.8,3),
('VACA-137','2026-03-19',18.10,39.2,1),
('VACA-119','2026-03-27',30.50,38.5,1),
('VACA-120','2026-03-12',17.20,37.7,2),
('VACA-119','2026-03-26',32.40,39.4,2),
('VACA-129','2026-03-23',22.80,39.2,1),
('VACA-133','2026-03-26',34.10,38.7,2),
('VACA-123','2026-03-27',36.30,38.6,1),
('VACA-121','2026-03-21',27.10,37.8,1),
('VACA-111','2026-03-26',21.60,38.0,1),
('VACA-121','2026-03-27',18.50,38.9,2),
('VACA-132','2026-03-26',18.70,38.6,1),
('VACA-149','2026-03-14',29.30,39.1,1),
('VACA-112','2026-03-11',27.90,37.8,2),
('VACA-138','2026-03-01',38.90,39.4,1),
('VACA-142','2026-03-26', 0.04,39.1,1),
('VACA-111','2026-03-27',22.20,38.1,1),
('VACA-138','2026-03-20',36.00,38.1,1),
('VACA-111','2026-03-26',26.20,39.0,2),
('VACA-120','2026-03-26',20.80,38.7,2),
('VACA-149','2026-03-26',35.90,37.7,2),
('VACA-132','2026-03-27',37.90,39.3,1),
('VACA-137','2026-03-26',27.70,38.9,2),
('VACA-138','2026-03-06',33.10,38.7,2),
('VACA-142','2026-03-05',32.40,37.7,1),
('VACA-147','2026-03-25',25.40,39.4,1),
('VACA-138','2026-03-16',33.80,37.6,2),
('VACA-147','2026-03-26',35.10,39.3,2),
('VACA-138','2026-03-21',15.70,38.6,2),
('VACA-138','2026-03-27',34.50,37.7,3),
('VACA-149','2026-03-07',36.50,38.8,3),
('VACA-137','2026-03-03',27.20,37.6,1),
('VACA-138','2026-03-26',36.20,39.0,2),
('VACA-137','2026-03-26',39.00,37.5,1),
('VACA-111','2026-03-15',37.60,38.4,3),
('VACA-138','2026-03-20',15.90,39.0,1),
('VACA-137','2026-03-18',34.00,39.1,2),
('VACA-147','2026-03-18',38.00,38.7,3),
('VACA-123','2026-03-15',29.10,38.6,1),
('VACA-147','2026-03-05',23.80,38.5,1),
('VACA-110','2026-03-24',15.20,37.8,2),
('VACA-137','2026-03-17',27.30,39.2,3),
('VACA-147','2026-03-11',31.30,37.8,2),
('VACA-139','2026-03-26',26.50,38.8,1),
('VACA-138','2026-03-04',31.80,38.2,1),
('VACA-100','2026-03-13',17.20,37.9,1),
('VACA-123','2026-03-28',36.30,39.5,2),
('VACA-142','2026-03-23',21.40,39.3,1),
('VACA-120','2026-03-26',32.60,38.0,3),
('VACA-138','2026-03-26',21.10,38.5,2),
('VACA-138','2026-03-26',31.70,37.8,2),
('VACA-120','2026-03-11',20.60,38.5,1),
('VACA-137','2026-03-05',30.10,38.1,3),
('VACA-100','2026-03-26',21.00,38.2,2),
('VACA-123','2026-03-24',30.80,38.1,1),
('VACA-149','2026-03-28',28.80,37.9,2),
('VACA-138','2026-03-28',31.00,38.6,2),
('VACA-149','2026-03-17',16.90,39.3,2),
('VACA-100','2026-03-23',39.30,38.2,1),
('VACA-100','2026-03-22',26.00,38.5,2),
('VACA-120','2026-03-26',23.60,39.0,1),
('VACA-150','2026-03-26',34.60,38.1,2),
('VACA-119','2026-03-21',18.20,38.6,2),
('VACA-137','2026-03-22',32.50,39.4,1),
('VACA-149','2026-03-09',20.10,39.1,2),
('VACA-100','2026-03-01',25.10,38.1,2),
('VACA-112','2026-03-01',21.50,37.5,2),
('VACA-112','2026-03-04',23.70,38.0,1),
('VACA-142','2026-03-18',21.30,38.2,2),
('VACA-133','2026-03-08',19.40,39.5,2),
('VACA-138','2026-03-02',21.90,38.8,2),
('VACA-112','2026-03-21',21.50,38.8,1),
('VACA-138','2026-03-18',33.30,37.9,2),
('VACA-132','2026-03-11',36.90,39.0,1),
('VACA-139','2026-03-26',35.70,38.2,1),
('VACA-121','2026-03-11',39.80,37.8,1),
('VACA-133','2026-03-07',30.40,38.7,1),
('VACA-100','2026-03-01',15.10,38.7,1),
('VACA-138','2026-03-25',22.60,39.1,1),
('VACA-123','2026-03-19',35.50,39.3,1),
('VACA-119','2026-03-26',37.80,38.5,1),
('VACA-100','2026-03-26',15.50,39.0,1),
('VACA-111','2026-03-14',21.60,39.4,3),
('VACA-138','2026-03-05',28.00,38.8,1),
('VACA-139','2026-03-18',35.90,37.6,1),
('VACA-138','2026-03-03',18.90,39.3,3),
('VACA-112','2026-03-26',38.60,37.6,1),
('VACA-149','2026-03-03',23.30,39.5,1),
('VACA-119','2026-03-16',18.20,39.4,2),
('VACA-121','2026-03-02',18.30,38.8,1),
('VACA-112','2026-03-16',22.79,38.8,2),
('VACA-138','2026-03-26',34.30,38.2,2),
('VACA-139','2026-03-06',15.90,38.2,3),
('VACA-132','2026-03-10',28.30,37.5,3),
('VACA-119','2026-03-06',15.80,38.7,1),
('VACA-132','2026-03-07',34.10,38.3,3),
('VACA-121','2026-03-04',21.90,37.9,2),
('VACA-149','2026-03-20',35.10,38.8,2),
('VACA-137','2026-03-26',15.10,38.8,2),
('VACA-138','2026-03-07',25.70,38.2,1),
('VACA-121','2026-03-18',26.90,39.3,2),
('VACA-147','2026-03-06',27.00,39.2,1),
('VACA-138','2026-03-24',16.50,37.9,2),
('VACA-111','2026-03-19',32.50,39.1,2),
('VACA-112','2026-03-18',23.90,38.8,1),
('VACA-137','2026-03-02',39.80,38.3,2),
('VACA-121','2026-03-26',37.80,39.2,1),
('VACA-111','2026-03-08',35.60,37.7,2),
('VACA-120','2026-03-28',17.50,38.7,2),
('VACA-142','2026-03-06',33.90,38.4,1),
('VACA-133','2026-03-26',17.60,38.7,3),
('VACA-121','2026-03-04',27.50,37.8,1),
('VACA-138','2026-03-26',30.70,39.0,3),
('VACA-149','2026-03-07',19.60,39.1,2),
('VACA-111','2026-03-26',28.90,38.3,2),
('VACA-132','2026-03-05',22.00,37.8,2),
('VACA-147','2026-03-26',15.60,38.2,1),
('VACA-138','2026-03-03',31.70,37.7,1),
('VACA-149','2026-03-26',15.70,39.4,2),
('VACA-120','2026-03-17',37.50,37.8,1),
('VACA-123','2026-03-26',24.30,37.7,2),
('VACA-129','2026-03-07',36.20,39.4,2),
('VACA-119','2026-03-26',23.80,38.4,1),
('VACA-138','2026-03-14',18.20,37.9,1),
('VACA-119','2026-03-20',21.70,38.1,2),
('VACA-129','2026-03-26',15.00,38.6,2),
('VACA-138','2026-03-22',38.20,37.5,3),
('VACA-111','2026-03-19',15.90,38.8,2),
('VACA-111','2026-03-26',33.00,39.4,2),
('VACA-147','2026-03-24',28.60,38.2,1),
('VACA-137','2026-03-03',38.40,38.7,1),
('VACA-120','2026-03-19',22.10,38.2,1),
('VACA-142','2026-03-08',32.70,39.3,2),
('VACA-139','2026-03-26',15.20,39.3,1),
('VACA-112','2026-03-06',21.90,38.2,1),
('VACA-100','2026-03-25',34.60,39.3,3),
('VACA-100','2026-03-25',34.60,39.1,2),
('VACA-147','2026-03-14',19.50,38.3,1),
('VACA-121','2026-03-26',15.30,38.7,2),
('VACA-150','2026-03-26',31.70,38.6,3),
('VACA-120','2026-03-10',21.50,38.4,2),
('VACA-149','2026-03-12',39.10,38.6,1),
('VACA-150','2026-03-25',34.60,39.0,1),
('VACA-138','2026-03-20',39.30,37.8,3),
('VACA-110','2026-03-14',35.80,37.8,1),
('VACA-100','2026-03-24',35.80,38.4,2),
('VACA-138','2026-03-26',15.70,38.5,2),
('VACA-121','2026-03-26',17.80,37.9,1),
('VACA-100','2026-03-10',24.70,39.2,2),
('VACA-121','2026-03-26',17.10,37.8,1),
('VACA-120','2026-03-14',29.50,38.2,3),
('VACA-111','2026-03-02',31.50,37.5,1),
('VACA-132','2026-03-26',23.10,38.1,2),
('VACA-138','2026-03-06',34.50,38.8,2),
('VACA-129','2026-03-02',17.80,38.7,1),
('VACA-123','2026-03-14',19.50,38.4,2),
('VACA-121','2026-03-02',21.00,38.0,1),
('VACA-120','2026-03-25',34.40,38.8,1),
('VACA-111','2026-03-26',31.10,38.3,2),
('VACA-111','2026-03-26',29.90,39.1,2),
('VACA-139','2026-03-21',25.20,39.2,1),
('VACA-111','2026-03-27',21.70,37.8,2),
('VACA-112','2026-03-23',37.50,39.0,3),
('VACA-123','2026-03-26',19.80,39.3,1),
('VACA-100','2026-03-06',19.90,38.1,2),
('VACA-132','2026-03-27',15.10,38.0,2),
('VACA-139','2026-03-06',32.40,39.2,2),
('VACA-123','2026-03-14',28.40,39.1,2),
('VACA-120','2026-03-17',32.80,38.7,1),
('VACA-123','2026-03-07',29.50,38.2,2),
('VACA-111','2026-03-26',36.90,39.1,1),
('VACA-111','2026-03-19',15.80,39.2,1),
('VACA-100','2026-03-18',31.80,37.5,2),
('VACA-112','2026-03-21',16.00,38.0,3),
('VACA-133','2026-03-14',16.80,39.1,1),
('VACA-121','2026-03-26',30.40,39.2,2),
('VACA-120','2026-03-15',21.60,38.6,2);

-- ============================================================
--  VISTAS ANALÍTICAS
-- ============================================================

-- Resumen por vaca: conteo, promedio litros, promedio temp, estados
CREATE OR REPLACE VIEW v_resumen_por_vaca AS
SELECT
    v.id_vaca,
    COUNT(r.id_registro)                                          AS total_registros,
    ROUND(AVG(r.litros_leche),2)                                  AS prom_litros,
    ROUND(MIN(r.litros_leche),2)                                  AS min_litros,
    ROUND(MAX(r.litros_leche),2)                                  AS max_litros,
    ROUND(AVG(r.temp_corporal),2)                                 AS prom_temp,
    SUM(CASE WHEN e.descripcion='Saludable'       THEN 1 ELSE 0 END) AS cnt_saludable,
    SUM(CASE WHEN e.descripcion='En Observacion'  THEN 1 ELSE 0 END) AS cnt_observacion,
    SUM(CASE WHEN e.descripcion='Tratamiento'     THEN 1 ELSE 0 END) AS cnt_tratamiento
FROM vacas v
JOIN registros_control r ON r.id_vaca = v.id_vaca
JOIN estados_salud e     ON e.id_estado = r.id_estado
GROUP BY v.id_vaca
ORDER BY total_registros DESC;

-- Resumen diario: producción total y promedio por fecha
CREATE OR REPLACE VIEW v_produccion_diaria AS
SELECT
    fecha_control,
    COUNT(*)                        AS registros_dia,
    ROUND(SUM(litros_leche),2)      AS total_litros,
    ROUND(AVG(litros_leche),2)      AS prom_litros,
    ROUND(AVG(temp_corporal),2)     AS prom_temp
FROM registros_control
GROUP BY fecha_control
ORDER BY fecha_control;

-- Animales actualmente en estado crítico (Tratamiento)
CREATE OR REPLACE VIEW v_en_tratamiento AS
SELECT
    r.id_vaca,
    r.fecha_control,
    r.litros_leche,
    r.temp_corporal
FROM registros_control r
JOIN estados_salud e ON e.id_estado = r.id_estado
WHERE e.descripcion = 'Tratamiento'
ORDER BY r.fecha_control DESC, r.id_vaca;

-- ============================================================
--  CONSULTAS DE EJEMPLO
-- ============================================================
-- 1. Top 5 vacas por producción promedio:
--    SELECT id_vaca, prom_litros FROM v_resumen_por_vaca ORDER BY prom_litros DESC LIMIT 5;
--
-- 2. Días con mayor producción total:
--    SELECT * FROM v_produccion_diaria ORDER BY total_litros DESC LIMIT 10;
--
-- 3. Porcentaje de registros por estado:
--    SELECT e.descripcion, COUNT(*) AS total,
--           ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM registros_control),1) AS pct
--    FROM registros_control r JOIN estados_salud e ON e.id_estado=r.id_estado
--    GROUP BY e.descripcion;
--
-- 4. Vacas con temperatura promedio más alta:
--    SELECT id_vaca, prom_temp FROM v_resumen_por_vaca ORDER BY prom_temp DESC LIMIT 5;
-- ============================================================
