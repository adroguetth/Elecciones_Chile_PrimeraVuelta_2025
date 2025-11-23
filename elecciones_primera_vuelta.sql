-- =====================================================
-- ANÁLISIS ELECTORAL PRIMERA VUELTA PRESIDENCIAL CHILE 2025
-- =====================================================
-- Archivo: analisis_elecciones_primera_vuelta_2025.sql
-- Base de datos: SQL Server 2012+
-- Autor: Alfonso Droguett
-- Fecha: Noviembre 2025
-- Descripción: Análisis integral de resultados electorales primera vuelta
--              presidencial Chile 2025 con enfoque en patrones geográficos
--              y competitividad electoral
-- =====================================================

-- =====================================================
-- 1. ESTADÍSTICAS GENERALES DE PARTICIPACIÓN ELECTORAL
-- =====================================================
-- Objetivo: Calcular métricas fundamentales de participación ciudadana
-- Contexto: Base para todos los análisis posteriores

WITH participacion_nacional AS (
    SELECT
        COUNT(*) AS total_comunas,
        SUM(emitidos_votos) AS total_votos_emitidos,
        SUM(blanco_votos) AS total_votos_blancos,
        SUM(nulo_votos) AS total_votos_nulos,
        SUM(emitidos_votos) - (SUM(blanco_votos) + SUM(nulo_votos)) AS total_votos_validos
    FROM resultados_elecciones
)
SELECT
    total_comunas,
    total_votos_emitidos,
    total_votos_blancos,
    ROUND(CAST(total_votos_blancos AS FLOAT) / total_votos_emitidos * 100, 2) AS porcentaje_blanco_nacional,
    total_votos_nulos,
    ROUND(CAST(total_votos_nulos AS FLOAT) / total_votos_emitidos * 100, 2) AS porcentaje_nulo_nacional,
    total_votos_validos,
    ROUND(CAST(total_votos_validos AS FLOAT) / total_votos_emitidos * 100, 2) AS porcentaje_valido_nacional
FROM participacion_nacional;

-- =====================================================
-- 2. RESULTADOS NACIONALES POR CANDIDATO
-- =====================================================
-- Objetivo: Calcular y clasificar porcentaje de votación por candidato
-- Metodología: Agregación nacional + transformación estructural

WITH suma_votos AS (
    SELECT
        SUM(emitidos_votos) AS total_votos_emitidos,
        SUM(artes_votos) AS artes_total,
        SUM(enriquez_ominami_votos) AS meo_total,
        SUM(jara_votos) AS jara_total,
        SUM(kaiser_votos) AS kaiser_total,
        SUM(kast_votos) AS kast_total,
        SUM(matthei_votos) AS matthei_total,
        SUM(parisi_votos) AS parisi_total,
        SUM(mayne_nicholls_votos) AS mayne_nicholls_total
    FROM resultados_elecciones
),
candidatos_votos AS (
    SELECT 'Eduardo Artes' AS candidato, artes_total AS votos FROM suma_votos
    UNION ALL SELECT 'Marco Enriquez-Ominami', meo_total FROM suma_votos
    UNION ALL SELECT 'Jeannette Jara', jara_total FROM suma_votos
    UNION ALL SELECT 'Johannes Kaiser', kaiser_total FROM suma_votos
    UNION ALL SELECT 'José Antonio Kast', kast_total FROM suma_votos
    UNION ALL SELECT 'Evelyn Matthei', matthei_total FROM suma_votos
    UNION ALL SELECT 'Franco Parisi', parisi_total FROM suma_votos
    UNION ALL SELECT 'Harold Mayne-Nicholls', mayne_nicholls_total FROM suma_votos
)
SELECT
    candidato,
    ROUND(CAST(votos AS FLOAT) / (SELECT total_votos_emitidos FROM suma_votos) * 100, 2) AS votos_porcentaje,
    CASE
        WHEN ROUND(CAST(votos AS FLOAT) / (SELECT total_votos_emitidos FROM suma_votos) * 100, 2) >= 20 THEN 'Alto apoyo'
        WHEN ROUND(CAST(votos AS FLOAT) / (SELECT total_votos_emitidos FROM suma_votos) * 100, 2) >= 10 THEN 'Medio apoyo'
        ELSE 'Bajo apoyo'
    END AS nivel_apoyo
