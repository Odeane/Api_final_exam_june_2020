require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Database table' do
    it{is_expected.to have_db_column :body}
  end
end
