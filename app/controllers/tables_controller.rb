class TablesController < ApplicationController

  before_action :signed_in_user,  only: [:index, :show, :edit, :update, :destroy]
  
  before_action :admin_user,      only: [:new, :create, :edit, :update, :destroy]


  def show
    @table = Table.find(params[:id])
    @seats = @table.seats
  end

  def index
    @tables = Table.paginate(page: params[:page])
  end

  
  def new
    @table = Table.new
  end
  


  def create
    @table = Table.new(table_params)
    if @table.save
      # Handle a successful save.
      
      flash[:success] = "Created new table successfully!"
      redirect_to @table
    else
      flash[:danger] = "Created new table unsuccessfully"
      render 'new'
    end
  end
  
  
  def edit
    @table = Table.find(params[:id])
  end
 
  def update

    @table = Table.find(params[:id])
    if @table.update_attributes(table_params)
      # Handle a successful update.
      flash[:success] = "Table updated"
      redirect_to @table
    else
      render 'edit'
    end
  end
  
 
  def destroy
    Table.find(params[:id]).destroy
    flash[:success] = "Table destroyed."
    redirect_to tables_path
  end
  




########### private ###########  
  private
  
    def table_params                         # strong parameter
      params.require(:table).permit(:floor, :zone, :with_window, :with_charge, :table_number)
    end
  

end

