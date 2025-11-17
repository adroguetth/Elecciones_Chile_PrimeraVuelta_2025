# Web Scraper de Resultados Electorales Chilenos 🇨🇱

![Texto alternativo](https://img.shields.io/badge/Python-3.8%252B-blue)
![Texto alternativo](https://img.shields.io/badge/Selenium-WebDriver-orange)
![Texto alternativo](https://img.shields.io/badge/Pandas-Data%2520Analysis-green)
![Texto alternativo](https://img.shields.io/badge/License-MIT-yellow)

## Descripción
Un scraper web automatizado que extrae resultados electorales de todas las comunas de Chile desde el sitio oficial del SERVEL y los estructura en formatos óptimos para análisis de datos.

## 🚀 Características
- 📊 **Extracción Completa:** Procesa automáticamente las 346 comunas de Chile
- 💾 **Datos Estructurados:** Formato tidy-data ideal para análisis estadístico
- 🏙️ **Nombres Normalizados:** Comunas en formato título (Arica vs ARICA)
- 📁 **Múltiples Formatos:** Exporta a CSV y Excel
- 📄 **Metadatos Incluidos:** Documentación automática del dataset
- 🔤 **Naming Convention:** Columnas optimizadas para SQL, Python y DAX
- 🛡️ **Manejo Robusto:** Continuación automática después de errores

## Vista Previa
### Estructura del Dataset
`comuna,region,parisi_votos,parisi_pct,kast_votos,kast_pct,...,blanco_votos,blanco_pct
Arica,Arica y Parinacota,15000,45.50,12000,36.36,...,500,1.50
Santiago,Metropolitana,80000,42.30,75000,39.68,...,1200,0.63`
### Ejemplo de Salida

| comuna| region | parisi_votos | parisi_pct | ... | blanco_votos | blanco_pct |
|--------------|--------------|--------------|--------------|--------------|--------------|--------------|
| Arica     | Arica y Parinacota      | 15000      | 45.50      | ...      | 	500     | 1.50      |
| Santiago     | Metropolitana      | 80000      | 42.30      | ...      | 	1200     | 0.63      |

## Instalación Rápida
### Prerrequisitos
```bash
# Ubuntu/Debian
sudo apt-get install firefox firefox-geckodriver

# macOS
brew install firefox geckodriver

# Windows: Descargar GeckoDriver desde https://github.com/mozilla/geckodriver/releases
```
### Instalación
```bash
# Clonar el repositorio
git clone https://github.com/adroguetth/Elecciones_Chile_PrimeraVuelta_2025.git
cd Elecciones_Chile_PrimeraVuelta_2025

# Instalar dependencias
pip install -r requirements.txt
```
### requirements.txt
```txt
selenium>=4.15.0
pandas>=2.0.0
openpyxl>=3.0.0
```
## 🎯 Uso Inmediato
### Ejecución Básica
```bash
python scraper_elecciones_servel.py
```
### Modo Headless (Recomendado)
```bash
python scraper_elecciones_servel.py --headless
```
### Modo Prueba Rápida
```bash
# Solo 50 comunas para testing
python scraper_elecciones_servel.py --comunas 50 --headless
```
### Logging Detallado
```bash
python scraper_elecciones_servel.py --verbose
```

## 📊 Estructura del Dataset
### Columnas Principales
| Columna | Tipo | Descripción |
|--------------|--------------|--------------|
| comuna      | 	string      | Nombre normalizado (Arica vs ARICA)      |
| region      | 	string      | Región normalizada (Maule vs Del Maule)      |
| {candidato}_votos    | int  | 	Votos absolutos por candidato     |
| {candidato}_pct    | float  | Porcentaje de votos (0-100)     |
| blanco_votos    | int  | Votos en blanco     |
| blanco_pct    | 	float  | Porcentaje de votos blancos     |
| nulo_votos   | int  | Votos nulos     |
| nulo_pct   | float  | Porcentaje de votos blancos     |
| emitidos_votos   | int  | Total votos emitidos     |
| emitidos_pct   | float  | Porcentaje de participación     |

### Candidatos Incluidos
```Python
# Mapeo automático de nombres
"FRANCO PARISI FERNANDEZ" → "parisi"
"JEANNETTE JARA ROMAN" → "jara"
"MARCO ANTONIO ENRIQUEZ-OMINAMI" → "enriquez_ominami"
"JOSE ANTONIO KAST RIST" → "kast"
"EVELYN MATTHEI FORNET" → "matthei"
# ... y más
```
### ⚡ Rendimiento
| Columna | Valor |
|--------------|--------------|
| ⏱️ Tiempo estimado     | 	35-60 minutos      |
| 🧠 Memoria RAM     | 	~500 MB      |
| 💾 Almacenamiento      | 	50-100 MB     |
| 🏙️ Comunas/hora      | 	300-400     |
| 💾 Guardado automático      | 	Cada 10 comunas     |

## 🐛 Solución de Problemas
### Error: GeckoDriver no encontrado
```Bash
# Ubuntu/Debian
sudo apt-get install firefox-geckodriver

# Verificar instalación
which geckodriver
```
### Error: Timeout en carga
```Python
# En el código, aumentar tiempos de espera
self.TIEMPO_ESPERA_CARGA = 30  # 30 segundos
```

### Error: Elementos no encontrados
- Verificar que https://elecciones.servel.cl/ esté accesible
- Ejecutar con --verbose para debugging detallado

### Monitoreo en Tiempo Real
```bash
# Ver logs
tail -f scraper_elecciones.log

# Buscar errores
grep "ERROR" scraper_elecciones.log
```
## 🔧 Personalización
### Ajustar Tiempos de Espera
```Python
# En el script principal
self.TIEMPO_ESPERA_CARGA = 20      # Carga inicial
self.TIEMPO_ESPERA_SELECCION = 5   # Filtros
self.TIEMPO_ESPERA_DATOS = 6       # Datos después de selección
```
### Agregar Candidatos
```Python
self.MAPEO_CANDIDATOS = {
    "NUEVO CANDIDATO": "nuevo_candidato",
    # ... candidatos existentes
}
```
### Limitar Extracción
```Python
# Procesar solo regiones específicas
regiones_a_procesar = ["METROPOLITANA DE SANTIAGO", "DE VALPARAISO"]
```
## 🤝 Contribuciones
¡Contribuciones son bienvenidas!
- 🍴 Haz fork del proyecto
- 🌿 Crea una rama: git checkout -b feature/nueva-caracteristica
- 💾 Commit tus cambios: git commit -m 'Agrega nueva característica'
- 📤 Push a la rama: git push origin feature/nueva-caracteristica
- 🔀 Abre un Pull Request
  
### Guía de Estilo
 - Sigue PEP 8 para código Python
 - Usa type hints
 - Incluye docstrings
 - Mantén la compatibilidad con versiones anteriores
   
## 📄 Licencia
Este proyecto está bajo la Licencia MIT - ver el archivo LICENSE para detalles.

** Nota importante**: El uso de datos extraídos debe cumplir con los términos de uso del SERVEL y las leyes chilenas de protección de datos.

## 👨‍💻 Autor
**Alfonso Droguett** [GitHub](https://github.com/adroguetth/)
**LinkedIn:** [Alfonso Droguett](https://www.linkedin.com/in/adroguetth/)  
**Portafolio Web:** [adroguett-portfolio.cl](https://www.adroguett-portfolio.cl/)  
**Email:** [adroguetth@gmail.com](mailto:adroguetth@gmail.com)

## 🙋‍♂️ Soporte
Si encuentras problemas:
- 📖 Revisa los issues existentes
- 🐛 Crea un nuevo issue con:
    - Descripción detallada del problema
    - Pasos para reproducirlo
    - Logs relevantes
    - Configuración de tu entorno
      
## 🎯 Casos de Uso Ideales
### Para Investigadores
- 📊 Análisis de patrones de voto
- 🎯 Estudios de participación ciudadana
- 📈 Investigación en ciencia política

### Para Analistas de Datos
- 📋 Business intelligence electoral
- 🗺️ Segmentación geográfica
- 📉 Análisis de tendencias

### Para Desarrolladores
- 🔌 API de datos electorales
- 📱 Aplicaciones móviles
- 🌐 Dashboards web

---
  ⭐ ¡Si este proyecto te fue útil, por favor dale una estrella en GitHub!
---   
_Última actualización: Noviembre 2025_
