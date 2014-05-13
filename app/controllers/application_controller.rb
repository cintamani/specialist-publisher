require 'specialist_publisher_wiring'
require 'forwardable'

class ApplicationController < ActionController::Base
  include GDS::SSO::ControllerMethods
  extend Forwardable

  before_filter :require_signin_permission!

  protect_from_forgery with: :exception

  SpecialistPublisherWiring.inject_into(self)
  helper_method :finder_schema

  def_delegators :url_maker, :published_specialist_document_path
  helper_method :published_specialist_document_path

  def render_with(locals)
    render(action_name, locals: locals)
  end

  def user_can_edit_documents?
    current_user.organisation_slug == 'competition-and-markets-authority'
  end
  helper_method :user_can_edit_documents?
end
