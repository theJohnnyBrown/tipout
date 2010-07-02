class DaysController < ApplicationController

  def index
    @days = Day.all
  end
  
  def new
    @day = Day.new
    @people = Person.all
  end

  def create
  
    @day = Day.new :person_ids => params[:person_ids]
    @day.when = (Date.today - 1) unless (@day.when)
    @day.save
    @day.shifts.each do |s|
      s.time_in = "7:00 PM" unless (s.time_in)
      s.time_out ="3:00 AM" unless (s.time_out)
      s.save
    end

    
    #d = Day.find_by_when @day.when
    #Day should validate presence and uniqueness of when. then if save edit, else if Day.find_by_when(@day.when) edit that. 
    #mind the case where we want to add bartenders to an existing shift
    params[:id] = @day.id
    @people = Person.all
    render 'edit'
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
