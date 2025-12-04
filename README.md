# Análisis Electoral Chile 2025 - Primera Vuelta Presidencial 🇨🇱

![Texto alternativo](https://img.shields.io/badge/SQL-Server-blue)
![Texto alternativo](https://img.shields.io/badge/Python-3.9%252B-yellow)
![Texto alternativo](https://img.shields.io/badge/Web-Scraping-orange)
![Texto alternativo](https://img.shields.io/badge/License-MIT-green)

## Descripción
Proyecto integral de análisis de datos electorales que desarrolla un pipeline completo ETL (Extract, Transform, Load) para el procesamiento de resultados de la Primera Vuelta Presidencial Chile 2025

## 🔗 Sub-Repositorios Especializados:
- Web-Scraper - [Extracción automatizada de datos](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/tree/Web-Scraper) 
- Database-Analytics - [Análisis SQL avanzado](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/tree/Database-Analytics)
- Dashboard Interactivo - [Visualización Power BI](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/tree/Dashboard-Interactivo)

### Flujo de datos
**Scraping → Análisis SQL → Dashboard Interactivo**

## 📁 Recursos Disponibles

###  Web-Scraper
Extracción automatizada de datos con Selenium  - [Ver Script](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Web-Scraper/Web%20Scraper.py) 

### Bases de datos
| Recurso | Descripción | Enlace |
|---------|-------------|--------|
| **BBDD formato excel** | Datos completos de resultados electorales 2025 con 346 comunas y 8 candidatos | [Descargar xlsx](https://docs.google.com/spreadsheets/d/1XJR9s8Il2AYSrjNSpRUyOre9RSUEA8eb/edit?usp=drive_link&ouid=113991688143535507558&rtpof=true&sd=true) 
| **BBDD formato csv** | Dataset estructurado para análisis en Python, R y herramientas de data science | [Descargar csv](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/matriz_elecciones_346_comunas.csv) |
| **BBDD formato sql** | Script completo para recrear la base de datos en SQL Server/MySQL/PostgreSQL | [Ver sql](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/inserts_elecciones.sql) |

### Consultas
| Recurso | Descripción | Enlace |
|---------|-------------|--------|
| **10 Consultas SQL** | Análisis especializados con CTEs | [Ver consultas](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/Database-Analytics/elecciones_primera_vuelta.sql) |
| **Documentación Técnica** | Especificaciones y metodología | [Ver pdf](https://drive.google.com/file/d/1mW9CAVGOBeyb44cl3W1zQmI9QsTG5_2r/view) |

### Dashboard Interactivo
| Recurso | Descripción | Enlace |
|---------|-------------|--------|
| **Dashboard PowerBI** |  Análisis electoral interactivo con 4 visualizaciones clave | [Ver pbix](https://drive.google.com/file/d/1bGe04Bc4YZY8WBk-QVvBTQxVYip40A2V/view) |
| **Documentación Técnica** | PDF con arquitectura completa de medidas DAX  | [Ver pdf](https://drive.google.com/file/d/1pCvcPbEHldeqKpTlAHbRLTRdHmSTC69o/view) |

## 🎯 Métricas Principales

### Resultados Electorales oK
| Métrica | Valor | Análisis |
|---------|-------------|--------|
| **Participación Nacional** | 	13.3M votos | 	Base del universo electoral |
| **Ganador 1° Vuelta** | Jeannette Jara - 25.74%  | Mayoría relativa |
| **2° Lugar** | José Antonio Kast - 23.06%| Pasa a segunda vuelta |
| **Diferencia** | 2.68%  | Elección competitiva |

### Análisis Territorial
| Métrica | Valor | Análisis |
|---------|-------------|--------|
| **Comunas Ganadas - Kast** | 	169 (48.8%) | 	Dominio territorial |
| **Comunas Ganadas - Jara** | 105 (30.3%)  | Fuerza en centros urbanos |
| **Comunas Competitivas** | 95 comunas | Jara perdió por <1,000 votos |
| **Votos Faltantes Jara** | 43,778 | Oportunidad estratégica |

### Patrones y Tendencias
| Métrica | Valor | Análisis |
|---------|-------------|--------|
| **Máximo Parisi** | 57.3% (Colchane) | Voto antisistema |
| **Votos Nulos/Blancos** | 3.75% | Protesta electoral |
| **Cobertura Geográfica** | 346 comunas | 100% territorio nacional |
| **Capitales Regionales - Jara** | 10/16 | Dominio en centros urbanos |

## 🛠️ Stack Tecnológico
### Capa de Extracción
```python
Tecnologías: Python 3.9+, Selenium, Pandas, Requests
Propósito: Web scraping datos oficiales SERVEL
Output: Datos crudos en CSV/JSON
```
### Capa de Almacenamiento
```sql
Tecnologías: SQL Server, T-SQL, CSV, Excel
Propósito: Almacenamiento estructurado y consultas
```
### Capa de Análisis
```sql
Tecnologías: CTEs anidadas, Agregaciones, Análisis espacial
Consultas: 10 especializadas en análisis electoral
Performance: Optimizada para 346 comunas
```
### Herramientas de Desarrollo
```text
Control Versiones: Git & GitHub
Documentación: Markdown, PDF
Entorno: VS Code, SSMS
```
### Capa de Visualización
```dax
Tecnologías: Power BI Desktop, DAX (Data Analysis Expressions)
Propósito: Dashboard interactivo con segmentación dinámica
Características:
  - 15 medidas DAX personalizadas
  - 4 visuales interconectados
  - Segmentación por región en tiempo real
  - Formato condicional por candidato
  - Tooltips enriquecidos con KPIs
```



## 🚀 Características Técnicas Destacadas
### Pipeline Completo ETL
- Extracción: Script propio Python + Selenium
- Transformación: Limpieza y estructuración de datos
- Carga: Base de datos SQL Server optimizada
- Análisis: 10 consultas SQL especializadas

### Arquitectura Escalable
- Modularidad en sub-repositorios
- Código reusable para futuras elecciones
- Documentación técnica completa
- Fácil replicación y mantenimiento

### Análisis de Valor
- Insights accionables para estrategias políticas
- Identificación de patrones geopolíticos
- Métricas de competitividad territorial
- Detección de oportunidades de crecimiento

## 🤝 Contribución
Las contribuciones son bienvenidas. Para cambios importantes:
- Fork el proyecto
- Crea una rama para tu feature (git checkout -b feature/AmazingFeature)
- Commit tus cambios (git commit -m 'Add some AmazingFeature')
- Push a la rama (git push origin feature/AmazingFeature)
- Abre un Pull Request

## 📄 Licencia
Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025/blob/main/LICENSE.txt) para detalles.


## 🙏 Agradecimientos
- SERVEL por los datos electorales oficiales
- Comunidad de datos abiertos en Chile
- Contribuidores de herramientas de código abierto

## 🌐 Conéctate Conmigo

**LinkedIn:** [Alfonso Droguett](https://www.linkedin.com/in/adroguetth/)  
**Portafolio Web:** [adroguett-portfolio.cl](https://www.adroguett-portfolio.cl/)  
**Email:** [adroguetth@gmail.com](mailto:adroguetth@gmail.com)

---

*¿Interesado en colaborar? Contáctame para oportunidades en análisis de datos y business intelligence*
