class LogoSettingsController < ApplicationController
  layout 'admin'
  before_action :require_admin

  def update
    settings = params[:settings] || {}
    
    # 验证文字logo长度
    if settings['logo_type'] == 'text' && settings['logo_text'].present?
      if settings['logo_text'].length > 10
        respond_to do |format|
          format.html {
            flash[:error] = l(:notice_error_update, message: '文字logo不能超过10个字符')
            redirect_to plugin_settings_path('redmine_logo')
          }
          format.json { render json: {error: '文字logo不能超过10个字符'}, status: :unprocessable_entity }
        end
        return
      end
    end
    
    image_url = nil
    
    # 处理图片上传
    if params[:logo_image_file].present? && params[:logo_image_file].respond_to?(:read)
      uploaded_file = params[:logo_image_file]
      Rails.logger.info "[LogoPlugin] Uploading file: #{uploaded_file.original_filename}, size: #{uploaded_file.size}"
      
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
        
        # 设置图片URL - 使用完整的URL路径
        image_url = "/plugin_assets/redmine_logo/logos/#{filename}"
        settings['logo_image_url'] = image_url
        Rails.logger.info "[LogoPlugin] File saved to: #{file_path}, URL: #{image_url}"
      else
        Rails.logger.warn "[LogoPlugin] Invalid file upload"
      end
    elsif settings['logo_type'] == 'image'
      # 如果logo_type是image但没有上传新文件，保留之前的URL
      current_settings = Setting.plugin_redmine_logo || {}
      settings['logo_image_url'] = current_settings['logo_image_url'] if current_settings['logo_image_url'].present?
    else
      settings['logo_image_url'] = ''
    end
    
    # 保存设置
    Setting.plugin_redmine_logo = settings
    
    respond_to do |format|
      format.html {
        flash[:notice] = l(:notice_successful_update)
        redirect_to plugin_settings_path('redmine_logo')
      }
      format.json { 
        render json: {
          success: true, 
          image_url: image_url,
          message: l(:notice_successful_update)
        } 
      }
    end
  rescue => e
    Rails.logger.error "[LogoPlugin] Error in update: #{e.message}\n#{e.backtrace.join("\n")}"
    respond_to do |format|
      format.html {
        flash[:error] = l(:notice_error_update, message: e.message)
        redirect_to plugin_settings_path('redmine_logo')
      }
      format.json { 
        render json: {error: e.message}, status: :unprocessable_entity 
      }
    end
  end
end
