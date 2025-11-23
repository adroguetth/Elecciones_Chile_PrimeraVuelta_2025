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

-- =======================================================================
-- 4.1. Estadísticas Generales de Participación Electoral
-- =======================================================================
SELECT
    -- MÉTRICA 1: COBERTURA GEOGRÁFICA DEL ANÁLISIS
    COUNT(*) AS total_comunas,
    
    -- MÉTRICA 2: PARTICIPACIÓN CIUDADANA ABSOLUTA
    SUM(emitidos_votos) AS total_votos_emitidos,
    
    -- MÉTRICA 3: VOTO DE PROTESTA PASIVA
    SUM(blanco_votos) AS total_votos_blancos,
    
    -- MÉTRICA 4: INCIDENCIA DEL VOTO BLANCO
    ROUND(CAST(SUM(blanco_votos) AS FLOAT) / SUM(emitidos_votos) * 100, 2) AS porcentaje_blanco_nacional,
    
    -- MÉTRICA 5: VOTO DE PROTESTA ACTIVA
    SUM(nulo_votos) AS total_votos_nulos,
    
    -- MÉTRICA 6: INCIDENCIA DEL VOTO NULO
    ROUND(CAST(SUM(nulo_votos) AS FLOAT) / SUM(emitidos_votos) * 100, 2) AS porcentaje_nulo_nacional,
    
    -- MÉTRICA 7: VOTO VÁLIDO (CÁLCULO DERIVADO)
    SUM(emitidos_votos) - (SUM(blanco_votos) + SUM(nulo_votos)) AS total_votos_validos,
    
    -- MÉTRICA 8: PORCENTAJE DE VOTO VÁLIDO
    ROUND(CAST(SUM(emitidos_votos) - (SUM(blanco_votos) + SUM(nulo_votos)) AS FLOAT) / SUM(emitidos_votos) * 100, 2) AS porcentaje_valido_nacional
FROM resultados_elecciones;

-- =======================================================================
-- 4.2. Resultados Nacionales por Candidato
-- =======================================================================
WITH suma_votos AS (
    -- CTE 1: Agregación total de votos a nivel nacional
    SELECT
        SUM(emitidos_votos) AS total_votos_emitidos,
        SUM(artes_votos) AS artes_total,
        SUM(enriquez_ominami_votos) AS MEO_total,
        SUM(jara_votos) AS jara_total,
        SUM(kaiser_votos) AS kaiser_total,
        SUM(kast_votos) AS kast_total,
        SUM(matthei_votos) AS matthei_total,
        SUM(parisi_votos) AS parisi_total,
        SUM(mayne_nicholls_votos) AS mayne_nicholls_total
    FROM resultados_elecciones
),
candidatos_votos AS (
    -- CTE 2: Transformación y cálculo de porcentajes individuales
    SELECT 'Eduardo Artes' AS candidato,
        ROUND(CAST(artes_total AS FLOAT) / total_votos_emitidos * 100, 2) AS votos_porcentaje
    FROM suma_votos
    UNION ALL
    SELECT 'Marco Enriquez-Ominami' AS candidato,
        ROUND(CAST(MEO_total AS FLOAT) / total_votos_emitidos * 100, 2) AS votos_porcentaje
    FROM suma_votos
    UNION ALL
    SELECT 'Jeannette Jara' AS candidato,
        ROUND(CAST(jara_total AS FLOAT) / total_votos_emitidos * 100, 2) AS votos_porcentaje
    FROM suma_votos
    UNION ALL
    SELECT 'Johannes Kaiser' AS candidato,
        ROUND(CAST(kaiser_total AS FLOAT) / total_votos_emitidos * 100, 2) AS votos_porcentaje
    FROM suma_votos
    UNION ALL
    SELECT 'José Antonio Kast' AS candidato,
        ROUND(CAST(kast_total AS FLOAT) / total_votos_emitidos * 100, 2) AS votos_porcentaje
    FROM suma_votos
    UNION ALL
    SELECT 'Evelyn Matthei' AS candidato,
        ROUND(CAST(matthei_total AS FLOAT) / total_votos_emitidos * 100, 2) AS votos_porcentaje
    FROM suma_votos
    UNION ALL
    SELECT 'Franco Parisi' AS candidato,
        ROUND(CAST(parisi_total AS FLOAT) / total_votos_emitidos * 100, 2) AS votos_porcentaje
    FROM suma_votos
    UNION ALL
    SELECT 'Harold Mayne-Nicholls' AS candidato,
        ROUND(CAST(mayne_nicholls_total AS FLOAT) / total_votos_emitidos * 100, 2) AS votos_porcentaje
    FROM suma_votos
)
-- CONSULTA FINAL: Resultados ordenados por porcentaje de mayor a menor
SELECT
    candidato,
    votos_porcentaje,
    CASE
        WHEN votos_porcentaje >= 20 THEN 'Alto apoyo'
        WHEN votos_porcentaje >= 10 THEN 'Medio apoyo'
        ELSE 'Bajo apoyo'
    END AS nivel_apoyo
