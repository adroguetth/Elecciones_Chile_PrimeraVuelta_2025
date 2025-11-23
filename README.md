# Análisis de Elecciones Primera Vuelta Presidencial Chile 2025
## 📊 Descripción del Proyecto
Análisis integral de los resultados de la Primera Vuelta Presidencial chilena 2025, desarrollado con SQL Server (T-SQL). Este proyecto examina 346 comunas a nivel nacional, identificando patrones geográficos, competitividad electoral y comportamiento del votante mediante consultas avanzadas y análisis espacial.

## 🎯 Objetivos del Análisis
- **Distribución Nacional**: Analizar la distribución de votos por candidato a nivel nacional
- **Bastiones Electorales**: Identificar comunas con mayor apoyo por candidato
- **Competitividad**: Detectar comunas con diferencias estrechas entre candidatos
- **Patrones Regionales**: Examinar tendencias por región y capitales regionales
- **Fenómeno Antisistema**: Investigar el voto de protesta contra el duopolio político

## 🗃️ Modelo de Datos
- **Fuente:** SERVEL (Servicio Electoral de Chile)
- **Extracción:** Python con Selenium
- **Cobertura:** 346 comunas a nivel nacional

### Estructura Principal:
- Tabla `resultados_elecciones` con porcentajes y votos por candidato
- 8 candidatos presidenciales analizados
- Métricas de participación electoral (votos emitidos, blancos, nulos)

## 🏗️ Arquitectura de Consultas
### Estadísticas Generales de Participación Electoral
- Cálculo de métricas fundamentales de participación ciudadana
- Análisis de votos válidos, blancos y nulos
- Establecimiento del universo electoral base

### Resultados Nacionales por Candidato
- Agregación nacional y clasificación por niveles de apoyo
- Transformación estructural de datos
- Identificación de candidatos competitivos

### Identificación para Segunda Vuelta
- Determinación automática según ley chilena
- Validación de umbrales constitucionales
- Clasificación de posiciones

### Top 10 Comunas por Candidato
- Identificación de bastiones electorales
- Determinación de victorias por comuna
- Análisis de patrones geográficos
  
### Mapeo Territorial de Victorias
- Cuantificación de dominio territorial
- Ranking de presencia geográfica
- Análisis exhaustivo por comuna

### Resultados por Región
- Agregación regional y determinación de ganadores
- Patrones geográficos de apoyo
- Análisis comparativo interregional

### Capitales Regionales - Análisis Urbano
- Comportamiento electoral en centros urbanos
- Tendencias en capitales regionales
- Segmentación por perfil urbano

### Análisis de Competitividad (Primeras mayorias)
- Cálculo de brechas electorales para Jara y Kast
- Identificación de oportunidades estratégicas
- Métricas de viabilidad electoral

### Fenómeno "Voto Antisistema"
- Análisis del rechazo al duopolio político
- Identificación de enclaves antisistema
- Cuantificación del voto de protesta

## 🛠️ Stack Tecnológico
- **Base de Datos**: SQL Server (T-SQL)
- **Extracción de Datos:** Python con Selenium
- **Enfoque Analítico:** Common Table Expressions (CTEs)
- **Métricas:** Agregaciones espaciales y porcentuales


## 📁 Estructura del Proyecto (pendiente)

