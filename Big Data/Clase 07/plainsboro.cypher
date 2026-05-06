// 1. Comandos de Sistema (Ejecutar en la base de datos 'system' para instanciar el entorno)
CREATE DATABASE princeton_plainsboro IF NOT EXISTS;

// 2. Conexión al entorno (Ejecutar el resto de las consultas en la base de datos 'princeton_plainsboro')
:use princeton_plainsboro;

// 3. Creación de Esquema: Restricciones de Unicidad
CREATE CONSTRAINT constraint_paciente_id IF NOT EXISTS FOR (p:Paciente) REQUIRE p.id IS UNIQUE;
CREATE CONSTRAINT constraint_doctor_id IF NOT EXISTS FOR (d:Doctor) REQUIRE d.id IS UNIQUE;
CREATE CONSTRAINT constraint_enfermera_id IF NOT EXISTS FOR (e:Enfermera) REQUIRE e.id IS UNIQUE;
CREATE CONSTRAINT constraint_departamento_id IF NOT EXISTS FOR (dep:Departamento) REQUIRE dep.id IS UNIQUE;

// 4. Creación de Esquema: Índices
CREATE INDEX index_paciente_grupo IF NOT EXISTS FOR (p:Paciente) ON (p.grupo_sanguineo);
CREATE INDEX index_doctor_rol IF NOT EXISTS FOR (d:Doctor) ON (d.rol);

// 5. Creación de Nodos Catálogo (Entidades Estáticas - Universo Dr. House)
UNWIND [
  {id: "DEP_01", nombre: "Diagnóstico Médico"}, {id: "DEP_02", nombre: "Oncología"},
  {id: "DEP_03", nombre: "Clínica de Atención Primaria"}, {id: "DEP_04", nombre: "Administración"},
  {id: "DEP_05", nombre: "Neurología"}, {id: "DEP_06", nombre: "Inmunología"},
  {id: "DEP_07", nombre: "Cuidados Intensivos"}, {id: "DEP_08", nombre: "Cirugía"}
] AS depto
CREATE (:Departamento {id: depto.id, nombre: depto.nombre});

UNWIND [
  "Vicodin", "Metadona", "Interferón", "Prednisona", "Antibióticos de Amplio Espectro",
  "Esteroides", "Inmunosupresores", "L-Dopa", "Fisostigmina", "Epinefrina"
] AS med
CREATE (:Medicamento {nombre: med});

UNWIND [
  "Punción Lumbar", "Biopsia Cerebral", "Resonancia Magnética (MRI)",
  "Tomografía PET", "Biopsia de Médula Ósea", "Intubación", "Plasmaféresis", "Allanamiento de Morada"
] AS proc
CREATE (:Procedimiento {nombre: proc});

UNWIND [
  "Lupus", "Sarcoidosis", "Amiloidosis", "Granulomatosis de Wegener", 
  "Esclerosis Múltiple", "Neuro sífilis", "Enfermedad de Wilson", "Porfiria"
] AS diag
CREATE (:Diagnostico {nombre: diag});

// 6. Generación de Nodos Dinámicos: 200 Doctores (Basados en apellidos y roles de la serie)
UNWIND range(1, 200) AS id_doc
WITH id_doc, 
     ["House", "Wilson", "Cuddy", "Foreman", "Chase", "Cameron", "Taub", "Kutner", "Hadley", "Masters", "Adams", "Park", "Volakis"] AS apellidos,
     ["Jefe de Diagnóstico", "Oncólogo", "Decana de Medicina", "Fellow de Diagnóstico", "Cirujano", "Inmunólogo", "Residente"] AS roles
CREATE (:Doctor {
  id: "DOC_" + id_doc,
  nombre: "Dr/Dra. " + apellidos[toInteger(rand() * size(apellidos))],
  rol: roles[toInteger(rand() * size(roles))],
  experiencia_anios: toInteger(rand() * 30) + 1
});

// 7. Generación de Nodos Dinámicos: 500 Enfermeras
UNWIND range(1, 500) AS id_enf
WITH id_enf,
     ["Enfermera de Planta", "Enfermera Quirúrgica", "Jefa de Enfermeras (Tipo Brenda)", "Asistente de Clínica"] AS niveles
CREATE (:Enfermera {
  id: "ENF_" + id_enf,
  nivel: niveles[toInteger(rand() * size(niveles))]
});

// 8. Generación de Nodos Dinámicos: 5000 Pacientes
UNWIND range(1, 5000) AS id_pac
CREATE (:Paciente {
  id: "PAC_" + id_pac,
  edad: toInteger(rand() * 90) + 1,
  grupo_sanguineo: ["O+", "A+", "B+", "AB+", "O-", "A-", "B-", "AB-"][toInteger(rand() * 8)]
});

// 9. Relaciones Base: Asignación de Personal
MATCH (d:Doctor)
MATCH (dep:Departamento)
WITH d, dep ORDER BY rand()
WITH d, collect(dep)[0] AS dep_asignado
CREATE (d)-[:ASIGNADO_A]->(dep_asignado);

MATCH (e:Enfermera)
MATCH (dep:Departamento)
WITH e, dep ORDER BY rand()
WITH e, collect(dep)[0] AS dep_asignado
CREATE (e)-[:TRABAJA_EN]->(dep_asignado);

// 10. Relaciones Clínicas: Flujo de Pacientes
MATCH (p:Paciente)
WITH p
MATCH (dep:Departamento) WITH p, dep ORDER BY rand() LIMIT 1
CREATE (p)-[:INGRESADO_EN {fecha_ingreso: date() - duration({days: toInteger(rand() * 365)})}]->(dep)
WITH p, dep
MATCH (d:Doctor)-[:ASIGNADO_A]->(dep) WITH p, d ORDER BY rand() LIMIT 1
CREATE (p)-[:ATENDIDO_POR]->(d);

MATCH (p:Paciente)
MATCH (diag:Diagnostico) WITH p, diag ORDER BY rand() LIMIT 1
CREATE (p)-[:TIENE_DIAGNOSTICO {certeza: toInteger(rand() * 50) + 50}]->(diag);

MATCH (p:Paciente)
MATCH (med:Medicamento) WITH p, med ORDER BY rand() LIMIT toInteger(rand() * 3) + 1
CREATE (p)-[:RECIBE_TRATAMIENTO {dosis_mg: toInteger(rand() * 500) + 10}]->(med);

MATCH (p:Paciente)
WHERE rand() > 0.4
MATCH (proc:Procedimiento) WITH p, proc ORDER BY rand() LIMIT toInteger(rand() * 2) + 1
CREATE (p)-[:SOMETIDO_A {fecha: date() - duration({days: toInteger(rand() * 30)})}]->(proc);

// 11. Relaciones Operativas: Estructura Interna (Dinámica House)
MATCH (d1:Doctor), (d2:Doctor)
WHERE d1 <> d2 AND rand() > 0.95
CREATE (d1)-[:CONSULTA_CON {frecuencia: "Ocasional", insultos_intercambiados: toInteger(rand() * 5)}]->(d2);

MATCH (e:Enfermera), (d:Doctor)
WHERE rand() > 0.98
CREATE (e)-[:REPORTA_INCIDENCIA_A]->(d);