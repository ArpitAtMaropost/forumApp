class ReviewsController < ApplicationController
  before_filter :check_user_logged_in

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = topic.reviews.build
    @review.user = current_user

    respond_to do |format|
      format.html { render 'form' }
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
    render 'form'
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = topic.reviews.build(params[:review])
    @review.user = current_user
    respond_to do |format|
      if @review.save
        format.html { redirect_to reviews_posted_path, notice: 'Review was successfully created.' }
        format.json { render json: @review, status: :created, location: @review }
      else
        flash.now[:error] = @review.errors && @review.errors.messages[:base] && @review.errors.messages[:base].join
        format.html { render 'form' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = current_user.reviews.find(params[:id])
    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to reviews_posted_path, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        flash.now[:error] = @review.errors.messages[:base].join
        format.html { render 'form' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_posted_path }
      format.json { head :no_content }
    end
  end

  def received
    topics = current_user.topics.scheduled.past.order('scheduled_start desc')
    @topics_reviews = topics.collect{|t| [t, t.reviews] }
  end

  def posted
    reviews = current_user.reviews.order('created_at desc')
    @topics_reviews = reviews.collect{|r| [r.topic, [r]] }
  end

  private

  def topic
    Topic.find(params[:topic_id])
  end
end
