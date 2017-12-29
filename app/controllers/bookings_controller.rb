class BookingsController < ApplicationController


  def show
      build_para = check_params
      
      @booking = Booking.where(user_id: nil)
      
      #if(!build_para[:floor].empty?)
        @booking = @booking.joins(:table).where("tables.floor=?", build_para[:floor])
      #end
      
      #if(!build_para[:zone].empty?)
        #@booking = @booking.joins(:table).where("tables.zone=?", build_para[:zone].to_s)
      #end
      
      #if(!build_para[:with_window]==nil)
        @booking = @booking.joins(:table).where("tables.with_window=?", build_para[:with_window])
      #end
      
      #if(!build_para[:with_charge]==nil)
        @booking = @booking.joins(:table).where("tables.with_charge=?", build_para[:with_charge])
      #end
      
      #if(!build_para[:timestart].empty?)
        @booking = @booking.where("timestart=?", build_para[:timestart])
      #end
      
      #if(!build_para[:timeend].empty?)
        @booking = @booking.where("timeend=?", build_para[:timeend])
      #end
        @number = @booking.count
      
      #@booking = @booking.all

      @para_floor = build_para[:floor]
      @para_zone = build_para[:zone]
      @para_window = build_para[:with_window]
      @para_charge = build_para[:with_charge]
      @para_start = build_para[:timestart]
      @para_end = build_para[:timeend]
      
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
    @booking.table = @booking.seat.table
    
    
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
    @bookings = Booking.where(user_id: nil).paginate(page: params[:page])
    flash[:success] = "Booking success!"
    render 'index'
  end
  
  def unbook_totable
    Booking.find(params[:id]).update_attribute(:user_id, nil)
    @table = Booking.find(params[:id]).seat.table
    flash[:success] = "Unbooking success!"
    redirect_to @table
  end
  
  def unbook_toprofile
    Booking.find(params[:id]).update_attribute(:user_id, nil)
    @user = current_user
    flash[:success] = "Unbooking success!"
    redirect_to @user
  end
  
  def check
    @booking = Check.new
  end

########### private ###########  
  private
  
    def booking_params                         # strong parameter
      params.require(:booking).permit(:timestart, :timeend, :user_id)
    end
    
    def check_params
      params.require(:check)
    end


end
