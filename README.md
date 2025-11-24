# Análisis de Elecciones - Primera Vuelta Presidencial Chile 2025
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
| BBDD formato excel | Datos completos de resultados electorales 2025 con 346 comunas y 8 candidatos | [Descargar xlsx](https://docs.google.com/spreadsheets/d/1XJR9s8Il2AYSrjNSpRUyOre9RSUEA8eb/edit?usp=drive_link&ouid=113991688143535507558&rtpof=true&sd=true) 
| BBDD formato csv | Dataset estructurado para análisis en Python, R y herramientas de data science | [Descargar csv](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/matriz_elecciones_346_comunas.csv) |
| BBDD formato csv | Script completo para recrear la base de datos en SQL Server/MySQL/PostgreSQL | [Ver sql](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/inserts_elecciones.sql) |

### Diagramas de Consultas
| Recurso | Descripción | Enlace (externo) |
|---------|-------------|--------|
| Consulta 1: **Estadísticas Generales de Participación Electoral** | Métricas base de participación electoral nacional - 346 comunas, votos emitidos, blancos y nulos |  [Ver diagrama](https://drive.google.com/file/d/1bwqZWzl0tSgy6HVD6E61RRs1qUwt9Exw/view?usp=drive_link) |
| Consulta 2: **Resultados Nacionales por Candidato** | Distribución porcentual nacional de los 8 candidatos presidenciales | [Ver diagrama](https://drive.google.com/file/d/1x0-_KwpqnDp-3al71E6pxfNa5TbzUScs/view?usp=drive_link) |
| Consulta 3: **Identificación de Candidatos para Segunda Vuelta** | Determinación oficial de los 2 candidatos que continúan en el proceso electoral | [Ver diagrama](https://drive.google.com/file/d/1GfVk7i3TSoFgtiSr5Y69mQwpU8yVSb-c/view?usp=drive_link) | 
| Consulta 5: **Mapeo Territorial de Victorias por Candidato** | Ranking de victorias por comuna - dominio geográfico de cada candidato | [Ver diagrama](https://drive.google.com/file/d/1xH1GVUWHOjt3z4iNrtyoIS1u-dHG59o9/view?usp=drive_link) | 
| Consulta 6: **Resultados por Región** | Análisis de patrones regionales y ganadores por macrozona | [Ver diagrama](https://drive.google.com/file/d/1EEwi56s9LewKTaZzISxAQuy71fyX_UsP/view?usp=drive_link) |
| Consulta 7: **Resultados por Capital Regional - Análisis de Centros Urbanos** | Comportamiento electoral en los 16 principales centros urbanos | [Ver diagrama](https://drive.google.com/file/d/1-QVyZm80cdkgCuNGrufQm-cCEBPmvoMD/view?usp=drive_link) |
| Consulta 8: **Análisis de Competitividad - Comunas Cercanas para Jeannette Jara** | Comunas donde Jara perdió por menos de 1,000 votos - oportunidades | [Ver diagrama](https://drive.google.com/file/d/1WqriGhCdsBQW9YqNjWGwdeyXYfEJWXqe/view?usp=drive_link) | 
| Consulta 9: **Análisis de Competitividad - Comunas Cercanas para José Antonio Kast** | Análisis paralelo de oportunidades territoriales para Kast | [Ver diagrama](https://drive.google.com/file/d/1m4903ECXliElVWMcWY4L3QZbnbZDEJdh/view?usp=drive_link) | 
| Consulta 10: **Análisis: Fenómeno del "Voto Antisistema" - Parisi vs Duopolio Jara-Kast** | Comunas donde Parisi supera a Jara y Kast combinados | [Ver diagrama](https://drive.google.com/file/d/1mEQdTLL4JjAHF6Pem6cjEz-QdR13Smfp/view?usp=drive_link) | 


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
