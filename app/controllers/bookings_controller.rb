class BookingsController < ApplicationController


  def show
      build_para = booking_params
      
      @booking = Booking.joins(:seat_id, :table_id).where(user_id: nil)
      
      if(!build_para[:floor].empty?)
        @booking = @booking.where(seat_number: {table_number: {floor: build_para[:floor]}})
      end
      
      if(!build_para[:zone].empty?)
        @booking = @booking.where(seat_number: {table_number: {zone: build_para[:zone]}})
      end
      
      if(!build_para[:with_window].empty?)
        @booking = @booking.where(seat_number: {table_number: {with_window: build_para[:with_window]}})
      end
      
      if(!build_para[:with_charge].empty?)
        @booking = @booking.where(seat_number: {table_number: {with_charge: build_para[:with_charge]}})
      end
      
      if(!build_para[:timestart].empty?)
        @booking = @booking.where(seat_number: {table_number: {timestart: build_para[:timestart]}})
      end
      
      if(!build_para[:timeend].empty?)
        @booking = @booking.where(seat_number: {table_number: {timeend: build_para[:timeend]}})
      end
      
      
      @booking = @booking.paginate(page: params[:page])
      render 'index'
      return
    
  end


  def index
    @bookings = Booking.where(user_id: nil).paginate(page: params[:page])
    #@bookings = @bookings.all

  end

  def new
    @booking = Seat.find(params[:seat_id]).bookings.build
    @@seat_id = params[:seat_id]
  end


  def create
    build_para = booking_params
    

    
    @booking = Seat.find(@@seat_id).bookings.build(build_para)
    
    
    if build_para[:timeend].to_i - build_para[:timestart].to_i <= 0
      @booking.errors.add(:base, "time end not larger than time start!")
      flash[:danger] = "Created new booking unsuccessfully"
      render 'new'
      return
    end
    
    #Table.find(@@table_id).seats<<@seat

    if @booking.save
      # Handle a successful save.
      flash[:success] = "Created new booking successfully!"
      redirect_to Seat.find(@@seat_id).table
    else
      flash[:danger] = "Created new booking unsuccessfully"
      render 'new'
    end
  end


  def edit
    @booking = Booking.find(params[:id])
  end
  
  def update
    @booking = Booking.find(params[:id])
    if @booking.update_attributes(booking_params)
      # Handle a successful update.
      flash[:success] = "Seat updated"
      redirect_to Table.find(@booking.seat.table.id)
    else
      render 'edit'
    end
  end
  
  
  
  def destroy
    table_id = Booking.find(params[:id]).seat.table.id
    Booking.find(params[:id]).destroy
    flash[:success] = "Booking destroyed."
    redirect_to Table.find(table_id)
  
  end
  
  def book
    Booking.find(params[:id]).update_attribute(:user_id, current_user.id)
    @bookings = Booking.where(user_id: nil).all
    render 'index'
  end
  
  def unbook_totable
    Booking.find(params[:id]).update_attribute(:user_id, nil)
    @table = Booking.find(params[:id]).seat.table

    redirect_to @table
  end
  
  def unbook_toprofile
    Booking.find(params[:id]).update_attribute(:user_id, nil)
    @user = current_user
    redirect_to @user
  end
  
  def check
    @booking = Booking.new
  end

########### private ###########  
  private
  
    def booking_params                         # strong parameter
      params.require(:booking).permit(:timestart, :timeend, :user_id, :floor, :zone, :with_window, :withcharge, :timestart, :timeend, :confirmation)
    end


end
