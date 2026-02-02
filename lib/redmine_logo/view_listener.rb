module RedmineLogo
  class ViewListener < Redmine::Hook::ViewListener
    include LogoHelper

    def view_layouts_base_html_head(context = {})
      # 在head中添加CSS
      settings = Setting.plugin_redmine_logo || {}
      return '' if settings.blank? || settings['logo_type'].blank?

      css = generate_logo_css(settings)
      javascript = generate_logo_javascript(settings)

      <<~HTML.html_safe
        <style>
          #{css}
        </style>
        <script>
          #{javascript}
        </script>
      HTML
    end

    def view_layouts_base_body_bottom(context = {})
      # 在body底部添加Logo HTML
      settings = Setting.plugin_redmine_logo || {}
      return '' if settings.blank? || settings['logo_type'].blank?

      logo_html = generate_logo_html(settings)
      logo_html.html_safe
    end

    private

    def generate_logo_css(settings)
      position = settings['logo_position'] || 'left'
      
      # 基础样式
      css = []
      css << "#header h1 { display: none; }"
      
      # Logo容器样式 - 根据位置调整
      if position == 'center'
        css << <<~CSS
          #custom-logo-container {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            display: flex;
            align-items: center;
            height: 100%;
          }
        CSS
      else # left
        css << <<~CSS
          #custom-logo-container {
            position: absolute;
            left: 0;
            z-index: 1000;
            display: flex;
            align-items: center;
            height: 100%;
          }
        CSS
      end
      
      css << <<~CSS
        .logo-text-modern {
          font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
          text-decoration: none;
          position: relative;
          display: inline-flex;
          align-items: center;
          cursor: pointer;
          letter-spacing: -0.5px;
          transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
          height: 100%;
          line-height: 1;
          margin-right: 20px;
        }
        .logo-text-modern:hover {
          text-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }
        .logo-text-modern::after {
          content: '';
          position: absolute;
          bottom: 5px;
          left: 0;
          width: 0;
          height: 2px;
          background: linear-gradient(90deg, currentColor, rgba(255, 255, 255, 0.6));
          border-radius: 2px;
          transition: width 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .logo-text-modern:hover::after {
          width: 100%;
        }
        #custom-logo-image {
          max-width: 100%;
          max-height: 100%;
          height: auto;
          width: auto;
          object-fit: contain;
          display: block;
          transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), filter 0.3s ease;
          margin-right: 20px;
        }
        #custom-logo-image:hover {
          transform: scale(1.03);
          filter: drop-shadow(0 2px 6px rgba(0, 0, 0, 0.2));
        }
        #custom-logo-container a {
          display: flex;
          align-items: center;
          height: 100%;
          text-decoration: none;
        }
        #main-menu ul {
          padding-left: 120px; /* 为logo预留空间 */
        }
        @media (max-width: 768px) {
          #custom-logo-container { transform: scale(0.9); }
          .logo-text-modern { font-size: 18px !important; }
          #main-menu ul { padding-left: 100px; }
        }
        @media (max-width: 480px) {
          #custom-logo-container { transform: scale(0.8); }
          .logo-text-modern { font-size: 16px !important; }
          #main-menu ul { padding-left: 80px; }
        }
      CSS
      
      css.join("\n")
    end

    def generate_logo_javascript(settings)
      <<~JAVASCRIPT
        document.addEventListener('DOMContentLoaded', function() {
          // 为文字logo添加动画效果
          const logoText = document.querySelector('#custom-logo-text');
          if (logoText) {
            logoText.style.opacity = '0';
            logoText.style.transform = 'translateY(10px)';
            logoText.style.transition = 'opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1), transform 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
            setTimeout(function() {
              logoText.style.opacity = '1';
              logoText.style.transform = 'translateY(0)';
            }, 100);
          }

          // 为图片logo添加淡入效果
          const logoImage = document.querySelector('#custom-logo-image');
          if (logoImage) {
            logoImage.style.opacity = '0';
            logoImage.style.transition = 'opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
            logoImage.addEventListener('load', function() {
              this.style.opacity = '1';
            });
          }
        });
      JAVASCRIPT
    end

    def generate_logo_html(settings)
      if settings['logo_type'] == 'image' && settings['logo_image_url'].present?
        # 图片Logo
        link_path = home_url
        image_tag = ActionController::Base.helpers.image_tag(
          settings['logo_image_url'],
          alt: settings['logo_text'] || 'Redmine',
          style: logo_image_styles(settings),
          id: 'custom-logo-image'
        )
        <<~HTML
          <div id="custom-logo-container">
            <a href="#{link_path}">#{image_tag}</a>
          </div>
        HTML
      else
        # 文字Logo
        link_path = home_url
        content_tag = ActionController::Base.helpers.content_tag(
          :span,
          settings['logo_text'] || 'Redmine',
          style: logo_text_styles(settings),
          id: 'custom-logo-text',
          class: 'logo-text-modern'
        )
        <<~HTML
          <div id="custom-logo-container">
            <a href="#{link_path}" style="#{logo_link_styles(settings)}">#{content_tag}</a>
          </div>
        HTML
      end
    end
  end
end
