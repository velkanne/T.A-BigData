CREATE DATABASE Lecheria_Paillaco;
GO

USE Lecheria_Paillaco;
GO

CREATE TABLE Vaca (
    ID_Vaca     VARCHAR(10)  NOT NULL,   
    Numero_Vaca SMALLINT     NOT NULL,   
    CONSTRAINT PK_Vaca PRIMARY KEY (ID_Vaca)
);
GO


CREATE TABLE Control_Salud (
    ID_Control      INT           NOT NULL IDENTITY(1,1),
    ID_Vaca         VARCHAR(10)   NOT NULL,
    Fecha_Control   DATE          NOT NULL,
    Temp_Corporal   DECIMAL(4,1)  NOT NULL,   
    Estado_Salud    VARCHAR(20)   NOT NULL,   
    CONSTRAINT PK_Control_Salud PRIMARY KEY (ID_Control),
    CONSTRAINT FK_CS_Vaca        FOREIGN KEY (ID_Vaca) REFERENCES Vaca(ID_Vaca),
    CONSTRAINT CK_Temp           CHECK (Temp_Corporal BETWEEN 35.0 AND 42.0),
    CONSTRAINT CK_Estado         CHECK (Estado_Salud IN ('Saludable','En Observacion','Tratamiento'))
);
GO

CREATE TABLE Produccion_Leche (
    ID_Produccion   INT           NOT NULL IDENTITY(1,1),
    ID_Vaca         VARCHAR(10)   NOT NULL,
    Fecha_Control   DATE          NOT NULL,
    Litros_Leche    DECIMAL(6,2)  NOT NULL,   -- Permite decimales (Ej: 22.79)
    CONSTRAINT PK_Produccion_Leche PRIMARY KEY (ID_Produccion),
    CONSTRAINT FK_PL_Vaca          FOREIGN KEY (ID_Vaca) REFERENCES Vaca(ID_Vaca),
    CONSTRAINT CK_Litros           CHECK (Litros_Leche >= 0)
);
GO


INSERT INTO Vaca (ID_Vaca, Numero_Vaca) VALUES
('VACA-100', 100), ('VACA-110', 110), ('VACA-111', 111),
('VACA-112', 112), ('VACA-119', 119), ('VACA-120', 120),
('VACA-121', 121), ('VACA-123', 123), ('VACA-129', 129),
('VACA-132', 132), ('VACA-133', 133), ('VACA-137', 137),
('VACA-138', 138), ('VACA-139', 139), ('VACA-142', 142),
('VACA-147', 147), ('VACA-149', 149), ('VACA-150', 150);
GO

CREATE TABLE #CSV_Raw (
    ID_Vaca       VARCHAR(10),
    Fecha_Control DATE,
    Litros_Leche  DECIMAL(6,2),
    Temp_Corporal DECIMAL(4,1),
    Estado_Salud  VARCHAR(20)
);
GO