FROM candidatos_votos
ORDER BY votos_porcentaje DESC;

-- =======================================================================
-- 4.3. Identificación de Candidatos para Segunda Vuelta
-- =======================================================================
WITH suma_votos AS (
    -- CTE 1: AGREGACIÓN NACIONAL DE VOTOS
    SELECT
        SUM(emitidos_votos) AS total_votos_emitidos,
        SUM(artes_votos) AS artes_total,
        SUM(enriquez_ominami_votos) AS MEO_total,
        SUM(jara_votos) AS jara_total,
        SUM(kaiser_votos) AS kaiser_total,
        SUM(kast_votos) AS kast_total,
        SUM(matthei_votos) AS matthei_total,
        SUM(parisi_votos) AS parisi_total,
        SUM(mayne_nicholls_votos) AS mayne_nicholls_total
    FROM resultados_elecciones
),
porcentaje_votos AS (
    -- CTE 2: CÁLCULO DE PORCENTAJES INDIVIDUALES
    SELECT
        ROUND(CAST(artes_total AS FLOAT) / total_votos_emitidos * 100, 2) AS artes_pct,
        ROUND(CAST(MEO_total AS FLOAT) / total_votos_emitidos * 100, 2) AS MEO_pct,
        ROUND(CAST(jara_total AS FLOAT) / total_votos_emitidos * 100, 2) AS jara_pct,
        ROUND(CAST(kaiser_total AS FLOAT) / total_votos_emitidos * 100, 2) AS kaiser_pct,
        ROUND(CAST(kast_total AS FLOAT) / total_votos_emitidos * 100, 2) AS kast_pct,
        ROUND(CAST(matthei_total AS FLOAT) / total_votos_emitidos * 100, 2) AS matthei_pct,
        ROUND(CAST(parisi_total AS FLOAT) / total_votos_emitidos * 100, 2) AS parisi_pct,
        ROUND(CAST(mayne_nicholls_total AS FLOAT) / total_votos_emitidos * 100, 2) AS mayne_nicholls_pct
    FROM suma_votos
),
candidatos_votos AS (
    -- CTE 3: ESTRUCTURACIÓN VERTICAL DE CANDIDATOS
    SELECT 'Eduardo Artes' AS candidato, artes_pct AS porcentaje FROM porcentaje_votos
    UNION ALL
    SELECT 'Marco Enriquez-Ominami' AS candidato, MEO_pct AS porcentaje FROM porcentaje_votos
    UNION ALL
    SELECT 'Jeannette Jara' AS candidato, jara_pct AS porcentaje FROM porcentaje_votos
    UNION ALL
    SELECT 'Johannes Kaiser' AS candidato, kaiser_pct AS porcentaje FROM porcentaje_votos
    UNION ALL
    SELECT 'José Antonio Kast' AS candidato, kast_pct AS porcentaje FROM porcentaje_votos
    UNION ALL
    SELECT 'Evelyn Matthei' AS candidato, matthei_pct AS porcentaje FROM porcentaje_votos
    UNION ALL
    SELECT 'Franco Parisi' AS candidato, parisi_pct AS porcentaje FROM porcentaje_votos
    UNION ALL
    SELECT 'Harold Mayne-Nicholls' AS candidato, mayne_nicholls_pct AS porcentaje FROM porcentaje_votos
),
maximos_porcentajes AS (
    -- CTE 4: IDENTIFICACIÓN DE LOS DOS MAYORES PORCENTAJES
    SELECT MAX(porcentaje) AS max_porcentaje FROM candidatos_votos
    UNION ALL
    SELECT MAX(porcentaje) AS max_porcentaje FROM candidatos_votos
    WHERE porcentaje < (SELECT MAX(porcentaje) FROM candidatos_votos)
)
-- CONSULTA FINAL: SELECCIÓN Y CLASIFICACIÓN DE GANADORES
SELECT
    cv.candidato AS candidato_top,
    cv.porcentaje AS porcentaje_votos,
    CASE
        WHEN cv.porcentaje = (SELECT MAX(porcentaje) FROM candidatos_votos) THEN '1er lugar'
        ELSE '2do lugar'
    END AS posicion,
    CASE
        WHEN cv.porcentaje > 20 THEN 'Umbral competitivo'
        ELSE 'Umbral mínimo'
    END AS contexto_competitividad
FROM candidatos_votos cv
INNER JOIN maximos_porcentajes mp ON cv.porcentaje = mp.max_porcentaje
ORDER BY cv.porcentaje DESC;

-- =======================================================================
-- 4.4. Top 10 Comunas por Porcentaje de Votación - Candidatos Más Votados
-- =======================================================================
-- Jeannette Jara
SELECT TOP 10
    comuna,
    region,
    jara_pct AS porcentaje,
    CASE
        WHEN jara_pct >= artes_pct AND jara_pct >= enriquez_ominami_pct AND jara_pct >= kaiser_pct 
             AND jara_pct >= kast_pct AND jara_pct >= matthei_pct AND jara_pct >= mayne_nicholls_pct 
             AND jara_pct >= parisi_pct
        THEN 'Gana en esa comuna'
        ELSE 'Pierde en esa comuna'
    END AS ganador_comuna
