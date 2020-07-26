require 'rails_helper'

RSpec.describe "Goals", type: :request do
  describe 'GET #index' do
    it 'responds successfully to retrieve a users active goals' do
      get '/goals', headers: authenticated_header
    
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #completed_goals' do
  it 'responds successfully to retrieve a users completed goals' do
    get '/goals-complete', headers: authenticated_header
  
    expect(response).to have_http_status(:success)
  end
end

  describe 'GET #show' do
    before(:example) do
      @goal = create(:goal)
      @goal_params = attributes_for(:goal)
      get "/goals/#{@goal.id}", headers: authenticated_header
    end
    
    it 'responds successfully to retrieve a goal' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'when the goal is valid' do
      before(:example) do
        @goal = create(:goal)
        @goal_params = attributes_for(:goal)
        post '/goals', params: { goal: @goal_params }, headers: authenticated_header
      end

      it 'returns http created' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the goal to the database' do
        expect(Goal.last.title).to eq(@goal_params[:title])
    end
  end
end

    describe 'PUT #update' do 
      context 'when the params are valid' do 
        before(:example) do 
          @goal = create(:goal)
          @updated_title = "Updated goal"
          put "/goals/#{@goal.id}", params: { goal: { title: @updated_title } }, headers: authenticated_header
      end

      it 'has a http no content response' do 
        expect(response).to have_http_status(:success)
      end

      it 'updates the goal in the database' do
        expect(Goal.find(@goal.id).title).to eq(@updated_title)
      end
    end
  end

    describe 'DELETE #destroy' do 
    context 'when the goal is valid' do 
      before(:example) do
        goal = create(:goal)
        delete "/goals/#{goal.id}", headers: authenticated_header
      end

      it 'has a http no content response' do 
        expect(response).to have_http_status(:no_content)
      end

      it 'returns http deleted' do
        expect(response).to have_http_status(:no_content) 
      end

      it 'removes the goal from the database' do
        expect(Goal.count).to eq(0)
      end
    end
  end
end
