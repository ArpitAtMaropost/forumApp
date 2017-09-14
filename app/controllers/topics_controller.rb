class TopicsController < ApplicationController
  before_filter :check_user_logged_in, :except => [:general, :past, :project, :scheduled, :index]
  before_filter :check_admin, :only => [:schedule, :update_schedule]

  def index
    redirect_to general_topics_path
  end

  # GET /topics/proposed
  # GET /topics/proposed.json
  def general
    @topics = Topic.non_project.unscheduled.includes(:votes)
    @topics.sort!{|x,y| y.votes.count <=> x.votes.count }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/proposed
  # GET /topics/proposed.json
  def project
    @topics = ProjectTopic.unscheduled
    @topics.sort!{|x,y| y.votes.count <=> x.votes.count }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/proposed
  # GET /topics/proposed.json
  def past
    @topic_groups = Topic.scheduled.past_grouped_by_date
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topic_groups }
    end
  end


  # GET /topics/proposed
  # GET /topics/proposed.json
  def scheduled
    @topic_groups = Topic.upcoming_grouped_by_date
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topic_groups }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    load_topic
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
    respond_to do |format|
      format.html { render 'form' }
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    load_topic
    respond_to do |format|
      format.html { render 'form' }
      format.json { render json: @topic }
    end
  end


  # GET /topics/new
  # GET /topics/new.json
  def new_project
    @topic = ProjectTopic.new
    respond_to do |format|
      format.html { render 'form' }
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit_project
    load_project_topic
    respond_to do |format|
      format.html { render 'form' }
      format.json { render json: @topic }
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    klass = params[:project_topic] ? ProjectTopic : Topic
    topic_params = params[:project_topic] || params[:topic]
    title = params[:project_topic] ? 'Project Topic' : 'Topic'
    @topic = klass.new(topic_params)
    @topic.creator = current_user
    @topic.presenter = current_user
    respond_to do |format|
      if @topic.save
        format.html { redirect_to redirect_path , notice: "#{title} was successfully created." }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render 'form' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    topic_params = params[:project_topic] || params[:topic]
    title = params[:project_topic] ? 'Project Topic' : 'Topic'
    params[:project_topic] ? load_project_topic : load_topic
    respond_to do |format|
      if @topic.update_attributes(topic_params)
        format.html { redirect_to redirect_path, notice: "#{title} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render 'form' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    load_topic.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Topic was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def upvote
    @topic = Topic.find(params[:id])
    redirect_to project_topics_path and return if @topic.type == 'ProjectTopic'
    redirect_to scheduled_topics_path and return if @topic.scheduled_start
    respond_to do |format|
      vote = @topic.votes.build(:user => current_user)
      if vote.save
        format.html { redirect_to general_topics_path, notice: 'Topic was successfully upvoted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to general_topics_path, :flash => {:error => vote.errors.messages.inject(""){|e,(k,m)| e += m.join("\n")}} }
        format.json { render json: vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def schedule
    load_topic
  end

  def update_schedule
    load_topic
    schedule_params = params[:topic] || params[:project_topic]
    @topic.scheduled_start = schedule_params && schedule_params[:scheduled_start]
    respond_to do |format|
      if @topic.save
        format.html { redirect_to scheduled_topics_path, notice: 'Topic was successfully scheduled.' }
        format.json { head :no_content }
      else
        format.html { render 'schedule' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_project_topic
    @topic ||= current_user.admin? ? ProjectTopic.find(params[:id]) :
        current_user.topics.find(:first, :conditions => {:type => 'ProjectTopic', :id => params[:id]})
  end

  def load_topic
    @topic ||= current_user.admin? ? Topic.find(params[:id]) : current_user.topics.find(params[:id])
  end

  def load_topics
    @topics ||= current_user.admin? ? Topic.all : current_user.topics
  end

  def redirect_path
    case
      when @topic.scheduled_start then scheduled_topics_path
      when params[:project_topic] then project_topics_path
      else general_topics_path
    end
  end

end
