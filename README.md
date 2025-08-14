# 📌 Sistema de Consultas en Prolog – Personas y Partidos

Este proyecto contiene una serie de **hechos y reglas en Prolog** para trabajar con dos dominios diferentes:

1. **Personas y relaciones de amistad**  
2. **Resultados de partidos de fútbol**

La lógica permite realizar consultas simples, compuestas y con condiciones específicas, incluyendo cálculos y relaciones indirectas.

---

## 🚀 Características principales

### **1. Personas y Amistades**
- Registro de **nombre**, **edad** y **profesión**.
- Amistades **bidireccionales automáticas** (no es necesario duplicar los hechos).
- Consulta de personas por:
  - Edad
  - Profesión
  - Combinaciones lógicas (ej. ingeniera o profesora)
- Conexiones **limitadas a un máximo de 2 intermediarios**.

### **2. Partidos y Resultados**
- Registro de partidos con:
  - Grupo
  - Equipos
  - Goles de cada uno
- Consultas:
  - Equipos de un grupo
  - Partidos con resultados específicos (ej. 0–0)
  - Equipos que anotaron más de cierto número de goles
  - Total de goles **solo en partidos ganados**
  - Tabla de goleadores ordenada

---

## 📂 Estructura

```plaintext
├── personas_y_partidos.pl   # Código principal en Prolog
└── README.md                # Este archivo
