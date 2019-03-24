## Red Social
Primero iniciamos creando el proyecto con el comando ```rails new social-red --database=postgresql```.

Una vez creado el proyecto pasaremos a crear y migrar la base de datos que usara nuestra aplicación ```rails db:create db:migrate```.

Para verificar que todo funciono ejecutamos el servicio ```rails s```

### Publication
Ahora pasaremos a agregar las publicaciones que se podran hacer en nuestra red social

**Crear y migrar modelo**

*   ```rails g model publication description like:integer view:integer```: Con este comando generaremos el modelo base que vamos a usar para las publicaciones, posteriormente se modificara conforme avancemos.

*   ```rails db:migrate```: Pasaremos a migrar el modelo a nuestra base de datos.

*   ```rails db```: Para acceder a la base de datos existente en el motor de postgresql ```\d``` para listar las tablas en la base de datos.
