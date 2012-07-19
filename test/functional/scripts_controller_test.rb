require 'test_helper'

class ScriptsControllerTest < ActionController::TestCase
  setup do
    @script = scripts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scripts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create script" do
    assert_difference('Script.count') do
      post :create, script: { beschreibung: @script.beschreibung, dozent: @script.dozent, erscheinungsdatum: @script.erscheinungsdatum, fachrichtung: @script.fachrichtung, hochschule: @script.hochschule, kurs: @script.kurs, name: @script.name }
    end

    assert_redirected_to script_path(assigns(:script))
  end

  test "should show script" do
    get :show, id: @script
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @script
    assert_response :success
  end

  test "should update script" do
    put :update, id: @script, script: { beschreibung: @script.beschreibung, dozent: @script.dozent, erscheinungsdatum: @script.erscheinungsdatum, fachrichtung: @script.fachrichtung, hochschule: @script.hochschule, kurs: @script.kurs, name: @script.name }
    assert_redirected_to script_path(assigns(:script))
  end

  test "should destroy script" do
    assert_difference('Script.count', -1) do
      delete :destroy, id: @script
    end

    assert_redirected_to scripts_path
  end
end
