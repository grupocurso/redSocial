class DataUsersController < ApplicationController
    before_action :set_user
    def index
        @data_users = DataUser.where user_id: current_user.id
    end
    def new
        @data_user = DataUser.new 
    end
    def create
        @data_user = current_user.data_users.new data_user_params
        if @data_user.save
            return render 'index'
        end
        render 'new'
    end

    def show
        @data_user = DataUser.where({user_id: current_user.id, id: params[:id]})
    end
    def edit
        @data_user = DataUser.find params[:id]
    end
    def update
        @data_user = DataUser.find params[:id]
        if @data_user.update data_user_params
            return redirect_to @data_user
        end
        render 'edit'
    end
    def destroy
        @data_user = DataUser.find params[:id]
        @data_user.destroy
        redirect_to data_users_path
    end

    private
    def data_user_params
        params.require(:data_user).permit :nick, :information
    end

    def set_user
        if !(current_user)
            redirect_to ""
        end
    end
end