FROM candidatos_votos
ORDER BY votos_porcentaje DESC;

-- =====================================================
-- 3. IDENTIFICACIÓN DE CANDIDATOS PARA SEGUNDA VUELTA
-- =====================================================
-- Objetivo: Determinar los dos candidatos más votados según ley chilena
-- Base Legal: Ley 18.700 - Sistema de dos vueltas

WITH suma_votos AS (
    SELECT
        SUM(emitidos_votos) AS total_votos_emitidos,
        SUM(jara_votos) AS jara_total,
        SUM(kast_votos) AS kast_total,
        SUM(parisi_votos) AS parisi_total,
        SUM(kaiser_votos) AS kaiser_total,
        SUM(matthei_votos) AS matthei_total,
        SUM(mayne_nicholls_votos) AS mayne_nicholls_total,
        SUM(enriquez_ominami_votos) AS meo_total,
        SUM(artes_votos) AS artes_total
    FROM resultados_elecciones
),
porcentajes_candidatos AS (
    SELECT 'Jeannette Jara' AS candidato,
           ROUND(CAST(jara_total AS FLOAT) / total_votos_emitidos * 100, 2) AS porcentaje
    FROM suma_votos
    UNION ALL SELECT 'José Antonio Kast',
           ROUND(CAST(kast_total AS FLOAT) / total_votos_emitidos * 100, 2) FROM suma_votos
    UNION ALL SELECT 'Franco Parisi',
           ROUND(CAST(parisi_total AS FLOAT) / total_votos_emitidos * 100, 2) FROM suma_votos
    UNION ALL SELECT 'Johannes Kaiser',
           ROUND(CAST(kaiser_total AS FLOAT) / total_votos_emitidos * 100, 2) FROM suma_votos
    UNION ALL SELECT 'Evelyn Matthei',
           ROUND(CAST(matthei_total AS FLOAT) / total_votos_emitidos * 100, 2) FROM suma_votos
    UNION ALL SELECT 'Harold Mayne-Nicholls',
           ROUND(CAST(mayne_nicholls_total AS FLOAT) / total_votos_emitidos * 100, 2) FROM suma_votos
    UNION ALL SELECT 'Marco Enriquez-Ominami',
           ROUND(CAST(meo_total AS FLOAT) / total_votos_emitidos * 100, 2) FROM suma_votos
    UNION ALL SELECT 'Eduardo Artes',
           ROUND(CAST(artes_total AS FLOAT) / total_votos_emitidos * 100, 2) FROM suma_votos
),
ranking_candidatos AS (
    SELECT
        candidato,
        porcentaje,
        ROW_NUMBER() OVER (ORDER BY porcentaje DESC) AS posicion
    FROM porcentajes_candidatos
)
SELECT
    candidato,
    porcentaje,
    CASE
        WHEN posicion = 1 THEN '1er Lugar'
        WHEN posicion = 2 THEN '2do Lugar'
    END AS posicion,
    CASE
        WHEN porcentaje > 20 THEN 'Umbral competitivo'
        ELSE 'Umbral mínimo'
    END AS contexto_competitividad
FROM ranking_candidatos
WHERE posicion <= 2
ORDER BY posicion;

-- =====================================================
-- 4. MAPEO TERRITORIAL DE VICTORIAS POR CANDIDATO
-- =====================================================
-- Objetivo: Determinar número de comunas ganadas por cada candidato
-- Metodología: Análisis exhaustivo por comuna

