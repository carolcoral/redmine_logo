# Redmine Logo Plugin

A comprehensive logo management plugin for Redmine 6.1.1+ that allows customization of the top navigation bar logo with support for both image and text logos, precise positioning control, and detailed styling options.

## Features

### 🎨 Logo Type Support
- **Text Logo**: Use custom text as your logo with modern styling
- **Image Logo**: Upload and use custom image files (JPG, PNG, GIF, SVG)

### 🎯 Flexible Position
- **Left Alignment**: Logo positioned on the left side of main menu
- **Center Alignment**: Logo centered above the main menu

### 📐 Precise Dimension Control
- Custom width and height settings
- Padding control for perfect spacing
- Responsive design for mobile devices

### 🎨 Modern Text Styling
- Font size customization (px, em, rem units)
- Font weight selection (Normal, Medium, Semi-bold, Bold)
- Custom text color with live preview
- Background color support
- Smooth hover animations
- Gradient underline effects

### 🖼️ Image Management
- Direct image upload support
- URL-based image configuration
- Automatic image optimization
- Current logo preview

### 🌍 Multi-language Support
- English (EN)
- Chinese (中文)

## Requirements

- Redmine 6.1.1 or higher
- Ruby 2.7+ (compatible with Redmine 6.1.1 requirements)
- Rails 6.1+ (compatible with Redmine 6.1.1 requirements)

## Installation

1. **Download the plugin**
```bash
cd /path/to/redmine/plugins
git clone https://github.com/carolcoral/redmine_logo.git redmine_logo
```

2. **Install dependencies**
```bash
cd /path/to/redmine
bundle install
```

3. **Run database migrations**
```bash
RAILS_ENV=production bundle exec rake redmine:plugins:migrate
```

4. **Restart Redmine**
```bash
# For Passenger + Apache
touch tmp/restart.txt

# For other setups, restart your application server
```

5. **Clear cache** (optional but recommended)
```bash
RAILS_ENV=production bundle exec rake tmp:cache:clear
```

## Configuration

1. **Access Plugin Settings**
   - Login as Administrator
   - Go to **Administration** → **Logo Management**
   - Or go to **Administration** → **Plugins** → **Redmine Logo Plugin** → **Configure**

2. **Configure Logo Type**
   - Choose between **Text Logo** or **Image Logo**
   - Configure appropriate settings based on your selection

3. **Text Logo Settings**
   - Enter custom logo text
   - Set text color using color picker or hex codes
   - Adjust font size (e.g., 24px, 1.5em, 2rem)
   - Select font weight (Normal, Medium, Semi-bold, Bold)

4. **Image Logo Settings**
   - Upload logo image file (JPG, PNG, GIF, SVG)
   - Or enter direct image URL
   - View current logo preview

5. **Display Settings**
   - **Position**: Choose between left or center alignment above the main menu
   - **Width**: Set exact width (e.g., 150px, 10em, 50%)
   - **Height**: Set exact height (e.g., 50px, 3em)
   - **Padding**: Control spacing (e.g., 10px, 1em, 5px 10px)
   - **Background Color**: Set background color using color picker or hex codes

6. **Save Settings**
   - Click **Save** to apply changes
   - Changes take effect immediately

## Text Logo Styling

The text logo features modern styling inspired by Uiverse design elements:

- **Flexible Positioning**: Choose between left or center alignment above the main menu
- **Smooth Animations**: Subtle hover effects with smooth transitions
- **Gradient Underline**: Animated underline effect on hover
- **Typography**: Modern system fonts for optimal readability
- **Responsive**: Automatically adjusts for mobile devices
- **Accessibility**: High contrast and clear visibility

Example CSS customization:
```css
.logo-text-modern {
  font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  letter-spacing: -0.5px;
}

.logo-text-modern:hover {
  transform: translateY(-1px);
  text-shadow: 0 2px 8px rgba(0,0,0,0.15);
}
```

## Troubleshooting

### Logo not displaying
- Clear browser cache and reload
- Check file permissions for uploaded images
- Verify image URL is accessible
- Check browser console for JavaScript errors

### Settings not saving
- Ensure you have administrator privileges
- Check Redmine logs for error messages
- Verify database migrations were run successfully

### Mobile display issues
- Adjust logo dimensions for responsive design
- Use relative units (em, rem, %) instead of fixed pixels
- Test on different screen sizes

## File Structure

```
redmine_logo/
├── app/
│   ├── controllers/
│   │   └── logo_settings_controller.rb
│   ├── helpers/
│   │   └── logo_helper.rb
│   └── views/
│       ├── logo_settings/
│       │   └── _form.html.erb
│       └── hooks/
├── assets/
│   └── stylesheets/
│       └── logo.css
├── config/
│   ├── locales/
│   │   ├── en.yml
│   │   └── zh.yml
│   └── routes.rb
├── db/
│   └── migrate/
│       └── 001_create_logo_settings.rb
├── lib/
│   └── redmine_logo/
│       └── view_listener.rb
├── init.rb
└── README.md
```

## Development

### Running Tests
```bash
cd /path/to/redmine
RAILS_ENV=test bundle exec rake redmine:plugins:test PLUGIN=redmine_logo
```

### Code Style
- Follow Ruby and Rails conventions
- Use RuboCop for code linting
- Maintain consistent indentation and formatting

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This plugin is released under the MIT License. See LICENSE file for details.

## Support

For issues, questions, or contributions, please visit:
- GitHub Issues: [Report bugs and request features]
- Documentation: [Plugin wiki and guides]

## Changelog

### Version 1.0.0 (2026-02-02)
- Initial release
- Text and image logo support
- Position control (left, center, right)
- Precise dimension settings
- Modern text styling with Uiverse design elements
- Multi-language support (EN, ZH)
- Responsive design
- Image upload and URL support

## Credits

- Inspired by modern UI design principles
- Text styling based on Uiverse design elements
- Built for Redmine 6.1.1+ compatibility
