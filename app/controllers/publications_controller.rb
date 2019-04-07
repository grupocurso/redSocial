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
    def show
        @publication = Publication.find params[:id] #Hace una busqueda del dato, por su id para mostrarlo
    end
    def index
        @publications = Publication.all
    end
    def edit
        @publication = Publication.find params[:id]
    end
    def update
        @publication = Publication.find params[:id]
        @publication.update publication_params
        redirect_to @publication
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
end