## Consultas y Documentación
| Recurso | Descripción | Enlace |
|---------|-------------|--------|
| **Documentación Técnica** | Análisis completo | [Ver PDF](https://drive.google.com/file/d/1CSknkwxA8Pig7hlm-wBCMDfJIa2oft6l/view?usp=sharing) |
| **Código Principal - Compatible con SQL Server** | Script SQL| [Ver código](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/elecciones_primera_vuelta.sql) |
| **README.md** | Este archivo | - |

## Bases de datos
| Recurso | Descripción | Enlace |
|---------|-------------|--------|
| **Documentación Técnica** | Análisis completo | [Ver PDF](https://drive.google.com/file/d/1CSknkwxA8Pig7hlm-wBCMDfJIa2oft6l/view?usp=sharing) |
| **Código Principal - Compatible con SQL Server** | Script SQL| [Ver código](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/elecciones_primera_vuelta.sql) |
| **README.md** | Este archivo | - |

### Diagramas de Consultas
| Recurso | Descripción | Enlace (Github) | Enlace (externo) |
|---------|-------------|--------|--------|
| Consulta 1: **Estadísticas Generales de Participación Electoral** | Análisis completo | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |
| Consulta 2: **Resultados Nacionales por Candidato** | Script SQL| [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%202%3A%20Resultados%20Nacionales%20por%20Candidato.png) |[Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |
| Consulta 3: **Identificación de Candidatos para Segunda Vuelta** | Script SQL| [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%203%3A%20Identificaci%C3%B3n%20de%20Candidatos%20para%20Segunda%20Vuelta.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |
| Consulta 5: **Mapeo Territorial de Victorias por Candidato** | Script SQL| [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%203%3A%20Identificaci%C3%B3n%20de%20Candidatos%20para%20Segunda%20Vuelta.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |
| Consulta 6: **Resultados por Región** | Script SQL| [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%203%3A%20Identificaci%C3%B3n%20de%20Candidatos%20para%20Segunda%20Vuelta.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |
| Consulta 7: **Resultados por Capital Regional - Análisis de Centros Urbanos** | Script SQL| [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%203%3A%20Identificaci%C3%B3n%20de%20Candidatos%20para%20Segunda%20Vuelta.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |
| Consulta 8: **Análisis de Competitividad - Comunas Cercanas para Jeannette Jara** | Script SQL| [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%203%3A%20Identificaci%C3%B3n%20de%20Candidatos%20para%20Segunda%20Vuelta.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |
| Consulta 9: **Análisis de Competitividad - Comunas Cercanas para José Antonio Kast** | Script SQL| [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%203%3A%20Identificaci%C3%B3n%20de%20Candidatos%20para%20Segunda%20Vuelta.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |
| Consulta 10: **Análisis: Fenómeno del "Voto Antisistema" - Parisi vs Duopolio Jara-Kast** | Script SQL| [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%203%3A%20Identificaci%C3%B3n%20de%20Candidatos%20para%20Segunda%20Vuelta.png) | [Ver diagrama](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/Diagramas%20de%20consultas/Consulta%201%3A%20Estad%C3%ADsticas%20Generales%20de%20Participaci%C3%B3n%20Electoral.png) |


## 📈 Hallazgos Principales
### Patrones Geográficos
- Segmentación Norte-Sur: Parisi domina norte minero, Kast domina sur agrícola
- Urbanización: Jara fuerte en áreas metropolitanas
- Ruralidad: Kast con mejor desempeño en comunas rurales

### Competitividad Electoral
- Elección muy reñida entre primeros dos lugares
- 95 comunas decididas por menos de 1,000 votos para Jara
- 68 comunas altamente competitivas para Kast

### Tendencias de Voto
- Voto "antisistema" significativo liderado por Parisi
- Distribución regional marcada y predecible
- Alta fragmentación en primera vuelta

## 🔍 Métricas Clave
- Participación: 13,388,455 votos emitidos
- Votos Válidos: 96.25% del total
- Candidatos a 2da Vuelta: Jeannette Jara (25.74%) y José Antonio Kast (23.06%)
- Dominio Territorial: Kast gana en 169 comunas vs 105 de Jara

## 🚀 Consideraciones Técnicas
- Estructura de datos normalizada
- Consultas documentadas y modulares
- Capacidad de escalar para futuras elecciones

### 📋 Metadatos 
- Autor: Alfonso Droguett
- Fecha: Noviembre 2025
- Versión: 1.0

###  🔗 Enlaces Relacionados
- 🌐 **Portafolio Completo**: [https://www.adroguett-portfolio.cl/]
- 📧 **Contacto**: [adroguetth@gmail.com]