FROM resultados_elecciones
ORDER BY jara_pct DESC;

-- José Antonio Kast
SELECT TOP 10
    comuna,
    region,
    kast_pct AS porcentaje,
    CASE
        WHEN kast_pct >= artes_pct AND kast_pct >= enriquez_ominami_pct AND kast_pct >= kaiser_pct 
             AND kast_pct >= jara_pct AND kast_pct >= matthei_pct AND kast_pct >= mayne_nicholls_pct 
             AND kast_pct >= parisi_pct
        THEN 'Gana en esa comuna'
        ELSE 'Pierde en esa comuna'
    END AS resultado_comuna
FROM resultados_elecciones
ORDER BY kast_pct DESC;

-- Franco Parisi
SELECT TOP 10
    comuna,
    region,
    parisi_pct AS porcentaje,
    CASE
        WHEN parisi_pct >= artes_pct AND parisi_pct >= enriquez_ominami_pct AND parisi_pct >= kaiser_pct 
             AND parisi_pct >= kast_pct AND parisi_pct >= matthei_pct AND parisi_pct >= mayne_nicholls_pct 
             AND parisi_pct >= jara_pct
        THEN 'Gana en esa comuna'
        ELSE 'Pierde en esa comuna'
    END AS resultado_comuna
FROM resultados_elecciones
ORDER BY parisi_pct DESC;

-- Johannes Kaiser
SELECT TOP 10
    comuna,
    region,
    kaiser_pct AS porcentaje,
    CASE
        WHEN kaiser_pct >= artes_pct AND kaiser_pct >= enriquez_ominami_pct AND kaiser_pct >= jara_pct 
             AND kaiser_pct >= kast_pct AND kaiser_pct >= matthei_pct AND kaiser_pct >= mayne_nicholls_pct 
             AND kaiser_pct >= parisi_pct
        THEN 'Gana en esa comuna'
        ELSE 'Pierde en esa comuna'
    END AS resultado_comuna
FROM resultados_elecciones
ORDER BY kaiser_pct DESC;

-- Evelyn Matthei
SELECT TOP 10
    comuna,
    region,
    matthei_pct AS porcentaje,
    CASE
        WHEN matthei_pct >= artes_pct AND matthei_pct >= enriquez_ominami_pct AND matthei_pct >= kaiser_pct 
             AND matthei_pct >= kast_pct AND matthei_pct >= jara_pct AND matthei_pct >= mayne_nicholls_pct 
             AND matthei_pct >= parisi_pct
        THEN 'Gana en esa comuna'
        ELSE 'Pierde en esa comuna'
    END AS resultado_comuna
FROM resultados_elecciones
ORDER BY matthei_pct DESC;

