# frozen_string_literal: true

class Api::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.create(comment_params)
    render json: {message: "Comment successfully created"}
  end
end

private

def comment_params
  params.require(:comment).permit(:body, :article_id, :user_id)
end
