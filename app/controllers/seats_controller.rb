class SeatsController < ApplicationController

  before_action :admin_user,      only: [:new, :create, :edit, :update, :destroy]

=begin
  def show
    @seat = Seat.find(params[:id])
  end
=end
=begin
  def index
    @seats = Seat.paginate(page: params[:page])
  end
=end
  
  def new
    #@table = Table.find(params[:table_id])
    @seat = Table.find(params[:table_id]).seats.build
    @@table_id = params[:table_id]
    #@seat = Seat.new
  end
  


  def create
    #@seat = Seat.new(seat_params)
    #@table = Table.find(params[:table_id])
    @seat = Table.find(@@table_id).seats.build(seat_params)
    #Table.find(@@table_id).seats<<@seat

    if @seat.save
      # Handle a successful save.
      flash[:success] = "Created new seat successfully!"
      redirect_to Table.find(@@table_id)
    else
      flash[:danger] = "Created new seat unsuccessfully"
      render 'new'
    end
  end
  
  
  def edit
    @seat = Seat.find(params[:id])
  end
 
  def update
    @seat = Seat.find(params[:id])
    if @seat.update_attributes(seat_params)
      # Handle a successful update.
      flash[:success] = "Seat updated"
      redirect_to Table.find(@seat.table.id)
    else
      render 'edit'
    end
  end
  
 
  def destroy
    table_id = Seat.find(params[:id]).table.id
    Seat.find(params[:id]).destroy
    flash[:success] = "Seat destroyed."
    redirect_to Table.find(table_id)
  end
  




########### private ###########  
  private
  
    def seat_params                         # strong parameter
      params.require(:seat).permit(:seat_number)
    end
  

end