INSERT INTO #CSV_Raw VALUES
('VACA-138','2026-03-11',17.6,39.0,'Tratamiento'),
('VACA-112','2026-03-02',16.6,38.2,'Saludable'),
('VACA-133','2026-03-16',15.4,38.1,'En Observacion'),
('VACA-129','2026-03-15',23.1,37.5,'Tratamiento'),
('VACA-137','2026-03-24',38.7,37.9,'Tratamiento'),
('VACA-111','2026-03-13',19.9,39.4,'Tratamiento'),
('VACA-142','2026-03-26',38.2,37.6,'En Observacion'),
('VACA-110','2026-03-21',22.0,38.2,'Saludable'),
('VACA-110','2026-03-14',35.7,38.0,'En Observacion'),
('VACA-111','2026-03-28',27.0,37.8,'Tratamiento'),
('VACA-137','2026-03-19',18.1,39.2,'Saludable'),
('VACA-119','2026-03-27',30.5,38.5,'Saludable'),
('VACA-120','2026-03-12',17.2,37.7,'En Observacion'),
('VACA-119','2026-03-26',32.4,39.4,'En Observacion'),
('VACA-129','2026-03-23',22.8,39.2,'Saludable'),
('VACA-133','2026-03-26',34.1,38.7,'En Observacion'),
('VACA-123','2026-03-27',36.3,38.6,'Saludable'),
('VACA-121','2026-03-21',27.1,37.8,'Saludable'),
('VACA-111','2026-03-26',21.6,38.0,'Saludable'),
('VACA-121','2026-03-27',18.5,38.9,'En Observacion'),
('VACA-132','2026-03-26',18.7,38.6,'Saludable'),
('VACA-149','2026-03-14',29.3,39.1,'Saludable'),
('VACA-112','2026-03-11',27.9,37.8,'En Observacion'),
('VACA-138','2026-03-01',38.9,39.4,'Saludable'),
('VACA-142','2026-03-26',0.04,39.1,'Saludable'),
('VACA-111','2026-03-27',22.2,38.1,'Saludable'),
('VACA-138','2026-03-20',36.0,38.1,'Saludable'),
('VACA-111','2026-03-26',26.2,39.0,'En Observacion'),
('VACA-120','2026-03-26',20.8,38.7,'En Observacion'),
('VACA-149','2026-03-26',35.9,37.7,'En Observacion'),
('VACA-132','2026-03-27',37.9,39.3,'Saludable'),
('VACA-137','2026-03-26',27.7,38.9,'En Observacion'),
('VACA-138','2026-03-06',33.1,38.7,'En Observacion'),
('VACA-142','2026-03-05',32.4,37.7,'Saludable'),
('VACA-147','2026-03-25',25.4,39.4,'Saludable'),
('VACA-138','2026-03-16',33.8,37.6,'En Observacion'),
('VACA-147','2026-03-26',35.1,39.3,'En Observacion'),
('VACA-138','2026-03-21',15.7,38.6,'En Observacion'),
('VACA-138','2026-03-27',34.5,37.7,'Tratamiento'),
('VACA-149','2026-03-07',36.5,38.8,'Tratamiento'),
('VACA-137','2026-03-03',27.2,37.6,'Saludable'),
('VACA-138','2026-03-26',36.2,39.0,'En Observacion'),
('VACA-137','2026-03-26',39.0,37.5,'Saludable'),
('VACA-111','2026-03-15',37.6,38.4,'Tratamiento'),
('VACA-138','2026-03-20',15.9,39.0,'Saludable'),
('VACA-137','2026-03-18',34.0,39.1,'En Observacion'),
('VACA-147','2026-03-18',38.0,38.7,'Tratamiento'),
('VACA-123','2026-03-15',29.1,38.6,'Saludable'),
('VACA-147','2026-03-05',23.8,38.5,'Saludable'),
('VACA-110','2026-03-24',15.2,37.8,'En Observacion'),
('VACA-137','2026-03-17',27.3,39.2,'Tratamiento'),
('VACA-147','2026-03-11',31.3,37.8,'En Observacion'),
('VACA-139','2026-03-26',26.5,38.8,'Saludable'),
('VACA-138','2026-03-04',31.8,38.2,'Saludable'),
('VACA-100','2026-03-13',17.2,37.9,'Saludable'),
('VACA-123','2026-03-28',36.3,39.5,'En Observacion'),
('VACA-142','2026-03-23',21.4,39.3,'Saludable'),
('VACA-120','2026-03-26',32.6,38.0,'Tratamiento'),
('VACA-138','2026-03-26',21.1,38.5,'En Observacion'),
('VACA-138','2026-03-26',31.7,37.8,'En Observacion'),
('VACA-120','2026-03-11',20.6,38.5,'Saludable'),
('VACA-137','2026-03-05',30.1,38.1,'Tratamiento'),
('VACA-100','2026-03-26',21.0,38.2,'En Observacion'),
('VACA-123','2026-03-24',30.8,38.1,'Saludable'),
('VACA-149','2026-03-28',28.8,37.9,'En Observacion'),
('VACA-138','2026-03-28',31.0,38.6,'En Observacion'),
('VACA-149','2026-03-17',16.9,39.3,'En Observacion'),
('VACA-100','2026-03-23',39.3,38.2,'Saludable'),
('VACA-100','2026-03-22',26.0,38.5,'En Observacion'),
('VACA-120','2026-03-26',23.6,39.0,'Saludable'),
('VACA-150','2026-03-26',34.6,38.1,'En Observacion'),
('VACA-119','2026-03-21',18.2,38.6,'En Observacion'),
('VACA-137','2026-03-22',32.5,39.4,'Saludable'),
('VACA-149','2026-03-09',20.1,39.1,'En Observacion'),
('VACA-100','2026-03-01',25.1,38.1,'En Observacion'),
('VACA-112','2026-03-01',21.5,37.5,'En Observacion'),
('VACA-112','2026-03-04',23.7,38.0,'Saludable'),
('VACA-142','2026-03-18',21.3,38.2,'En Observacion'),
('VACA-133','2026-03-08',19.4,39.5,'En Observacion'),
('VACA-138','2026-03-02',21.9,38.8,'En Observacion'),
('VACA-112','2026-03-21',21.5,38.8,'Saludable'),
('VACA-138','2026-03-18',33.3,37.9,'En Observacion'),
('VACA-132','2026-03-11',36.9,39.0,'Saludable'),
('VACA-139','2026-03-26',35.7,38.2,'Saludable'),
('VACA-121','2026-03-11',39.8,37.8,'Saludable'),
('VACA-133','2026-03-07',30.4,38.7,'Saludable'),
('VACA-100','2026-03-01',15.1,38.7,'Saludable'),
('VACA-138','2026-03-25',22.6,39.1,'Saludable'),
('VACA-123','2026-03-19',35.5,39.3,'Saludable'),
('VACA-119','2026-03-26',37.8,38.5,'Saludable'),
('VACA-100','2026-03-26',15.5,39.0,'Saludable'),
('VACA-111','2026-03-14',21.6,39.4,'Tratamiento'),
('VACA-138','2026-03-05',28.0,38.8,'Saludable'),
('VACA-139','2026-03-18',35.9,37.6,'Saludable'),
('VACA-138','2026-03-03',18.9,39.3,'Tratamiento'),
('VACA-112','2026-03-26',38.6,37.6,'Saludable'),
('VACA-149','2026-03-03',23.3,39.5,'Saludable'),
('VACA-119','2026-03-16',18.2,39.4,'En Observacion'),
('VACA-121','2026-03-02',18.3,38.8,'Saludable'),
('VACA-112','2026-03-16',22.79,38.8,'En Observacion'),
('VACA-138','2026-03-26',34.3,38.2,'En Observacion'),
('VACA-139','2026-03-06',15.9,38.2,'Tratamiento'),
('VACA-132','2026-03-10',28.3,37.5,'Tratamiento'),
('VACA-119','2026-03-06',15.8,38.7,'Saludable'),
('VACA-132','2026-03-07',34.1,38.3,'Tratamiento'),
('VACA-121','2026-03-04',21.9,37.9,'En Observacion'),
('VACA-149','2026-03-20',35.1,38.8,'En Observacion'),
('VACA-137','2026-03-26',15.1,38.8,'En Observacion'),
('VACA-138','2026-03-07',25.7,38.2,'Saludable'),
('VACA-121','2026-03-18',26.9,39.3,'En Observacion'),
('VACA-147','2026-03-06',27.0,39.2,'Saludable'),
('VACA-138','2026-03-24',16.5,37.9,'En Observacion'),
('VACA-111','2026-03-19',32.5,39.1,'En Observacion'),
('VACA-112','2026-03-18',23.9,38.8,'Saludable'),
('VACA-137','2026-03-02',39.8,38.3,'En Observacion'),
('VACA-121','2026-03-26',37.8,39.2,'Saludable'),
('VACA-111','2026-03-08',35.6,37.7,'En Observacion'),
('VACA-120','2026-03-28',17.5,38.7,'En Observacion'),
('VACA-142','2026-03-06',33.9,38.4,'Saludable'),
('VACA-133','2026-03-26',17.6,38.7,'Tratamiento'),
('VACA-121','2026-03-04',27.5,37.8,'Saludable'),
('VACA-138','2026-03-26',30.7,39.0,'Tratamiento'),
('VACA-149','2026-03-07',19.6,39.1,'En Observacion'),
('VACA-111','2026-03-26',28.9,38.3,'En Observacion'),
('VACA-132','2026-03-05',22.0,37.8,'En Observacion'),
('VACA-147','2026-03-26',15.6,38.2,'Saludable'),
('VACA-138','2026-03-03',31.7,37.7,'Saludable'),
('VACA-149','2026-03-26',15.7,39.4,'En Observacion'),
('VACA-120','2026-03-17',37.5,37.8,'Saludable'),
('VACA-123','2026-03-26',24.3,37.7,'En Observacion'),
('VACA-129','2026-03-07',36.2,39.4,'En Observacion'),
('VACA-119','2026-03-26',23.8,38.4,'Saludable'),
('VACA-138','2026-03-14',18.2,37.9,'Saludable'),
('VACA-119','2026-03-20',21.7,38.1,'En Observacion'),
('VACA-129','2026-03-26',15.0,38.6,'En Observacion'),
('VACA-138','2026-03-22',38.2,37.5,'Tratamiento'),
('VACA-111','2026-03-19',15.9,38.8,'En Observacion'),
('VACA-111','2026-03-26',33.0,39.4,'En Observacion'),
('VACA-147','2026-03-24',28.6,38.2,'Saludable'),
('VACA-137','2026-03-03',38.4,38.7,'Saludable'),
('VACA-120','2026-03-19',22.1,38.2,'Saludable'),
('VACA-142','2026-03-08',32.7,39.3,'En Observacion'),
('VACA-139','2026-03-26',15.2,39.3,'Saludable'),
('VACA-112','2026-03-06',21.9,38.2,'Saludable'),
('VACA-100','2026-03-25',34.6,39.3,'Tratamiento'),
('VACA-100','2026-03-25',34.6,39.1,'En Observacion'),
('VACA-147','2026-03-14',19.5,38.3,'Saludable'),
('VACA-121','2026-03-26',15.3,38.7,'En Observacion'),
('VACA-150','2026-03-26',31.7,38.6,'Tratamiento'),
('VACA-120','2026-03-10',21.5,38.4,'En Observacion'),
('VACA-149','2026-03-12',39.1,38.6,'Saludable'),
('VACA-150','2026-03-25',34.6,39.0,'Saludable'),
('VACA-138','2026-03-20',39.3,37.8,'Tratamiento'),
('VACA-110','2026-03-14',35.8,37.8,'Saludable'),
('VACA-100','2026-03-24',35.8,38.4,'En Observacion'),
('VACA-138','2026-03-26',15.7,38.5,'En Observacion'),
('VACA-121','2026-03-26',17.8,37.9,'Saludable'),
('VACA-100','2026-03-10',24.7,39.2,'En Observacion'),
('VACA-121','2026-03-26',17.1,37.8,'Saludable'),
('VACA-120','2026-03-14',29.5,38.2,'Tratamiento'),
('VACA-111','2026-03-02',31.5,37.5,'Saludable'),
('VACA-132','2026-03-26',23.1,38.1,'En Observacion'),
('VACA-138','2026-03-06',34.5,38.8,'En Observacion'),
('VACA-129','2026-03-02',17.8,38.7,'Saludable'),
('VACA-123','2026-03-14',19.5,38.4,'En Observacion'),
('VACA-121','2026-03-02',21.0,38.0,'Saludable'),
('VACA-120','2026-03-25',34.4,38.8,'Saludable'),
('VACA-111','2026-03-26',31.1,38.3,'En Observacion'),
('VACA-111','2026-03-26',29.9,39.1,'En Observacion'),
('VACA-139','2026-03-21',25.2,39.2,'Saludable'),
('VACA-111','2026-03-27',21.7,37.8,'En Observacion'),
('VACA-112','2026-03-23',37.5,39.0,'Tratamiento'),
('VACA-123','2026-03-26',19.8,39.3,'Saludable'),
('VACA-100','2026-03-06',19.9,38.1,'En Observacion'),
('VACA-132','2026-03-27',15.1,38.0,'En Observacion'),
('VACA-139','2026-03-06',32.4,39.2,'En Observacion'),
('VACA-123','2026-03-14',28.4,39.1,'En Observacion'),
('VACA-120','2026-03-17',32.8,38.7,'Saludable'),
('VACA-123','2026-03-07',29.5,38.2,'En Observacion'),
('VACA-111','2026-03-26',36.9,39.1,'Saludable'),
('VACA-111','2026-03-19',15.8,39.2,'Saludable'),
('VACA-100','2026-03-18',31.8,37.5,'En Observacion'),
('VACA-112','2026-03-21',16.0,38.0,'Tratamiento'),
('VACA-133','2026-03-14',16.8,39.1,'Saludable'),
('VACA-121','2026-03-26',30.4,39.2,'En Observacion'),
('VACA-120','2026-03-15',21.6,38.6,'En Observacion');
GO


