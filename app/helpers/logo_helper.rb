module LogoHelper
  def render_custom_logo
    settings = Setting.plugin_redmine_logo || {}
    return '' if settings.blank? || settings['logo_type'].blank?

    content_tag :div, id: 'custom-logo-container' do
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
      text = settings['logo_text'] || 'Redmine'
      first_letter = text[0]
      rest_of_text = text[1..-1]
      first_letter_color = settings['logo_first_letter_color'] || settings['logo_text_color'] || '#ffffff'
      
      # 创建带首字母颜色的文字
      if rest_of_text.present?
        content_tag(:span, nil, style: logo_text_styles(settings), id: 'custom-logo-text', class: 'logo-text-modern') do
          content_tag(:span, first_letter, style: "color: #{first_letter_color}", class: 'logo-first-letter') +
          content_tag(:span, rest_of_text)
        end
      else
        content_tag(:span, nil, style: logo_text_styles(settings), id: 'custom-logo-text', class: 'logo-text-modern') do
          content_tag(:span, first_letter, style: "color: #{first_letter_color}", class: 'logo-first-letter')
        end
      end
    end
  end

  def logo_image_styles(settings)
    styles = []
    styles << "height: 100%"
    styles << "width: auto"
    styles << "object-fit: contain"
    styles << "margin: #{settings['logo_margin'] || '0'}"
    styles << "padding: #{settings['logo_padding'] || '8px'}"
    styles.join('; ')
  end

  def logo_text_styles(settings)
    styles = []
    styles << "color: #{settings['logo_text_color'] || '#ffffff'}"
    styles << "font-size: #{settings['logo_text_font_size'] || '20px'}"
    styles << "font-weight: #{settings['logo_text_font_weight'] || '600'}"
    styles << "margin: #{settings['logo_margin'] || '0'}"
    styles << "padding: #{settings['logo_padding'] || '8px'}"
    styles << "line-height: 1"
    styles << "white-space: nowrap"
    styles.join('; ')
  end

  def logo_link_styles(settings)
    styles = []
    styles << "text-decoration: none"
    styles << "display: flex"
    styles << "align-items: center"
    styles << "height: 100%"
    styles.join('; ')
  end
end