-- =======================================================================
-- 4.5. Mapeo Territorial de Victorias por Candidato
-- =======================================================================
WITH gana_artes AS (
    -- CTE 1: ANÁLISIS DE VICTORIAS - EDUARDO ARTES
    SELECT
        comuna,
        CASE
            WHEN artes_pct >= jara_pct AND artes_pct >= enriquez_ominami_pct AND artes_pct >= kaiser_pct 
                 AND artes_pct >= kast_pct AND artes_pct >= matthei_pct AND artes_pct >= mayne_nicholls_pct 
                 AND artes_pct >= parisi_pct
            THEN 'Gana'
            ELSE 'Pierde'
        END AS resultado
    FROM resultados_elecciones
),
gana_enriquez_ominami AS (
    -- CTE 2: ANÁLISIS DE VICTORIAS - MARCO ENRÍQUEZ-OMINAMI
    SELECT
        comuna,
        CASE
            WHEN enriquez_ominami_pct >= artes_pct AND enriquez_ominami_pct >= jara_pct 
                 AND enriquez_ominami_pct >= kaiser_pct AND enriquez_ominami_pct >= kast_pct 
                 AND enriquez_ominami_pct >= matthei_pct AND enriquez_ominami_pct >= mayne_nicholls_pct 
                 AND enriquez_ominami_pct >= parisi_pct
            THEN 'Gana'
            ELSE 'Pierde'
        END AS resultado
    FROM resultados_elecciones
),
gana_jara AS (
    -- CTE 3: ANÁLISIS DE VICTORIAS - JEANNETTE JARA
    SELECT
        comuna,
        CASE
            WHEN jara_pct >= artes_pct AND jara_pct >= enriquez_ominami_pct AND jara_pct >= kaiser_pct 
                 AND jara_pct >= kast_pct AND jara_pct >= matthei_pct AND jara_pct >= mayne_nicholls_pct 
                 AND jara_pct >= parisi_pct
            THEN 'Gana'
            ELSE 'Pierde'
        END AS resultado
    FROM resultados_elecciones
),
gana_kaiser AS (
    -- CTE 4: ANÁLISIS DE VICTORIAS - JOHANNES KAISER
    SELECT
        comuna,
        CASE
            WHEN kaiser_pct >= artes_pct AND kaiser_pct >= enriquez_ominami_pct AND kaiser_pct >= jara_pct 
                 AND kaiser_pct >= kast_pct AND kaiser_pct >= matthei_pct AND kaiser_pct >= mayne_nicholls_pct 
                 AND kaiser_pct >= parisi_pct
            THEN 'Gana'
            ELSE 'Pierde'
        END AS resultado
    FROM resultados_elecciones
),
gana_kast AS (
    -- CTE 5: ANÁLISIS DE VICTORIAS - JOSÉ ANTONIO KAST
    SELECT
        comuna,
        CASE
            WHEN kast_pct >= artes_pct AND kast_pct >= enriquez_ominami_pct AND kast_pct >= kaiser_pct 
                 AND kast_pct >= jara_pct AND kast_pct >= matthei_pct AND kast_pct >= mayne_nicholls_pct 
                 AND kast_pct >= parisi_pct
            THEN 'Gana'
            ELSE 'Pierde'
        END AS resultado
    FROM resultados_elecciones
),
gana_matthei AS (
    -- CTE 6: ANÁLISIS DE VICTORIAS - EVELYN MATTHEI
    SELECT
        comuna,
        CASE
            WHEN matthei_pct >= artes_pct AND matthei_pct >= enriquez_ominami_pct AND matthei_pct >= kaiser_pct 
                 AND matthei_pct >= kast_pct AND matthei_pct >= jara_pct AND matthei_pct >= mayne_nicholls_pct 
                 AND matthei_pct >= parisi_pct
            THEN 'Gana'
            ELSE 'Pierde'
        END AS resultado
    FROM resultados_elecciones
),
gana_parisi AS (
    -- CTE 7: ANÁLISIS DE VICTORIAS - FRANCO PARISI
    SELECT
        comuna,
        CASE
            WHEN parisi_pct >= artes_pct AND parisi_pct >= enriquez_ominami_pct AND parisi_pct >= kaiser_pct 
                 AND parisi_pct >= kast_pct AND parisi_pct >= matthei_pct AND parisi_pct >= mayne_nicholls_pct 
                 AND parisi_pct >= jara_pct
            THEN 'Gana'
            ELSE 'Pierde'
        END AS resultado
    FROM resultados_elecciones
),
gana_mayne_nicholls AS (
    -- CTE 8: ANÁLISIS DE VICTORIAS - HAROLD MAYNE-NICHOLLS
    SELECT
        comuna,
        CASE
            WHEN mayne_nicholls_pct >= artes_pct AND mayne_nicholls_pct >= enriquez_ominami_pct 
                 AND mayne_nicholls_pct >= kaiser_pct AND mayne_nicholls_pct >= kast_pct 
                 AND mayne_nicholls_pct >= matthei_pct AND mayne_nicholls_pct >= jara_pct 
                 AND mayne_nicholls_pct >= parisi_pct
            THEN 'Gana'
            ELSE 'Pierde'
        END AS resultado
    FROM resultados_elecciones
),
resultados_finales AS (
    -- CTE 9: CONSOLIDACIÓN DE RESULTADOS
    SELECT 'Eduardo Artes' AS Candidato, COUNT(resultado) AS comunas_ganadas
    FROM gana_artes WHERE resultado = 'Gana'
    UNION ALL
    SELECT 'Marco Enriquez-Ominami' AS Candidato, COUNT(resultado) AS comunas_ganadas
    FROM gana_enriquez_ominami WHERE resultado = 'Gana'
    UNION ALL
    SELECT 'Jeannette Jara' AS Candidato, COUNT(resultado) AS comunas_ganadas
    FROM gana_jara WHERE resultado = 'Gana'
    UNION ALL
    SELECT 'Johannes Kaiser' AS Candidato, COUNT(resultado) AS comunas_ganadas
    FROM gana_kaiser WHERE resultado = 'Gana'
    UNION ALL
    SELECT 'José Antonio Kast' AS Candidato, COUNT(resultado) AS comunas_ganadas
    FROM gana_kast WHERE resultado = 'Gana'
    UNION ALL
    SELECT 'Evelyn Matthei' AS Candidato, COUNT(resultado) AS comunas_ganadas
    FROM gana_matthei WHERE resultado = 'Gana'
    UNION ALL
    SELECT 'Franco Parisi' AS Candidato, COUNT(resultado) AS comunas_ganadas
    FROM gana_parisi WHERE resultado = 'Gana'
    UNION ALL
    SELECT 'Harold Mayne-Nicholls' AS Candidato, COUNT(resultado) AS comunas_ganadas
    FROM gana_mayne_nicholls WHERE resultado = 'Gana'
)
-- CONSULTA FINAL: RANKING DE CANDIDATOS POR VICTORIAS TERRITORIALES
SELECT
    Candidato,
    comunas_ganadas,
    ROUND(CAST(comunas_ganadas AS FLOAT) / 346 * 100, 1) AS porcentaje_comunas