INSERT INTO Control_Salud (ID_Vaca, Fecha_Control, Temp_Corporal, Estado_Salud)
SELECT ID_Vaca, Fecha_Control, Temp_Corporal, Estado_Salud
FROM #CSV_Raw;
GO

INSERT INTO Produccion_Leche (ID_Vaca, Fecha_Control, Litros_Leche)
SELECT ID_Vaca, Fecha_Control, Litros_Leche
FROM #CSV_Raw;
GO

DROP TABLE #CSV_Raw;
GO

SELECT 'Vaca'             AS Tabla, COUNT(*) AS Filas FROM Vaca
UNION ALL
SELECT 'Control_Salud',             COUNT(*)          FROM Control_Salud
UNION ALL
SELECT 'Produccion_Leche',          COUNT(*)          FROM Produccion_Leche;
GO

SELECT 'sqlserver' dbms,t.TABLE_CATALOG,t.TABLE_SCHEMA,t.TABLE_NAME,c.COLUMN_NAME,c.ORDINAL_POSITION,c.DATA_TYPE,c.CHARACTER_MAXIMUM_LENGTH,n.CONSTRAINT_TYPE,k2.TABLE_SCHEMA,k2.TABLE_NAME,k2.COLUMN_NAME FROM INFORMATION_SCHEMA.TABLES t LEFT JOIN INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_CATALOG=c.TABLE_CATALOG AND t.TABLE_SCHEMA=c.TABLE_SCHEMA AND t.TABLE_NAME=c.TABLE_NAME LEFT JOIN(INFORMATION_SCHEMA.KEY_COLUMN_USAGE k JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS n ON k.CONSTRAINT_CATALOG=n.CONSTRAINT_CATALOG AND k.CONSTRAINT_SCHEMA=n.CONSTRAINT_SCHEMA AND k.CONSTRAINT_NAME=n.CONSTRAINT_NAME LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS r ON k.CONSTRAINT_CATALOG=r.CONSTRAINT_CATALOG AND k.CONSTRAINT_SCHEMA=r.CONSTRAINT_SCHEMA AND k.CONSTRAINT_NAME=r.CONSTRAINT_NAME)ON c.TABLE_CATALOG=k.TABLE_CATALOG AND c.TABLE_SCHEMA=k.TABLE_SCHEMA AND c.TABLE_NAME=k.TABLE_NAME AND c.COLUMN_NAME=k.COLUMN_NAME LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE k2 ON k.ORDINAL_POSITION=k2.ORDINAL_POSITION AND r.UNIQUE_CONSTRAINT_CATALOG=k2.CONSTRAINT_CATALOG AND r.UNIQUE_CONSTRAINT_SCHEMA=k2.CONSTRAINT_SCHEMA AND r.UNIQUE_CONSTRAINT_NAME=k2.CONSTRAINT_NAME WHERE t.TABLE_TYPE='BASE TABLE';