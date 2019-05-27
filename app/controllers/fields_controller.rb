class FieldsController < ApplicationController
    before_action :set_user 
    def new
        @field = Field.new
    end
    def create
        @field = current_user.fields.new field_params
        if @field.save
            return redirect_to @field
        end
        render 'new'
    end
    def show
        @field = Field.where({user_id: current_user.id, id: params[:id]})
    end
    def index
        @fields = Field.where user_id: current_user.id
    end
    def edit
        @field = Field.find params[:id]
    end
    def update
        @field = Field.find params[:id]
        if @field.update field_params
            return redirect_to @field
        end
        render 'edit'
    end
    def destroy
        @field = Field.find params[:id]
        @field.destroy
        redirect_to fields_path
    end
    def idiom
        #@fields = Field.all
        if !Field.where(lenguage: params[:idi]).empty?
            @fields = Field.where({user_id: current_user.id, lenguage: params[:idi]})
            return render 'index' 
        end
        redirect_to ""
    end

    private 
    def field_params 
        params.require(:field).permit :description, :token, :lenguage
    end

    def set_user 
        if !(current_user)
            redirect_to ""
        end
    end
end
