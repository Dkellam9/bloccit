class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(params.require(:question).permit(:title, :body, :resolved))
    if @question.save
      flash[:notice] = "Question saved."
      redirect_to @question
    else
      flash[:error] = "Error saving question"
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params.require(:question).permit(:title, :body, :resolved))
      flash[:notice] = "Question updated."
      redirect_to @question
    else
      flash[:error] = "Error saving question."
      render :edit
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:notice] = "Question deleted."
      redirect_to questions_path
    else
      flash[:error] = "Error deleting question."
      render :show
    end
  end
end
