class DaysController < ApplicationController
  def new
    @day = Day.new
    @people = Person.all
  end

  def create
    @day = Day.new :when => params[:when], :total_tips => params[:total_tips].to_i, :tipout_pct => params[:tipout_pct].to_i, :person_ids => params[:person_ids]
    @day.save
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
