RSpec.describe 'POST /api/comments', typ: :request do
  let!(:article){create(:article, title:'Final exam with ruby', body: 'All day every day')}
  let!(:user){create(:user)}
  let!(:user_credentials){user.create_new_auth_token}
  let!(:user_headers){{HTTP_ACCEPT: 'application/json'}.merge!(user_credentials)}

  before do 
    post '/api/comments',
    params:{
      comment:{
        body:' Sometimes ruby is great',
        article_id: article.id
      }
    },headers: user_headers
  end

  it 'should return a 200 response' do
    expect(response).to have_http_status 200
  end

  it 'is expected to return a success mesage' do
    expect(response_json['message']).to eq 'Comment successfully created'
  end

  describe 'non-registered users unsuseccefully comemnt' do
    before do
       post '/api/comments',
       params:{
       comment:{
        body:' Sometimes ruby is great',
        article_id: article.id
      }
    }
    end

    it 'should return a 401 status' do
      expect(response).to have_http_status 401
    end

    it 'is expected to return error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end