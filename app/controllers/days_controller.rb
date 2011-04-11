class DaysController < ApplicationController

  def index
    @days = Day.all
  end
  
  def new
    @day = Day.new
    @people = Person.all
  end

  def create
  
    @day = Day.new(params[:day])
    @day.when = (Date.today - 1) unless (@day.when)
    if (@day.save)
      @day.shifts.each do |s|
        s.time_in = "7:00 PM" unless (s.time_in)
        s.time_out ="3:00 AM" unless (s.time_out)
        s.save
      end
      
      params[:id] = @day.id
      @people = Person.all
      render 'show'
    else
      flash[:error] = "a day must have at least 1 bartender and 1 barback. don't forget to add the total tips."
      redirect_to :action => 'new'
    end
  end

  def show
    @day = Day.find(params[:id])
  end
  
  def edit
    @day = Day.find(params[:id])
    @people = Person.all
  end
  
  def update
    @day = Day.find(params[:id])
    
    if @day.update_attributes(params[:day])
      flash[:success] = "this page best viewed in landscape."
      redirect_to @day
    else
      flash[:failure] = "what went wrong?"
    end  
  end
  

  def destroy
    @day = Day.find(params[:id])
    @day.destroy

    respond_to do |format|
      format.html { redirect_to(days_url) }
      format.xml  { head :ok }
    end
  end

end
