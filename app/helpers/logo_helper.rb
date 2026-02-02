module LogoHelper
  def render_custom_logo
    settings = Setting.plugin_redmine_logo || {}
    return '' if settings.blank?

    content_tag :div, id: 'custom-logo-container', class: "logo-position-#{settings['logo_position'] || 'left'}" do
      if settings['logo_type'] == 'image' && settings['logo_image_url'].present?
        render_image_logo(settings)
      else
        render_text_logo(settings)
      end
    end
  end

  def render_image_logo(settings)
    link_to home_url do
      image_tag settings['logo_image_url'],
                alt: settings['logo_text'] || 'Redmine',
                style: logo_image_styles(settings),
                id: 'custom-logo-image'
    end
  end

  def render_text_logo(settings)
    link_to home_url, style: logo_link_styles(settings) do
      content_tag :span, settings['logo_text'] || 'Redmine',
                  style: logo_text_styles(settings),
                  id: 'custom-logo-text',
                  class: 'logo-text-modern'
    end
  end

  def logo_image_styles(settings)
    styles = []
    styles << "width: #{settings['logo_width'] || '150px'}"
    styles << "height: #{settings['logo_height'] || '50px'}"
    styles << "padding: #{settings['logo_padding'] || '10px'}" if settings['logo_padding'].present?
    styles << "background-color: #{settings['logo_background_color'] || 'transparent'}"
    styles.join('; ')
  end

  def logo_text_styles(settings)
    styles = []
    styles << "font-size: #{settings['logo_text_font_size'] || '24px'}"
    styles << "font-weight: #{settings['logo_text_font_weight'] || '600'}"
    styles << "color: #{settings['logo_text_color'] || '#ffffff'}"
    styles << "padding: #{settings['logo_padding'] || '10px'}" if settings['logo_padding'].present?
    styles << "background-color: #{settings['logo_background_color'] || 'transparent'}"
    styles << "line-height: #{settings['logo_height'] || '50px'}"
    styles << "display: inline-block"
    styles.join('; ')
  end

  def logo_link_styles(settings)
    styles = []
    styles << "text-decoration: none"
    styles << "display: block"
    styles << "height: #{settings['logo_height'] || '50px'}"
    styles.join('; ')
  end

  def logo_container_styles(settings)
    styles = []
    styles << "width: #{settings['logo_width'] || '150px'}"
    styles << "height: #{settings['logo_height'] || '50px'}"
    styles << "padding: #{settings['logo_padding'] || '0'}" if settings['logo_padding'].present?
    styles.join('; ')
  end
end
