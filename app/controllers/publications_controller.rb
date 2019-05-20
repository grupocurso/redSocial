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
