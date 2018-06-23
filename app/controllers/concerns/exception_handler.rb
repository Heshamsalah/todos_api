module ExceptionHandler
    # Instead of doing a rescue in the action method itself
    # let us avoid deep nested if statements in the controller
    extend ActiveSupport::Concern

    included do
        rescue_from ActiveRecord::RecordNotFound do |err|
            json_response({ message: err.message }, :not_found)
        end

        rescue_from ActiveRecord::RecordInvalid do |err|
            json_response({ message: err.message }, :unprocessable_entity)
        end
    end
end
