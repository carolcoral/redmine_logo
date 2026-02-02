class LogoSettingsController < ApplicationController
  layout 'admin'
  before_action :require_admin

  def update
    settings = params[:settings] || {}
    
    # 处理图片上传
    if params[:logo_image_file].present?
      uploaded_file = params[:logo_image_file]
      if uploaded_file.respond_to?(:original_filename) && uploaded_file.size > 0
        # 创建上传目录
        logo_dir = Rails.root.join('public', 'plugin_assets', 'redmine_logo', 'logos')
        FileUtils.mkdir_p(logo_dir) unless File.exist?(logo_dir)
        
        # 生成文件名
        filename = "logo_#{Time.current.to_i}_#{uploaded_file.original_filename}"
        file_path = logo_dir.join(filename)
        
        # 保存文件
        File.open(file_path, 'wb') do |file|
          file.write(uploaded_file.read)
        end
        
        # 设置图片URL
        settings['logo_image_url'] = "/plugin_assets/redmine_logo/logos/#{filename}"
      end
    elsif settings['logo_image_url'].blank?
      settings['logo_image_url'] = ''
    end
    
    # 保存设置
    Setting.plugin_redmine_logo = settings
    flash[:notice] = l(:notice_successful_update)
    redirect_to plugin_settings_path('redmine_logo')
  rescue => e
    flash[:error] = l(:notice_error_update, message: e.message)
    redirect_to plugin_settings_path('redmine_logo')
  end
end
