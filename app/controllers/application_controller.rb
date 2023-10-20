class ApplicationController < ActionController::Base
 before_action :set_locale
 before_action :configure_permitted_parameters, if: :devise_controller?
		
		protected
			
		rescue_from CanCan::AccessDenied do |exception|
			redirect_to main_app.root_url, alert: exception.message
		end
		
		
		rescue_from ActiveRecord::RecordNotFound do |exception|
			redirect_to root_path # o qualsiasi altra azione o pagina di errore generale
		end
				
		def configure_permitted_parameters
					devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
					devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :favorite_category])
		end
		
		
		def set_locale
			I18n.locale=session[:select_l] || I18n.default_locale
		end

end
