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

## CRUD - Mantenimiento

Ahora se desarrollara el CRUD o mantenimiento para nuestro modelo, iniciaremos por **crear** información.

### Create
* Primero definiremos la ruta para **new**

**publications_controller.rb**
```rb
class PublicationsController < ApplicationController
    def new
    end
end
```
* Ya tenemos el acceso a la ruta **publications/new**, pero nos falta la vista para dicha ruta, en esta estara nuestro formulario asi que lo agregamos, para el formulario se usara **form_helper**.

**new.html.erb**
```html
<h3>Publicar</h3>

<%= form_for :publication, url: publications_path do |f|  %>
    <%= f.label :description %> <br>
    <%= f.text_field :description %>
    <br>
    <%= f.label :like %> <br>
    <%= f.number_field :like %>
    <br>
    <%= f.label :view %> <br>
    <%= f.number_field :view %>
    <br>
    <%= f.submit %>
<% end %>
```
**Nota:** Podras encontrar mas información sobre el uso de form_helper [aqui](https://guides.rubyonrails.org/form_helpers.html).

* Ya tenemos el formulario de la información que vamos a enviar, ahora definiremos la accion **create** para guardar la información.

**publications_controller.rb**
```rb
class PublicationsController < ApplicationController
    def new
    end
    def create
        @publication = Publication.new
        @publication.save
    end
end
```

* Ahora si corremos el servicio y probamos el funcionamiento no tendremos ningun error, pero si checamos la información en nuestra base de datos no mostrara nada, la información que se guardo esta vacia, esto se debe a que no le hemos dado permiso para guardar la información recibida, para eso definiremos una variable como parametro de la información recibida que podra guardar y la agregamos cuando se crea la nueva publicación.

**publications_controller.rb**
```rb
class PublicationsController < ApplicationController
    def new
    end
    def create
        @publication = Publication.new publication_params #Se almacenan los parametros enviados
        @publication.save
    end
    private #Para definir los parametros requeridos/permitidos
    def publication_params
        params.require(:publication).permit :description, :like, :view
    end
end
```

* ¡Listo!, probamos que la información se guarde.

* Tambien se puede definir valores determinados para la información que se guardara.

**publications_controller.rb**
```rb
class PublicationsController < ApplicationController
    def new
    end
    def create
        @publication = Publication.new publication_params #Se almacenan los parametros enviados
        @publication.like = 0
        @publication.view = 0
        @publication.save #Se guardan los parametros enviados
        redirect_to @publication
    end
    private #Para definir los parametros requeridos/permitidos
    def publication_params
        params.require(:publication).permit :description, :like, :view
    end
end
```

**new.html.erb**
```html
<h3>Publicar</h3>

<%= form_for :publication, url: publications_path do |f|  %>
    <%= f.label :description %> <br>
    <%= f.text_field :description %>
    <br>
    <%= f.submit %>
<% end %>
```
### READ
Ahora pasaremos a leer la información
* Definimos la ruta **publications/id_dato** esto se define en el controlador como **show**

**publications_controller.rb**
```rb
    def show
        @publication = Publication.find params[:id] #Hace una busqueda del dato, por su id para mostrarlo
    end
```

* Agregamos la vista para dicha ruta
**show.html.erb**
```html
<%= @publication.description %>
<br>
<%= @publication.like %>
<%= @publication.view %>
```

* Ahora podemos acceder a dicha información ejemplo seria **localhost:3000/publications/1**, pero vamos a direccionar la creacion del dato a la vista para dicho dato.

**publications_controller.rb**
```rb
    def create
        @publication = Publication.new publication_params #Se almacenan los parametros enviados
        @publication.like = 0
        @publication.view = 0
        @publication.save #Se guardan los parametros enviados
        redirect_to @publication
    end
```

* Ahora crearemos una vista para ver todos los elementos, definimos entonces dicha vista, la pondremos en index que seria la ruta **/publications**.

**publications_controller.rb
```rb
    def index
        @publications = Publication.all #Hace un pedido de todos los datos.
    end
```

* La vista para mostrar toda esa información

**index.html.erb**
```html
<% @publications.each do |publication| %> <!-- un ciclo para leer toda la información -->
    <%= publication.description %>
    <br>
    <%= publication.like %>
    <%= publication.view %>
    <br>
<% end %>
```

* !Listo¡, ahora probamos el funcionamiento.

### UPDATE
Ahora desarrollaremos el metodo de Update para las publicaciones:

* Agregamos un link que nos enviara a la edicion de la información.

**index.html.erb**
```html
<%= link_to 'Edit', edit_publication_path(publication) %><br>
```

* Definimos edit en el controlador y el metodo update para que pueda actualizarse
**publications_controller.rb**
```rb
    def edit
        @publication = Publication.find params[:id]
    end
    def update
        @publication = Publication.find params[:id]
        @publication.update publication_params
        redirect_to @publication
    end
```

* Ahora creamos el archivo que sera la vista con el formulario para editar.

**edit.html.erb**
```html
<h3>Editar</h3>
<%= form_for @publication do |f|  %>
    <%= f.label :description %> <br>
    <%= f.text_field :description %>
    <br>
    <%= f.submit %>
<% end %>
```

### Destroy
Ahora pasaremos a crear el metodo para destruir/eliminar una publicacion

* Para destruir una publicación primero agregamos el link que llamara al metodo, agregamos una confirmación para llamar al metodo.

**index.html.erb**
```html
<% @publications.each do |publication| %> <!-- un ciclo para leer toda la información -->
    <%= publication.description %>
    <br>
    <%= publication.like %>
    <%= publication.view %>
    <br>
    <%= link_to 'Edit', edit_publication_path(publication) %>
    <%= link_to 'Destroy', publication, method: :delete, data: { confirm: 'sure?'} %> <br>
<% end %>
```
* Agregamos el metodo **destroy** al controlador.

**publications_controller.rb**
```rb
    def destroy
        @publication.destroy
        redirect_to publications_path
    end
```
## Parciales
Una buena practica para el desarrollo en Ruby on Rails son la creacion de parciales, puedes verlos como modulos para la vista.
Esto nos servira para evitar el codigo repetido en las vistas. Ejemplo para este proyecto son la vista de la información de las publicaciones y el formulario para crear y actualizar la información.

*   Bien ahora pasaremos a crear un parcial, primero para la vista de la información, el nombre de los parciales inician con un "_", en la carpeta de vistas del controlador creamos el parcial.

**_publication.html.erb**
```html
<%= publication.description %>
<br>
<%= publication.like %>
<%= publication.view %>
<br>
<%= link_to 'Edit', edit_publication_path(publication) %>
<%= link_to 'Destroy', publication, method: :delete, data: { confirm: 'sure?'} %> <br>
```
*   Llamaremos el parcial desde index.html, esta forma es solo aplicable cuando el nombre del parcial es el singular del nombre de la vista.

**index.html.erb**
```html
<%= render @publications %>
```

*   Ahora llamaremos al parcial en la vista show, esta sera de la forma general en como se llama un parcial, entre '' ira el nombre del parcial, seguido del nombre de la variable dentro del parcial y el valor que le pasaremos a dicha variable.

**show.html.erb**
```html
<%= render 'publication', publication: @publication %>
```

Con eso deberia estar listo el parcial de nuestras vistas, ahora pasaremos a agregar el parcial para el formulario.

*   Agregamos el parcial **form** que contendra el formulario, copiamos el contenido de la vista **edit.html.erb** en este parcial.

**_form.html.erb**
```html
<%= form_for @publication do |f|  %>
    <%= f.label :description %> <br>
    <%= f.text_field :description %>
    <br>
    <%= f.submit %>
<% end %>
```

*   Y ahora pasamos a llamar el parcial en la vista edit.

**edit.html.erb**
```html
<h3>Editar</h3>

<%= render 'form' %>
```

*   En el caso de la vista en new no podemos simplemente llamarlo ya que hay algo que nos falta y es la variable **@publication**, asi que no iremos al **publications_controlador.rb** y en la definicion **new** agregaremos esta variable faltante inicializandola como un contenido vacio con la estructura de nuestra tabla.

**publications_controlador.rb**
```rb
    def new
        @publication = Publication.new
    end
```

*   Ahora pasamos a llamar el parcial desde la vista new.

**new.html.erb**
```html
<h3>Publicar</h3>

<%= render 'form' %>
```

*   Y ahora guardamos y corremos el servicio para verificar que todo vaya bien.

### Divise
Para no tener que pelearnos con la creacion de usuarios y la autentificación usaremos la gema de devise. Devise es una solución de autenticación flexible para Rails basada en Warden.

*    Primero instalaremos divise, agregamos nuestra gema

**Gemfile**
```
gem 'devise', git: 'git://github.com/plataformatec/devise.git' 
```
*   Ejecutar los siguientes comandos para actualizar e instalar devise

**Consola**
```
bundle install
rails g devise:install
```

*    Agregar en el archivo development.rb, que es una direccion para mandar email de prueba

**development.rb**
```rb
config.action_mailer.default_url_options = { host: 'localhost', port: 3000}
```
*    Definir una ruta principal del proyecto, esta ruta no requerira de autorización, por ello se necesita especificar cual sera, se hace en el archivo routes.rb

**routes.rb**
```rb
Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :publications
end
```

*    Crear el controlador con la ruta que se acaba de definir como ruta principal, esto desde la consola.
```sh
rails g controller home index
```

*    Ahora indicaremos en nuestro layout pricipal que estaremos utilizando los mensajes flash, sera agregado en la parte del body.

**Add a application.html.erb**
```html
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```

*    Ahora generaremos vistas predefinidas que continene devise, desde consola
**Consola**
```sh
rails g devise:views
```
*    Vamos a generar un modelo, el cual devise utilizara para la autentificación.

**Consola**
```sh
rails g devise user
```

*    (Opcional) Se te generaran varios archivos de los cuales uno es una migración y otro un modelo, en el archivo creado en el directorio db/migrate puedes agregar mas campos.

Ejemplo:
```rb
class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :name,              null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
```
*    Una vez generado y cambiado si es que se hizo migraremos el modelo.

**Consola**
```sh
rails db:migrate
```
*    En caso de haber agregado un campo ir al archivo new.html.erb de las vistas de view/devise/registration, ejemplo:

**Add a new.html.erb**
```html
  <div class="field">
    <%= f.label :name %><br />
    <%= f.text_field :name, autofocus: true %>
  </div>
```
### Navegation with devise

A continuación se explicara como agregar navegación simple para manejar la sesión de usuario

*    Primero agregaremos las opciones que nos dara la barra de sesion de usuario (iniciar, registrar, salir), en el archivo application.html.erb, agregamos lo siguiente en la parte del body.

**Add a application.html.erb**
```html
    <ul class="nav justify-content-end">
      <% if user_signed_in? %>
        <li class="nav-item">
          <%= link_to 'Salir', destroy_user_session_path, method: :delete %>
        </li>
      <% else %>
        <li class="nav-item">
          <%= link_to ' Iniciar', new_user_session_path %>
        </li>
        <li class="nav-item">
          <%= link_to ' Registrarme', new_user_registration_path %>
        </li>
      <% end %>
    </ul>
```
*   Para mostrar una bienvenida cuando inicias sesion, nos vamos al archivo home/

**index.html.erb**
```html
<% if user_signed_in? %>
    <h1>Bienvenido</h1>
    <b><%= current_user.email %></b>
<% else %>
    <h1> Necesitas registrarte o iniciar sesión</h1>
<% end %>
```
*   Ahora agregaremos el archivo para las traducciones de devise, creamos el archivo devise.es.yml en nuestro directorio de traducciones, y agregamos a dicho archivo lo que esta en Tradcucciones Devise

### Devise params

Nuestra aplicación aun no almacena la información de los campos que agregamos al modelo de nuestro usuario, ahora pasaremos a configurar esa parte para que sean guardados.

*    Agregar en nuestro archivo application_controller.rb lo siguiente, ejecutara nuestra definicion solo si existe un devise_controller, y les dara permiso a los campos de nuestro usuario al agregar un nuevo registro de usuario

**application_controller.rb**
```rb
class ApplicationController < ActionController::Base
    before_action :configure_devise_params, if: :devise_controller?

    def configure_devise_params
        devise_parameter_sanitizer.permit(:sign_up) do |user|
            user.permit(:name, :email, :password, :password_confirmation)
        end
    end
end
```
*    Cambiamos el contenido de nuestro home/index.html.erb
```html
<% if user_signed_in? %>
    <h1>Bienvenido <b><%= current_user.name %></b></h1>
<% else %>
    <h1>Por favor iniciar o registrate</h1>
<% end %>
```
### One to Many Relation
Ahora pasaremos a hacer la conexion entre el usuario y datos creados por este usuario, para poder manejar los datos por usuario.

*   Vamos a agregar la referencia del usuario a la tabla

**Consola**
```sh
rails g migration add_user_id_to_publications user:references
rails db:migrate
```

*   Ahora especificaremos que en vez de pedir todos los datos de la tabla publications, me pida solo los que tienen id concernientes al id del usuario, para eso vamos al archivo publications_controller.rb y cambiamos el index

**publications_controller.rb**
```rb
    def index
        @publications = Publication.where user_id: current_user.id
    end
```

*   Pasamos a definir la relación entre las tablas en nuestro modelo, para eso modificaremos dos archivos

**user.rb**
```rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :publications #Le dice que tiene una relacion a muchos datos de publications
end
```

**publication.rb**
```rb
class Publication < ApplicationRecord
    validates :description, presence: true
    belongs_to :user
end
```

*   Para guardar el id del usuario al momento de guardar las publicaciones hacemos las siguientes modificaciones al archivo publications_controller.rb en el metodo create
**publications_controller.rb**
```rb
    def create
        #@publication = Publication.new publication_params #Se almacenan los parametros enviados
        @publication = current_user.publications.new publication_params
        @publication.like = 0
        @publication.view = 0
        if @publication.save #Se guardan los parametros enviados?
            return redirect_to @publication
        end
        render 'new' # o render :new para redireccionar a new
    end
```

### Redireccionamiento
Ya se agregaron algunos redireccionamientos, ahora agregaremos algunos faltantes para que el usuario al tratar de acceder a ciertas URL si no tienes acceso a ellas sea redireccionado, uno es el caso de la direcciion **localhost:3000/publication** cuando no se esta logueado y trata de acceder a ella.

**publication_controller.rb**
```rb
    def index
        #@publications = Publication.all
        if current_user #Esta usando cuenta de usuario - Error=false
            @publications = Publication.where user_id: current_user.id
        else
            redirect_to "" #redirecciona a home
        end
    end
```

Checamos y vemos que funcione, pero si nos fijamos bien ya que todo lo definido en **publication_controller.rb** es solo de acceso para el usuario tendriamos que agregar esta condicion en cada una de las definiciones, para evitar este codigo repetido agregamos un **before_action**

**publication_controller.rb**
```rb
class PublicationsController < ApplicationController
    before_action :set_user # Accion que se ejecutara al inicio de los metodos
    def new
        @publication = Publication.new
    end
    def create
        #@publication = Publication.new publication_params #Se almacenan los parametros enviados
        @publication = current_user.publications.new publication_params
        @publication.like = 0
        @publication.view = 0
        if @publication.save #Se guardan los parametros enviados
            return redirect_to @publication
        end
        render 'new'
    end
    def show
        #@publication = Publication.find params[:id] #Hace una busqueda del dato, por su id para mostrarlo
        @publication = Publication.where({user_id: current_user.id, id: params[:id]})
    end
    def index
        #@publications = Publication.all
        @publications = Publication.where user_id: current_user.id
    end
    def edit
        @publication = Publication.find params[:id]
    end
    def update
        @publication = Publication.find params[:id]
        if @publication.update publication_params
            return redirect_to @publication
        end
        render 'edit'
    end
    def destroy
        @publication = Publication.find params[:id]
        @publication.destroy
        redirect_to publications_path
    end

    private #Para definir los parametros requeridos/permitidos
    def publication_params
        params.require(:publication).permit :description, :like, :view
    end

    def set_user # Definicion de la accion que se quiere que se ejecute
        if !(current_user)
            redirect_to ""
        end
    end
end
```

### Add Bootstrap
Ahora pasaremos a agregar bootstrao a nuestro proyecto.

*   Agregamos la gema de bootstrap y jquery a nuestro **Gemfile**, jquery es necesario para el uso de bootstrap.

**Gemfile**
```
#Use bootstrap and jquery
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'
```
*   Ejecutamos **bundle install** para instalar estas gemas.

*   Ahora necesitamos llamar a a jQuery, la librería Popper.js que se instalo cuando instalamos la gema de Bootstrap y a los archivos Javascript de Bootstrap 4.

**Add a aplication.js**
```js
//= require jquery3
//= require popper
//= require bootstrap
```

*   Ahora necesitamos llamar a los archivos CSS y Javascript de Bootstrap, se incluiran en el head.

**add en head, application.html.erb**
```html
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
```

*   Y solo nos queda importar Bootstrap en la hoja de estilos de la vista en donde se va a usar, como ejemplo se usara la vista de **home/index.html.erb**

**Add a home.scss**
```css
@import "bootstrap";
```

*   Agregaremos botonos con estilos bootstrap a la vista para verificar que todo saliera bien.

**home/index.html.erb**
```html
<% if user_signed_in? %>
    <h1>Bienvenido</h1>
    <b><%= current_user.email %></b>
<% else %>
    <h1> Necesitas registrarte o iniciar sesión</h1>
<% end %>
<button type="button" class="btn btn-primary">Primary</button>
<button type="button" class="btn btn-secondary">Secondary</button>
<button type="button" class="btn btn-success">Success</button>
<button type="button" class="btn btn-danger">Danger</button>
<button type="button" class="btn btn-warning">Warning</button>
<button type="button" class="btn btn-info">Info</button>
<button type="button" class="btn btn-light">Light</button>
<button type="button" class="btn btn-dark">Dark</button>
```

*   Ahora solo queda correr el servidor y verificar que todo funcione.

## Data User
### Generate data user
Necesitamos una tabla para contener toda la información del usuario, ahora tenemos una cuenta de usuario, pero dicha cuenta solo tiene información basica, crearemos una tabla para información mas especifica del usuario.

*   Generamos el modelo para esta tabla y la migramos.
```
rails g model data_user nick information
rails db:migrate
```

*   Ahora generamos el controlador.
```
rails g controller DataUsers
```

*   Agregamos a la ruta.
**routes.rb**
```rb
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  get '', to: 'home#index' 
  resources :publications
  resources :data_users
end
```

*   Definimos index en el controlador y creamos la vista index para probar.
**data_users_controller.rb**
```rb
class DataUsersController < ApplicationController
    def index

    end
end
```
**data_users/index.html.erb**
```html
Hola soy Data Users
```