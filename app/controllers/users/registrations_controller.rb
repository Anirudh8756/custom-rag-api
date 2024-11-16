class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private
      def respond_with(resource, options={})
        if  resource.persisted?
        render json: {
          code: "200",
          message: "Signed Up successfully.",
          data: resource
          }, status: :ok
        else
          render json: {
            code: "422",
            message: "User could not be created successfully.",
            errors: resource.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

end