WITH victorias_por_candidato AS (
    SELECT
        comuna,
        CASE
            WHEN jara_pct >= kast_pct AND jara_pct >= parisi_pct AND jara_pct >= kaiser_pct
                 AND jara_pct >= matthei_pct AND jara_pct >= mayne_nicholls_pct
                 AND jara_pct >= enriquez_ominami_pct AND jara_pct >= artes_pct
            THEN 'Jeannette Jara'
            WHEN kast_pct >= jara_pct AND kast_pct >= parisi_pct AND kast_pct >= kaiser_pct
                 AND kast_pct >= matthei_pct AND kast_pct >= mayne_nicholls_pct
                 AND kast_pct >= enriquez_ominami_pct AND kast_pct >= artes_pct
            THEN 'José Antonio Kast'
            WHEN parisi_pct >= jara_pct AND parisi_pct >= kast_pct AND parisi_pct >= kaiser_pct
                 AND parisi_pct >= matthei_pct AND parisi_pct >= mayne_nicholls_pct
                 AND parisi_pct >= enriquez_ominami_pct AND parisi_pct >= artes_pct
            THEN 'Franco Parisi'
            WHEN kaiser_pct >= jara_pct AND kaiser_pct >= kast_pct AND kaiser_pct >= parisi_pct
                 AND kaiser_pct >= matthei_pct AND kaiser_pct >= mayne_nicholls_pct
                 AND kaiser_pct >= enriquez_ominami_pct AND kaiser_pct >= artes_pct
            THEN 'Johannes Kaiser'
            WHEN matthei_pct >= jara_pct AND matthei_pct >= kast_pct AND matthei_pct >= parisi_pct
                 AND matthei_pct >= kaiser_pct AND matthei_pct >= mayne_nicholls_pct
                 AND matthei_pct >= enriquez_ominami_pct AND matthei_pct >= artes_pct
            THEN 'Evelyn Matthei'
            ELSE 'Otro'
        END AS candidato_ganador
    FROM resultados_elecciones
)
SELECT
    candidato_ganador AS candidato,
    COUNT(*) AS comunas_ganadas,
    ROUND(CAST(COUNT(*) AS FLOAT) / 346 * 100, 1) AS porcentaje_comunas
FROM victorias_por_candidato
GROUP BY candidato_ganador
ORDER BY comunas_ganadas DESC;

-- =====================================================
-- 5. RESULTADOS POR REGIÓN - ANÁLISIS GEOGRÁFICO
-- =====================================================
-- Objetivo: Identificar patrones regionales de apoyo
-- Metodología: Agregación regional + determinación jerárquica

WITH resultados_region AS (
    SELECT
        region,
        ROUND(AVG(jara_pct), 2) AS jara_promedio,
        ROUND(AVG(kast_pct), 2) AS kast_promedio,
        ROUND(AVG(parisi_pct), 2) AS parisi_promedio,
        ROUND(AVG(kaiser_pct), 2) AS kaiser_promedio
    FROM resultados_elecciones
    GROUP BY region
)
SELECT
    region,
    CASE
        WHEN jara_promedio >= kast_promedio AND jara_promedio >= parisi_promedio AND jara_promedio >= kaiser_promedio
        THEN 'Jeannette Jara'
        WHEN kast_promedio >= jara_promedio AND kast_promedio >= parisi_promedio AND kast_promedio >= kaiser_promedio
        THEN 'José Antonio Kast'
        WHEN parisi_promedio >= jara_promedio AND parisi_promedio >= kast_promedio AND parisi_promedio >= kaiser_promedio
        THEN 'Franco Parisi'
        ELSE 'Johannes Kaiser'
    END AS ganador_regional,
    jara_promedio,
    kast_promedio,
    parisi_promedio,
    kaiser_promedio
FROM resultados_region
ORDER BY
    CASE
        WHEN jara_promedio >= kast_promedio AND jara_promedio >= parisi_promedio AND jara_promedio >= kaiser_promedio
        THEN jara_promedio
        WHEN kast_promedio >= jara_promedio AND kast_promedio >= parisi_promedio AND kast_promedio >= kaiser_promedio
        THEN kast_promedio
        WHEN parisi_promedio >= jara_promedio AND parisi_promedio >= kast_promedio AND parisi_promedio >= kaiser_promedio
        THEN parisi_promedio
        ELSE kaiser_promedio
    END DESC;

-- =====================================================
-- 6. ANÁLISIS DE COMPETITIVIDAD - COMUNAS ESTRECHAS
-- =====================================================
-- Objetivo: Identificar comunas donde la diferencia fue menor a 1000 votos
-- Contexto: Oportunidades estratégicas para segunda vuelta

WITH diferencia_votos AS (
    SELECT
        comuna,
        region,
        emitidos_votos,
        (jara_pct / 100.0) * emitidos_votos AS votos_jara,
        (kast_pct / 100.0) * emitidos_votos AS votos_kast,
        ABS((jara_pct / 100.0) * emitidos_votos - (kast_pct / 100.0) * emitidos_votos) AS diferencia_absoluta
    FROM resultados_elecciones
    WHERE jara_pct > 0 AND kast_pct > 0
)
SELECT
    'Jeannette Jara' AS candidato_analizado,
    COUNT(*) AS comunas_competitivas,
    SUM(diferencia_absoluta) AS total_votos_faltantes,
    ROUND(AVG(diferencia_absoluta), 0) AS promedio_votos_faltantes
