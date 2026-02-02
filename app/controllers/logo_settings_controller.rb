class LogoSettingsController < ApplicationController
  layout 'admin'
  menu_item :logo_settings
  before_action :require_admin

  def index
    @logo_settings = Setting.plugin_redmine_logo || {}
  end

  def update
    settings = params[:settings] || {}

    # 处理logo图片上传
    if params[:logo_image_file].present?
      settings['logo_image_url'] = handle_logo_upload(params[:logo_image_file])
    elsif settings['logo_image_url'].blank?
      settings['logo_image_url'] = ''
    end

    # 验证和清理设置值
    settings = sanitize_settings(settings)

    Setting.plugin_redmine_logo = settings
    flash[:notice] = l(:notice_successful_update)
    redirect_to action: 'index'
  rescue => e
    flash[:error] = l(:notice_error_update, message: e.message)
    redirect_to action: 'index'
  end

  private

  def handle_logo_upload(uploaded_file)
    return '' unless uploaded_file.respond_to?(:original_filename) && uploaded_file.size > 0

    # 创建插件的logo目录
    logo_dir = Rails.root.join('public', 'plugin_assets', 'redmine_logo', 'logos')
    FileUtils.mkdir_p(logo_dir) unless File.exist?(logo_dir)

    # 生成唯一文件名
    filename = "logo_#{Time.current.to_i}_#{uploaded_file.original_filename}"
    file_path = logo_dir.join(filename)

    # 保存文件
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    # 返回相对路径
    "/plugin_assets/redmine_logo/logos/#{filename}"
  rescue => e
    Rails.logger.error "Logo upload failed: #{e.message}"
    flash[:warning] = l(:warning_logo_upload_failed)
    ''
  end

  def sanitize_settings(settings)
    # 确保logo_type有效
    settings['logo_type'] = 'text' unless %w[text image].include?(settings['logo_type'])

    # 确保position有效
    settings['logo_position'] = 'left' unless %w[left center right].include?(settings['logo_position'])

    # 验证尺寸值
    settings['logo_width'] = validate_dimension(settings['logo_width'], '150px')
    settings['logo_height'] = validate_dimension(settings['logo_height'], '50px')
    settings['logo_text_font_size'] = validate_dimension(settings['logo_text_font_size'], '24px')

    # 验证颜色值
    settings['logo_text_color'] = validate_color(settings['logo_text_color'], '#ffffff')
    settings['logo_background_color'] = validate_color(settings['logo_background_color'], 'transparent')

    settings
  end

  def validate_dimension(value, default)
    return default if value.blank?
    # 允许 px, em, rem, %, vw, vh 等单位
    value.match?(/\A\d+(\.\d+)?(px|em|rem|%|vw|vh)\z/) ? value : default
  end

  def validate_color(value, default)
    return default if value.blank?
    # 验证十六进制颜色或颜色名称
    value.match?(/\A#([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})\z|\A[a-zA-Z]+\z/) ? value : default
  end
end
