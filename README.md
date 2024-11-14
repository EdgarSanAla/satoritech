# Prueba técnica de Desarrollador iOS en Satoritech
Aplicación de iOS para consultar imágenes en unsplash.com

## Descripción
Este proyecto es una aplicación móvil para iOS que permite a los usuarios buscar imágenes de **Unsplash** a través de un **SearchBar**. Los usuarios pueden explorar imágenes, ver detalles sobre ellas, como el autor, y consultar información adicional proporcionada por la API de Unsplash.

### Características
- Búsqueda de imágenes utilizando la API de Unsplash.
- Visualización de imágenes, incluyendo el autor y descripcion de cada una.
- Caché de imágenes para optimizar el rendimiento y evitar solicitudes redundantes.
- Diseño simple y limpio con UIKit a traves de código.
- Implementación de la arquitectura **VIPER** para una estructura modular y escalable.

## Tecnologías utilizadas

- **Swift 5.x**
- **UIKit**: Framework principal para la interfaz de usuario.
- **URLSession**: Realiza solicitudes HTTP a la API de Unsplash.
- **NSCache**: Implementa un sistema de caché en memoria para almacenar imágenes descargadas y contenido para mejorar el rendimiento.
- **Xcode 16** o superior.
- **iOS 18.1** o superior.
- **Arquitectura VIPER**: Estructura modular que divide la app en módulos independientes para facilitar la mantenibilidad y escalabilidad.

## Variables de entorno

Es necesario configurar la siguiente variable de entorno para el correcto funcionamiento de la app:

- `UNSPLASH_ACCESS_KEY`: Esta es la **Access Key** de la API de Unsplash, la cual se puede obtener al registrarse en [Unsplash Developers](https://unsplash.com/developers).

### Cómo configurar la variable de entorno:
1. En Xcode, abre el proyecto.
2. Navega a **Product > Scheme > Edit Scheme**.
3. En la sección **Run**, selecciona la pestaña **Arguments**.
4. Añade la variable de entorno `UNSPLASH_ACCESS_KEY` con tu clave de acceso.

## Instalación

Para ejecutar este proyecto en tu entorno local, sigue estos pasos:

1. Clona el repositorio:
   ```bash
   git clone https://github.com/EdgarSanAla/satoritech.git
