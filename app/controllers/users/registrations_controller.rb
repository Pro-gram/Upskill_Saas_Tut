class Users::RegistrationsController < Devise::RegistrationsController
# Extend default Devise gem behaviour so that
# Users signing up with pro account (Plan ID 2)
# So those users save special stripe subscription function.
# Otherwise Devise user signs up as usual
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end



