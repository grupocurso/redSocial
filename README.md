## Red Social
Primero iniciamos creando el proyecto con el comando ```rails new social-red --database=postgresql```.

Una vez creado el proyecto pasaremos a crear y migrar la base de datos que usara nuestra aplicación ```rails db:create db:migrate```.

Para verificar que todo funciono ejecutamos el servicio ```rails s```

### Publication
Ahora pasaremos a agregar las publicaciones que se podran hacer en nuestra red social

**Crear y migrar modelo**

*   ```rails g model publication description like:integer view:integer```: Con este comando generaremos el modelo base que vamos a usar para las publicaciones, posteriormente se modificara conforme avancemos. El nombre del modelo debe de estar en singular, esto es parte de las convenciones de rails.

*   ```rails db:migrate```: Pasaremos a migrar el modelo a nuestra base de datos.

*   ```rails db```: Para acceder a la base de datos existente en el motor de postgresql ```\d``` para listar las tablas en la base de datos.

**Rutas**

Pasaremos a agregar las rutas y a crear una vista preliminar para verificar que este funcionando bien.

*   En el archivo **routes.rb** es donde se pondrar las rutas de nuestra aplicación.

**routes.rb**
```rb
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :publications
end
```

*   ```rails routes```: Nos servira para poder ver las rutas que existen en nuestra aplicación.

*   ```rails g controller Publications```: El controlador generado debe de estar en plural con respecto al nombre del modelo al cual se va a hacer la referencia.

*   Nos dirigimos a nuestro controlador recien creado ```publications_controller.rb``` por convencion el nombre lleva agregado a el ***_controller***. En el controlador definiremos el acceso de la ruta, por que aunque ya definimos las rutas aun no hemos especificado el acceso, el acceso a la ruta consta de dos partes, el **controlador** y la **vista**.

**publications_controller.rb**
```rb
class PublicationsController < ApplicationController
    def index
    end
end
```

*   Ya definimos el acceso en el controlador, ahora falta definir la vista, en el directorio **app/views** veremos que exista una folder llamado **publications** cuando generamos nuestro controlador tambien fue generado este folder, en el pondremos las vistas de nuestro controlador **publications_controller**, las vistas en rails tienen la extension **.html.erb**.

**index.html.erb**
```html
Hola mundo :D
```
*   Ahora para poder verificar que todo funciona bien ejecutaremos el servidor ```rails s``` y accederemos a la ruta ```http://localhost:3000/publications```.