FROM resultados_finales
ORDER BY comunas_ganadas DESC;

-- =======================================================================
-- 4.6. Resultados por Región
-- =======================================================================
WITH ResultadosPorRegion AS (
    -- CTE 1: AGREGACIÓN REGIONAL DE PORCENTAJES
    SELECT
        region,
        ROUND(AVG(jara_pct), 2) AS jara_promedio,
        ROUND(AVG(kast_pct), 2) AS kast_promedio,
        ROUND(AVG(parisi_pct), 2) AS parisi_promedio,
        ROUND(AVG(kaiser_pct), 2) AS kaiser_promedio
    FROM resultados_elecciones
    GROUP BY region
),
Ganadores AS (
    -- CTE 2: DETERMINACIÓN DEL GANADOR REGIONAL
    SELECT
        region,
        jara_promedio,
        kast_promedio,
        parisi_promedio,
        kaiser_promedio,
        CASE
            WHEN jara_promedio >= kast_promedio AND jara_promedio >= parisi_promedio AND jara_promedio >= kaiser_promedio 
            THEN 'Jeannette Jara'
            WHEN kast_promedio >= jara_promedio AND kast_promedio >= parisi_promedio AND kast_promedio >= kaiser_promedio 
            THEN 'José Antonio Kast'
            WHEN parisi_promedio >= jara_promedio AND parisi_promedio >= kast_promedio AND parisi_promedio >= kaiser_promedio 
            THEN 'Franco Parisi'
            ELSE 'Johannes Kaiser'
        END AS ganador,
        CASE
            WHEN jara_promedio >= kast_promedio AND jara_promedio >= parisi_promedio AND jara_promedio >= kaiser_promedio 
            THEN jara_promedio
            WHEN kast_promedio >= jara_promedio AND kast_promedio >= parisi_promedio AND kast_promedio >= kaiser_promedio 
            THEN kast_promedio
            WHEN parisi_promedio >= jara_promedio AND parisi_promedio >= kast_promedio AND parisi_promedio >= kaiser_promedio 
            THEN parisi_promedio
            ELSE kaiser_promedio
        END AS porcentaje_ganador
    FROM ResultadosPorRegion
)
-- CONSULTA FINAL: RANKING REGIONAL POR DOMINANCIA ELECTORAL
SELECT
    region,
    ganador,
    porcentaje_ganador,
    jara_promedio,
    kast_promedio,
    parisi_promedio,
    kaiser_promedio
FROM Ganadores
ORDER BY porcentaje_ganador DESC;

-- 4.7. Resultados por Capital Regional - Análisis de Centros Urbanos
WITH CapitalesRegionales AS (
    -- CTE 1: FILTRADO DE CAPITALES REGIONALES
    SELECT
        comuna,
        region,
        jara_pct,
        kast_pct,
        parisi_pct,
        kaiser_pct
    FROM resultados_elecciones
    WHERE comuna IN (
        'Arica', 'Iquique', 'Antofagasta', 'Copiapo', 'La Serena', 'Valparaíso',
        'Santiago', 'Rancagua', 'Talca', 'Chillan', 'Concepcion', 'Temuco',
        'Valdivia', 'Puerto Montt', 'Coyhaique', 'Punta Arenas'
    )
),
GanadoresCapitales AS (
    -- CTE 2: DETERMINACIÓN DEL GANADOR EN CADA CAPITAL
    SELECT
        comuna,
        region,
        jara_pct,
        kast_pct,
        parisi_pct,
        kaiser_pct,
        CASE
            WHEN jara_pct >= kast_pct AND jara_pct >= parisi_pct AND jara_pct >= kaiser_pct
            THEN 'Jeannette Jara'
            WHEN kast_pct >= jara_pct AND kast_pct >= parisi_pct AND kast_pct >= kaiser_pct
            THEN 'José Antonio Kast'
            WHEN parisi_pct >= jara_pct AND parisi_pct >= kast_pct AND parisi_pct >= kaiser_pct
            THEN 'Franco Parisi'
            ELSE 'Johannes Kaiser'
        END AS ganador,
        CASE
            WHEN jara_pct >= kast_pct AND jara_pct >= parisi_pct AND jara_pct >= kaiser_pct THEN jara_pct
            WHEN kast_pct >= jara_pct AND kast_pct >= parisi_pct AND kast_pct >= kaiser_pct THEN kast_pct
            WHEN parisi_pct >= jara_pct AND parisi_pct >= kast_pct AND parisi_pct >= kaiser_pct THEN parisi_pct
            ELSE kaiser_pct
        END AS porcentaje_ganador
    FROM CapitalesRegionales
)
-- CONSULTA FINAL: PANORAMA ELECTORAL URBANO POR REGIÓN
SELECT
    comuna AS capital_regional,
    region,
    ganador,
    porcentaje_ganador,
    jara_pct,
    kast_pct,
    parisi_pct,
    kaiser_pct
