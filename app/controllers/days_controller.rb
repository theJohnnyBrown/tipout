class DaysController < ApplicationController
  def new
    @day = Day.new
    @people = Person.all
  end

  def create
  
    @day = Day.new :person_ids => params[:person_ids]
    @day.save
    @day.shifts.each do |s|
      s.time_in = Time.parse "7:00 PM -0500"
      s.time_out = Time.parse "3:00 AM -0500"      
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
      flash[:success] = "Profile updated."
      redirect_to @day
    else
      flash[:failure] = "what went wrong?"
    end  
  end
  

end
