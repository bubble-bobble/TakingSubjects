# 1) Aplicación toma de ramos
Esta aplicación tiene por objetivo simular la toma de ramos en una casa de estudios, algunas de las funcionalidades son:
- Autorización a módulos por perfiles de usuario
- Inscripcion de asignaturas (por parte de los alumnos)
- Registro de usuarios (por parte del coordinador)

## 1.1) Información
Este proyecto se creo usando:
- .NET Framework 4.8
- Web Forms
- Herramienta LINQ To SQL

### 1.2) Requisitos para su ejecución
- Tener instalado .NET Framework 4.8
- Tener instalado SQL SERVER
- Tener instalado el manejador de paquetes NuGet

# 2) Requerimientos funcionales
## 2.1) Coordinador
El coordinador al iniciar sesión podrá realizar las siguientes operaciones:
- **Crear alumno**: Podrá registrar a un alumno validando que el alumno no se encuentra
registrado.
- **Crear asignatura**: Podrá crear una asignatura ingresando los detalles respectivos.
- **Crear sala**: Podrá crear una sala indicando el tipo de sala (normal, laboratorio, taller).
- **Crear sección**: Podrá crear secciones asociada a una asignatura y asociada a una sala
indicando el cupo que tendrá la sección, por lo que deberá validar que la sala seleccionada
sea la adecuada dependiendo de la capacidad de alumnos que tenga esta. El total de inscritos
queda por defecto en cero.
- **Buscar asignatura**: Permitirá buscar una asignatura indicando su nombre, el la cual deberá
mostrar las secciones asociadas a esta y la sala respectiva.
- **Buscar alumno**: Permita buscar a un alumno por su rut en la cual deberá mostrar la signatura,
la sección y la sala respectiva de los ramos que tiene tomados
- **Buscar sala**: Se cargarán todas las salas y se podrá seleccionar por tipo de sala en la cual se
deben mostrar las secciones y asignaturas que utilizan la salas.
- **Actualizar sala**: se podrá seleccionar una sala y se podrá actualizar solo la capacidad de la
sala.

## 2.2) Alumno
El alumno al iniciar sesión podrá realizar las siguientes operaciones:
- **Tomar asignatura**: Podrá ver las asignaturas y las secciones asociadas en donde podrá visualizar el
total de inscritos que lleva esta. Al realizar esta operación deberá ser capaz de actualizar el
total de inscritos en la sección. No se puede tomar el ramo si esta completa la sección.
- **Ver asignaturas**: Podrá visualizar las asignaturas que ha tomado junto con la sección y la sala
respectiva.
