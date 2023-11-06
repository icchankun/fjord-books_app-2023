# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :check_for_authorization, only: %i[edit update destroy]

  def show; end

  def edit; end

  def create
    @comment = current_user.comments.new(comment_params)
    resource, commentable_id = request.path.split('/')[1, 2]
    @comment.assign_attributes(commentable_id:, commentable_type: resource.classify)

    if @comment.save
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      instance_variable_set("@#{resource.singularize}", @comment.commentable)
      render "#{resource}/show", status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to [@comment.commentable, @comment], notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def check_for_authorization
    redirect_to @comment.commentable if current_user.id != @comment.user_id
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
