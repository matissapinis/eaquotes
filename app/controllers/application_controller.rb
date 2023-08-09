class ApplicationController < ActionController::Base
    ## Whitelist new parameters so that they can be used in the Devise forms:
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      added_attrs = [:display_name, :full_name, :facebook_link, :twitter_link, :ea_forum_link, :lesswrong_link, :goodreads_link]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
  end
  