class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: %i[ show edit update destroy ]

  # GET /questionnaires
  def index
    @questionnaires = Questionnaire.all
  end

  # GET /questionnaires/1
  def show
  end

  # GET /questionnaires/new
  def new
    @questionnaire = Questionnaire.new
    @questionnaire.questions.build
  end

  # GET /questionnaires/1/edit
  def edit
  end

  # POST /questionnaires
  def create
    @questionnaire = Questionnaire.new(questionnaire_params)

    if @questionnaire.save
      redirect_to @questionnaire, notice: "Questionnaire was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questionnaires/1
  def update
    if @questionnaire.update(questionnaire_params)
      redirect_to @questionnaire, notice: "Questionnaire was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questionnaires/1
  def destroy
    @questionnaire.destroy!
    redirect_to questionnaires_url, notice: "Questionnaire was successfully destroyed."
  end

  def save_responses
    puts '======================================================'
    puts params
    puts '======================================================'

    @questionnaire = Questionnaire.find(params[:id])

    params[:responses]&.each do |question_id, response_text| # 여기서 '&'를 사용하는 이유가 머야?
      question = Question.find(question_id)

      case question.question_type
        when 'multiple_choice'
          selected_answers = response_text.map do |answer_id|
            answer = question.answers.find(answer_id)
            answer.name
          end
          Response.create(questionnaire_id: @questionnaire.id, question_id: question_id, response_text: selected_answers.to_json)

        when 'single_choice'
          answer = question.answers.find(response_text)
          Response.create(questionnaire_id: @questionnaire.id, question_id: question_id, response_text: answer.name)

        when 'long_answer'
          Response.create(questionnaire_id: @questionnaire.id, question_id: question_id, response_text: response_text)
      end
    end

    redirect_to @questionnaire, notice: "Responses saved successfully."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def questionnaire_params
      params.require(:questionnaire).permit(
        :name,
        questions_attributes: [
          :_destroy, #얘가 대체 뭘까요?
          :id,
          :question_type,
          :name,
          answers_attributes: [:_destroy, :id, :name]
        ]
      )
    end
end
