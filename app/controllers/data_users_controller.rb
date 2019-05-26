class DataUsersController < ApplicationController
    def index

    end
    def new
        @data_user = DataUser.new 
    end
end
