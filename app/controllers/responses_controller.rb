class ResponsesController < ApplicationController
    before_action :set_response, only: %i[ show edit update destroy]

    def index
        @responses = Response.all
    end

    def show
    end

    def new
        @response = Response.new
    end

    def create
        @response = Response.new(response_params)

        respond_to do |format|
            if @response.save
                format.html { redirect_to response_url(@response), notice: "Response was successfully created." }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @response.update(response_params)
                format.html { redirect_to response_url(@response), notice: "Response was successfully updated."}
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @response.destroy!

        respond_to do |format|
            format.html { redirect_to responses_url, notice: "Response was successfully destroyed."}
        end
    end

    # def save_responses
    #     puts '======================================================'
    #     puts params
    #     puts '======================================================'

    #     questionnaire = Questionnaire.find(params[:questionnaire_id])
    #     puts "questionnaire" + questionnaire
    #     responses = params[:responses]
    #     puts "responses" + responses

    #     ActiveRecord::Base.transaction do
    #         responses.each do |question_id, response|
    #             # For multiple-choice, response is an array of selected answer IDs
    #             if response.is_a?(Array)
    #                 response.each do |answer_id|
    #                     Response.find_or_create_by!(
    #                         questionnaire_id: questionnaire.id,
    #                         question_id: question_id,
    #                         response_text: answer_id
    #                     )
    #                 end
    #             else
    #                 Response.find_or_create_by!(
    #                     questionnaire_id: questionnaire.id,
    #                     question_id: question_id,
    #                     response_text: response
    #                 )
    #             end
    #         end
    #     end

    #     redirect_to questionnaire_path(questionnaire), notice: "Responses were successfully saved."
    # end
    

    private

    def set_response
        @response = Response.find(params[:id])
    end

    def response_params
        params.require(:response).permit(:questionnaire_id, :question_id, :response_text)
    end
end