FROM GanadoresCapitales
ORDER BY region;

-- =======================================================================
-- 4.8. Análisis de Competitividad - Comunas Cercanas para Jeannette Jara
-- =======================================================================
WITH votos_por_comuna AS (
    -- CTE 1: DETERMINACIÓN DEL GANADOR Y CÁLCULO DE VOTOS ABSOLUTOS
    SELECT
        comuna,
        emitidos_votos,
        jara_pct,
        (jara_pct / 100.0) * emitidos_votos AS votos_jara,
        CASE
            -- EVALUACIÓN: EDUARDO ARTES
            WHEN artes_pct >= enriquez_ominami_pct AND artes_pct >= kaiser_pct 
                 AND artes_pct >= kast_pct AND artes_pct >= matthei_pct 
                 AND artes_pct >= mayne_nicholls_pct AND artes_pct >= parisi_pct 
                 AND artes_pct > jara_pct THEN artes_pct
            -- EVALUACIÓN: MARCO ENRÍQUEZ-OMINAMI
            WHEN enriquez_ominami_pct >= artes_pct AND enriquez_ominami_pct >= kaiser_pct 
                 AND enriquez_ominami_pct >= kast_pct AND enriquez_ominami_pct >= matthei_pct 
                 AND enriquez_ominami_pct >= mayne_nicholls_pct AND enriquez_ominami_pct >= parisi_pct 
                 AND enriquez_ominami_pct > jara_pct THEN enriquez_ominami_pct
            -- EVALUACIÓN: JOHANNES KAISER
            WHEN kaiser_pct >= artes_pct AND kaiser_pct >= enriquez_ominami_pct 
                 AND kaiser_pct >= kast_pct AND kaiser_pct >= matthei_pct 
                 AND kaiser_pct >= mayne_nicholls_pct AND kaiser_pct >= parisi_pct 
                 AND kaiser_pct > jara_pct THEN kaiser_pct
            -- EVALUACIÓN: JOSÉ ANTONIO KAST
            WHEN kast_pct >= artes_pct AND kast_pct >= enriquez_ominami_pct 
                 AND kast_pct >= kaiser_pct AND kast_pct >= matthei_pct 
                 AND kast_pct >= mayne_nicholls_pct AND kast_pct >= parisi_pct 
                 AND kast_pct > jara_pct THEN kast_pct
            -- EVALUACIÓN: EVELYN MATTHEI
            WHEN matthei_pct >= artes_pct AND matthei_pct >= enriquez_ominami_pct 
                 AND matthei_pct >= kaiser_pct AND matthei_pct >= kast_pct 
                 AND matthei_pct >= mayne_nicholls_pct AND matthei_pct >= parisi_pct 
                 AND matthei_pct > jara_pct THEN matthei_pct
            -- EVALUACIÓN: HAROLD MAYNE-NICHOLIS
            WHEN mayne_nicholls_pct >= artes_pct AND mayne_nicholls_pct >= enriquez_ominami_pct 
                 AND mayne_nicholls_pct >= kaiser_pct AND mayne_nicholls_pct >= kast_pct 
                 AND mayne_nicholls_pct >= matthei_pct AND mayne_nicholls_pct >= parisi_pct 
                 AND mayne_nicholls_pct > jara_pct THEN mayne_nicholls_pct
            -- EVALUACIÓN: FRANCO PARISI
            WHEN parisi_pct >= artes_pct AND parisi_pct >= enriquez_ominami_pct 
                 AND parisi_pct >= kaiser_pct AND parisi_pct >= kast_pct 
                 AND parisi_pct >= matthei_pct AND parisi_pct >= mayne_nicholls_pct 
                 AND parisi_pct > jara_pct THEN parisi_pct
            ELSE jara_pct
        END AS pct_ganador
    FROM resultados_elecciones
),
diferencia_votos AS (
    -- CTE 2: CÁLCULO DE BRECHA ELECTORAL
    SELECT
        comuna,
        emitidos_votos,
        votos_jara,
        (pct_ganador / 100.0) * emitidos_votos AS votos_ganador,
        ((pct_ganador / 100.0) * emitidos_votos) - votos_jara AS votos_faltantes
    FROM votos_por_comuna
    WHERE pct_ganador > jara_pct
)
-- CONSULTA FINAL: RESUMEN ESTRATÉGICO DE OPORTUNIDADES
SELECT
    'Jeannette Jara' AS candidato,
    COUNT(comuna) AS comunas_por_poco,
    SUM(votos_faltantes) AS total_votos_faltantes,
    ROUND(AVG(votos_faltantes), 0) AS promedio_votos_faltantes,
    ROUND(CAST(COUNT(comuna) AS FLOAT) / (SELECT COUNT(*) FROM diferencia_votos) * 100, 1) AS porcentaje_comunas_competitivas
FROM diferencia_votos
WHERE votos_faltantes <= 1000;

