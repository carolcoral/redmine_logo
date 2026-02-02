require 'redmine'

Redmine::Plugin.register :redmine_logo do
  name 'Redmine Logo Plugin'
  author 'Your Name'
  description 'Customizable logo plugin for Redmine 6.1.1+ with support for image or text logo, position control, and precise dimension settings'
  version '1.0.0'
  url 'https://github.com/yourname/redmine_logo'
  author_url 'https://github.com/yourname'

  requires_redmine version_or_higher: '6.1.1'

  settings default: {
    logo_type: 'text', # text or image
    logo_text: 'Redmine',
    logo_text_color: '#ffffff',
    logo_text_font_size: '24px',
    logo_text_font_weight: '600',
    logo_position: 'left', # left, center, right
    logo_width: '150px',
    logo_height: '50px',
    logo_image_url: '',
    logo_padding: '10px',
    logo_background_color: 'transparent'
  }, partial: 'logo_settings/form'

  menu :admin_menu, :logo_settings, { controller: 'logo_settings', action: 'index' }, caption: :label_logo_plugin

  project_module :logo_management do
    permission :manage_logo, logo_settings: [:index, :update]
  end
end

require_relative 'lib/redmine_logo/view_listener'
require_relative 'app/helpers/logo_helper'
