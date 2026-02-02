module RedmineLogo
  class ViewListener < Redmine::Hook::ViewListener
    include LogoHelper

    def view_layouts_base_body_bottom(context = {})
      settings = Setting.plugin_redmine_logo || {}
      return '' unless settings['logo_type'].present?

      # 生成CSS样式
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

    private

    def generate_logo_css(settings)
      position = settings['logo_position'] || 'left'
      css = []

      # 基础logo容器样式
      css << "#header h1 { display: none; }" # 隐藏默认Redmine logo

      # 根据位置设置logo样式
      case position
      when 'left'
        css << <<~CSS
          #custom-logo-container {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 100;
          }
        CSS
      when 'right'
        css << <<~CSS
          #custom-logo-container {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 100;
          }
        CSS
      when 'center'
        css << <<~CSS
          #custom-logo-container {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            z-index: 100;
          }
        CSS
      end

      # 添加现代文字logo样式（基于Uiverse设计元素）
      css << <<~CSS
        .logo-text-modern {
          font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
          text-decoration: none;
          transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
          position: relative;
          letter-spacing: -0.5px;
        }

        .logo-text-modern:hover {
          transform: translateY(-1px);
          text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .logo-text-modern::after {
          content: '';
          position: absolute;
          bottom: -2px;
          left: 0;
          width: 0;
          height: 2px;
          background: linear-gradient(90deg, currentColor, rgba(255,255,255,0.5));
          transition: width 0.3s ease;
        }

        .logo-text-modern:hover::after {
          width: 100%;
        }

        #header {
          position: relative;
        }

        #custom-logo-container img {
          max-width: 100%;
          height: auto;
          object-fit: contain;
        }

        .logo-position-left { text-align: left; }
        .logo-position-center { text-align: center; }
        .logo-position-right { text-align: right; }
      CSS

      css.join("\n")
    end

    def generate_logo_javascript(settings)
      <<~JAVASCRIPT
        document.addEventListener('DOMContentLoaded', function() {
          // 动态插入自定义logo
          const header = document.querySelector('#header');
          if (header && !document.querySelector('#custom-logo-container')) {
            const logoContainer = document.createElement('div');
            logoContainer.id = 'custom-logo-container';
            logoContainer.className = 'logo-position-#{settings['logo_position'] || 'left'}';

            const logoContent = #{logo_content_javascript(settings).to_json};
            logoContainer.innerHTML = logoContent;

            header.appendChild(logoContainer);

            // 为文字logo添加动画效果
            const logoText = logoContainer.querySelector('.logo-text-modern');
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
            const logoImage = logoContainer.querySelector('#custom-logo-image');
            if (logoImage) {
              logoImage.style.opacity = '0';
              logoImage.style.transition = 'opacity 0.6s cubic-bezier(0.4, 0, 0.2, 1)';

              logoImage.addEventListener('load', function() {
                this.style.opacity = '1';
              });
            }
          }

          // 添加响应式处理
          function handleResize() {
            const logoContainer = document.querySelector('#custom-logo-container');
            const header = document.querySelector('#header');
            if (logoContainer && header) {
              const headerHeight = header.offsetHeight;
              logoContainer.style.maxHeight = (headerHeight - 10) + 'px';
            }
          }

          window.addEventListener('resize', handleResize);
          handleResize();
        });
      JAVASCRIPT
    end

    def logo_content_javascript(settings)
      if settings['logo_type'] == 'image' && settings['logo_image_url'].present?
        link_path = home_url
        image_tag = ActionController::Base.helpers.image_tag(
          settings['logo_image_url'],
          alt: settings['logo_text'] || 'Redmine',
          style: logo_image_styles(settings),
          id: 'custom-logo-image'
        )
        "<a href='#{link_path}'>#{image_tag}</a>"
      else
        link_path = home_url
        content_tag = ActionController::Base.helpers.content_tag(
          :span,
          settings['logo_text'] || 'Redmine',
          style: logo_text_styles(settings),
          id: 'custom-logo-text',
          class: 'logo-text-modern'
        )
        "<a href='#{link_path}' style='#{logo_link_styles(settings)}'>#{content_tag}</a>"
      end
    end
  end
end