FROM diferencia_votos
WHERE diferencia_absoluta <= 1000;

-- =====================================================
-- 7. FENÓMENO "VOTO ANTISISTEMA" - PARISI vs DÚOPOLIO
-- =====================================================
-- Objetivo: Identificar comunas donde Parisi supera a Jara + Kast
-- Contexto: Análisis del voto de protesta contra establishment

SELECT
    comuna,
    region,
    parisi_pct AS parisi_porcentaje,
    jara_pct AS jara_porcentaje,
    kast_pct AS kast_porcentaje,
    (jara_pct + kast_pct) AS jara_kast_combinados,
    ROUND(parisi_pct - (jara_pct + kast_pct), 2) AS diferencia_parisi_vs_duopolio,
    emitidos_votos AS total_votos_emitidos
FROM resultados_elecciones
WHERE parisi_pct > (jara_pct + kast_pct)
ORDER BY diferencia_parisi_vs_duopolio DESC;

-- =====================================================
-- ANÁLISIS DE RESULTADOS ESPERADOS:
-- =====================================================

/*
EJEMPLO SALIDA PARTICIPACIÓN NACIONAL:
+--------------+-------------------+-------------------+---------------------+---------------------+-------------------+-----------------------+
| total_comunas| total_votos_emitidos | total_votos_blancos | porcentaje_blanco_nacional | total_votos_nulos | porcentaje_nulo_nacional | total_votos_validos | porcentaje_valido_nacional |
+--------------+-------------------+-------------------+---------------------+---------------------+-------------------+-----------------------+
| 346          | 13388455          | 141956            | 1.06                 | 360571              | 2.69               | 12885928             | 96.25                  |
+--------------+-------------------+-------------------+---------------------+---------------------+-------------------+-----------------------+

EJEMPLO SALIDA CANDIDATOS SEGUNDA VUELTA:
+------------------+------------+-----------+---------------------+
| candidato        | porcentaje | posicion  | contexto_competitividad |
+------------------+------------+-----------+---------------------+
| Jeannette Jara   | 25.74      | 1er Lugar | Umbral competitivo  |
| José Antonio Kast| 23.06      | 2do Lugar | Umbral competitivo  |
+------------------+------------+-----------+---------------------+

EJEMPLO SALIDA MAPEO TERRITORIAL:
+------------------+-----------------+------------------+
| candidato        | comunas_ganadas | porcentaje_comunas |
+------------------+-----------------+------------------+
| José Antonio Kast| 169             | 48.8             |
| Jeannette Jara   | 105             | 30.3             |
| Franco Parisi    | 64              | 18.5             |
+------------------+-----------------+------------------+
*/

-- =====================================================
-- BEST PRACTICES IMPLEMENTADAS:
-- =====================================================

-- 1. 📊 MODULARIDAD: CTEs para separar lógica de cálculo
-- 2. 🔄 EFICIENCIA: Evitar subconsultas repetitivas
-- 3. 🎯 PRECISIÓN: Cálculos con CAST explícito para decimales
-- 4. 📝 DOCUMENTACIÓN: Comentarios explicativos por sección
-- 5. 🗺️  ANÁLISIS ESPACIAL: Enfoque en patrones geográficos

-- =====================================================
-- NOTAS DE IMPLEMENTACIÓN:
-- =====================================================

/*
VERSION: 1.0
COBERTURA: 346 comunas a nivel nacional
FUENTE: SERVEL - Datos oficiales electorales
MÉTRICAS CLAVE:
  - Participación ciudadana (votos válidos, blancos, nulos)
  - Distribución geográfica del apoyo electoral
  - Competitividad por comuna
  - Fenómeno voto antisistema

PRÓXIMOS PASOS:
  - Análisis comparativo con elecciones anteriores
  - Integración con datos sociodemográficos
  - Dashboard interactivo para visualización
*/

-- =====================================================
-- FIN DEL DOCUMENTO
-- =====================================================
