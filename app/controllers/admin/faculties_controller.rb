class Admin::FacultiesController < ApplicationController
  before_action :set_faculties
  before_action :set_faculty, :only=>[:edit, :update,:destroy]

  def index
    @faculty = Faculty.new
    refresh
  end 

  def create
    @faculty = Faculty.new(faculty_params)
    if @faculty.save
      @notice = {:success=>"#{@faculty.name} is successfuly created"}
    else
      @notice = {:fail=>@faculty.errors.full_messages}
    end

    @faculty = Faculty.new
    refresh
  end

  def edit

    refresh
  end

  def update

  	@faculty.image = nil if params[:destroy_image] == "1"

    if @faculty.update(faculty_params)
      @notice = {:success=>"#{@faculty.name} is successfuly updated"}
    else
      @notice = {:fail=>@faculty.errors.full_messages}
    end

    @faculty = Faculty.new
    refresh
  end


  def destroy
    if @faculty.destroy
      @notice = {:success=>"#{@faculty.name} is successfuly destroyed"}
    else
      @notice = {:fail=>@faculty.errors.full_messages}
    end

    @faculty = Faculty.new
    refresh
  end

private 
  def set_faculties
    @faculties = Faculty.all.order('id desc')
  end

  def set_faculty
    @faculty = Faculty.find params[:id]
  end 

  def faculty_params
    params.require(:faculty).permit(:name,:email,:intro,:link_url,:image, :program_id, :destroy_image)
  end

  def refresh
    respond_to do |format|
      format.js { render 'admin/faculties/refresh'}
    end
  end


end