-- =======================================================================
-- 4.9. Análisis de Competitividad - Comunas Cercanas para José Antonio Kast
-- =======================================================================
WITH votos_por_comuna AS (
    -- CTE 1: DETERMINACIÓN DEL GANADOR Y CÁLCULO DE VOTOS ABSOLUTOS
    SELECT
        comuna,
        emitidos_votos,
        kast_pct,
        (kast_pct / 100.0) * emitidos_votos AS votos_kast,
        CASE
            -- EVALUACIÓN: EDUARDO ARTES
            WHEN artes_pct >= enriquez_ominami_pct AND artes_pct >= kaiser_pct 
                 AND artes_pct >= jara_pct AND artes_pct >= matthei_pct 
                 AND artes_pct >= mayne_nicholls_pct AND artes_pct >= parisi_pct 
                 AND artes_pct > kast_pct THEN artes_pct
            -- EVALUACIÓN: MARCO ENRÍQUEZ-OMINAMI
            WHEN enriquez_ominami_pct >= artes_pct AND enriquez_ominami_pct >= kaiser_pct 
                 AND enriquez_ominami_pct >= jara_pct AND enriquez_ominami_pct >= matthei_pct 
                 AND enriquez_ominami_pct >= mayne_nicholls_pct AND enriquez_ominami_pct >= parisi_pct 
                 AND enriquez_ominami_pct > kast_pct THEN enriquez_ominami_pct
            -- EVALUACIÓN: JOHANNES KAISER
            WHEN kaiser_pct >= artes_pct AND kaiser_pct >= enriquez_ominami_pct 
                 AND kaiser_pct >= jara_pct AND kaiser_pct >= matthei_pct 
                 AND kaiser_pct >= mayne_nicholls_pct AND kaiser_pct >= parisi_pct 
                 AND kaiser_pct > kast_pct THEN kaiser_pct
            -- EVALUACIÓN: JEANNETTE JARA
            WHEN jara_pct >= artes_pct AND jara_pct >= enriquez_ominami_pct 
                 AND jara_pct >= kaiser_pct AND jara_pct >= matthei_pct 
                 AND jara_pct >= mayne_nicholls_pct AND jara_pct >= parisi_pct 
                 AND jara_pct > kast_pct THEN jara_pct
            -- EVALUACIÓN: EVELYN MATTHEI
            WHEN matthei_pct >= artes_pct AND matthei_pct >= enriquez_ominami_pct 
                 AND matthei_pct >= kaiser_pct AND matthei_pct >= jara_pct 
                 AND matthei_pct >= mayne_nicholls_pct AND matthei_pct >= parisi_pct 
                 AND matthei_pct > kast_pct THEN matthei_pct
            -- EVALUACIÓN: HAROLD MAYNE-NICHOLIS
            WHEN mayne_nicholls_pct >= artes_pct AND mayne_nicholls_pct >= enriquez_ominami_pct 
                 AND mayne_nicholls_pct >= kaiser_pct AND mayne_nicholls_pct >= jara_pct 
                 AND mayne_nicholls_pct >= matthei_pct AND mayne_nicholls_pct >= parisi_pct 
                 AND mayne_nicholls_pct > kast_pct THEN mayne_nicholls_pct
            -- EVALUACIÓN: FRANCO PARISI
            WHEN parisi_pct >= artes_pct AND parisi_pct >= enriquez_ominami_pct 
                 AND parisi_pct >= kaiser_pct AND parisi_pct >= jara_pct 
                 AND parisi_pct >= matthei_pct AND parisi_pct >= mayne_nicholls_pct 
                 AND parisi_pct > kast_pct THEN parisi_pct
            ELSE kast_pct
        END AS pct_ganador
    FROM resultados_elecciones
),
diferencia_votos AS (
    -- CTE 2: CÁLCULO DE BRECHA ELECTORAL
    SELECT
        comuna,
        emitidos_votos,
        votos_kast,
        (pct_ganador / 100.0) * emitidos_votos AS votos_ganador,
        ((pct_ganador / 100.0) * emitidos_votos) - votos_kast AS votos_faltantes
    FROM votos_por_comuna
    WHERE pct_ganador > kast_pct
),
metricas_jara AS (
    -- CTE 3: CÁLCULO DE MÉTRICAS PARA JARA (PARA COMPARATIVA)
    SELECT
        COUNT(comuna) AS comunas_jara,
        SUM(votos_faltantes) AS total_votos_jara
    FROM (
        SELECT
            comuna,
            (jara_pct / 100.0) * emitidos_votos AS votos_jara,
            (pct_ganador / 100.0) * emitidos_votos - (jara_pct / 100.0) * emitidos_votos AS votos_faltantes
        FROM (
            SELECT
                comuna,
                emitidos_votos,
                jara_pct,
                CASE
                    WHEN artes_pct >= enriquez_ominami_pct AND artes_pct >= kaiser_pct 
                         AND artes_pct >= kast_pct AND artes_pct >= matthei_pct 
                         AND artes_pct >= mayne_nicholls_pct AND artes_pct >= parisi_pct 
                         AND artes_pct > jara_pct THEN artes_pct
                    WHEN enriquez_ominami_pct >= artes_pct AND enriquez_ominami_pct >= kaiser_pct 
                         AND enriquez_ominami_pct >= kast_pct AND enriquez_ominami_pct >= matthei_pct 
                         AND enriquez_ominami_pct >= mayne_nicholls_pct AND enriquez_ominami_pct >= parisi_pct 
                         AND enriquez_ominami_pct > jara_pct THEN enriquez_ominami_pct
                    WHEN kaiser_pct >= artes_pct AND kaiser_pct >= enriquez_ominami_pct 
                         AND kaiser_pct >= kast_pct AND kaiser_pct >= matthei_pct 
                         AND kaiser_pct >= mayne_nicholls_pct AND kaiser_pct >= parisi_pct 
                         AND kaiser_pct > jara_pct THEN kaiser_pct
                    WHEN kast_pct >= artes_pct AND kast_pct >= enriquez_ominami_pct 
                         AND kast_pct >= kaiser_pct AND kast_pct >= matthei_pct 
                         AND kast_pct >= mayne_nicholls_pct AND kast_pct >= parisi_pct 
                         AND kast_pct > jara_pct THEN kast_pct
                    WHEN matthei_pct >= artes_pct AND matthei_pct >= enriquez_ominami_pct 
                         AND matthei_pct >= kaiser_pct AND matthei_pct >= kast_pct 
                         AND matthei_pct >= mayne_nicholls_pct AND matthei_pct >= parisi_pct 
                         AND matthei_pct > jara_pct THEN matthei_pct
                    WHEN mayne_nicholls_pct >= artes_pct AND mayne_nicholls_pct >= enriquez_ominami_pct 
                         AND mayne_nicholls_pct >= kaiser_pct AND mayne_nicholls_pct >= kast_pct 
                         AND mayne_nicholls_pct >= matthei_pct AND mayne_nicholls_pct >= parisi_pct 
                         AND mayne_nicholls_pct > jara_pct THEN mayne_nicholls_pct
                    WHEN parisi_pct >= artes_pct AND parisi_pct >= enriquez_ominami_pct 
                         AND parisi_pct >= kaiser_pct AND parisi_pct >= kast_pct 
                         AND parisi_pct >= matthei_pct AND parisi_pct >= mayne_nicholls_pct 
                         AND parisi_pct > jara_pct THEN parisi_pct
                    ELSE jara_pct
                END AS pct_ganador
            FROM resultados_elecciones
        ) jara_analysis
        WHERE pct_ganador > jara_pct
        AND ((pct_ganador / 100.0) * emitidos_votos - (jara_pct / 100.0) * emitidos_votos) <= 1000
    ) jara_final
)
-- CONSULTA FINAL: RESUMEN ESTRATÉGICO PARA KAST
SELECT
    'José Antonio Kast' AS candidato,
    COUNT(comuna) AS comunas_por_poco,
    SUM(votos_faltantes) AS total_votos_faltantes,
    ROUND(AVG(votos_faltantes), 0) AS promedio_votos_faltantes,
    ROUND(CAST(COUNT(comuna) AS FLOAT) / (SELECT COUNT(*) FROM diferencia_votos) * 100, 1) AS porcentaje_comunas_competitivas,
    CASE
        WHEN COUNT(comuna) > (SELECT comunas_jara FROM metricas_jara) THEN 'Más oportunidades que Jara'
        ELSE 'Menos oportunidades que Jara'
    END AS comparativa_jara,
    COUNT(comuna) - (SELECT comunas_jara FROM metricas_jara) AS diferencia_comunas,
    SUM(votos_faltantes) - (SELECT total_votos_jara FROM metricas_jara) AS diferencia_votos
FROM diferencia_votos
WHERE votos_faltantes <= 1000;

-- =======================================================================
-- 4.10. Análisis: Fenómeno del "Voto Antisistema" - Parisi vs Duopolio Jara-Kast
-- =======================================================================
SELECT
    comuna,
    region,
    parisi_pct AS parisi_porcentaje,
    jara_pct AS jara_porcentaje,
    kast_pct AS kast_porcentaje,
    (jara_pct + kast_pct) AS jara_kast_combinados,
    ROUND(parisi_pct - (jara_pct + kast_pct), 2) AS diferencia_parisi_vs_jara_kast,
    emitidos_votos AS total_votos_emitidos,
    ROUND((parisi_pct / 100) * emitidos_votos, 0) AS votos_parisi,
    ROUND(((jara_pct + kast_pct) / 100) * emitidos_votos, 0) AS votos_jara_kast_combinados
FROM resultados_elecciones
WHERE parisi_pct > (jara_pct + kast_pct)
ORDER BY diferencia_parisi_vs_jara_kast DESC;

-- =======================================================================
-- ANÁLISIS DE RESULTADOS ESPERADOS:
-- =======================================================================

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
