# Enciso Estimation para iOS

---

## Requisitos Previos

Antes de comenzar, asegúrese de tener lo siguiente instalado en su sistema:

- **Xcode**: Descargar e instalar desde [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12).

## Comenzando

Siga estos pasos para configurar el proyecto en su máquina local:

### 1. Clonar el Repositorio

Abra su terminal y ejecute el siguiente comando para clonar el repositorio y cambiar a la rama `develop`:

```bash
git clone -b develop https://github.com/encisosystems/set-ios.git
```

### 2. Abrir el Proyecto en Xcode

1. Abra **Xcode**.
2. Haga clic en **File** > **Open**.
3. Navegue al directorio donde clonó el repositorio y abra el archivo `set-ios.xcworkspace`.

### 3. Configurar el Proyecto

Si es necesario, configure el equipo de desarrollo y las credenciales en las configuraciones del proyecto (`TARGETS` > `General` > `Signing & Capabilities`).

### 4. Compilar el Proyecto

Para compilar el proyecto, seleccione su dispositivo o simulador en el menú superior de Xcode y haga clic en el botón de **Play** (`Run`) o utilice el atajo `Cmd+R`. Esto compilará el proyecto y lo ejecutará en el dispositivo o simulador seleccionado.

## Solución de Problemas

- **Errores de Compilación**: Si la compilación falla, revise la ventana de **Report Navigator** (`Cmd+8`) para encontrar errores y asegúrese de que todas las dependencias estén correctamente resueltas.

## Contribuyendo

Si desea contribuir al proyecto, siga el flujo de trabajo estándar de Git:

1. Haga un fork del repositorio.
2. Cree una nueva rama (`git checkout -b feature-branch`).
3. Realice sus cambios (`git commit -m 'Agregar alguna característica'`).
4. Empuje a la rama (`git push origin feature-branch`).
5. Abra un Pull Request.
