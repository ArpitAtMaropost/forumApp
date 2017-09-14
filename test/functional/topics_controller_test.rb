require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @topic = load_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:load_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic" do
    assert_difference('Topic.count') do
      post :create, load_topic: { creator_id: @topic.creator_id, description: @topic.description, presenter_id: @topic.presenter_id, title: @topic.title }
    end

    assert_redirected_to topic_path(assigns(:load_topic))
  end

  test "should show topic" do
    get :show, id: @topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic
    assert_response :success
  end

  test "should update topic" do
    put :update, id: @topic, load_topic: { creator_id: @topic.creator_id, description: @topic.description, presenter_id: @topic.presenter_id, title: @topic.title }
    assert_redirected_to topic_path(assigns(:load_topic))
  end

  test "should destroy topic" do
    assert_difference('Topic.count', -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to topics_path
  end
end
