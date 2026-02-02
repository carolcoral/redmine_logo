# Redmine Logo Plugin

A customizable logo plugin for Redmine 6.1.x that allows you to add text or image logos to the top menu area with flexible positioning and styling options.

## Features

### 🎨 Logo Type Support
- **Text Logo**: Use custom text as your logo with modern styling
- **Image Logo**: Upload and use custom image files (JPG, PNG, GIF, SVG)

### 🎯 Flexible Positioning
- **Left Alignment**: Logo positioned on the left side of the top menu
- **Center Alignment**: Logo centered in the top menu area

### 🎨 Text Logo Styling
- Custom text content
- **Color Picker**: Interactive color selection for text color
- Adjustable font size (px, em, rem units)
- Font weight selection (Normal, Medium, Semi-bold, Bold)
- Custom margin and padding control

### 🖼️ Image Logo Features
- Direct image upload support
- URL-based image configuration
- Automatic image optimization
- Current logo preview
- Custom margin and padding control

### 📱 Responsive Design
- Automatically adjusts for mobile devices
- Maintains alignment and readability
- Scales appropriately for different screen sizes

## Requirements

- Redmine 6.1.0 or higher
- Ruby 2.7+ (compatible with Redmine 6.1.x requirements)
- Rails 6.1+ (compatible with Redmine 6.1.x requirements)

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
   - Go to **Administration → Logo Management**
   - Or go to **Administration → Plugins** → **Redmine Logo Plugin** → **Configure**

2. **Enable/Disable Plugin**
   - Use the **Enable Plugin** checkbox to turn logo display on or off
   - When disabled, the logo will not appear in the top menu

3. **Configure Logo Type**
   - Choose between **Text Logo** or **Image Logo**
   - Configure appropriate settings based on your selection

4. **Text Logo Settings**
   - Enter custom logo text
   - Select text color using the color picker
   - Adjust font size (e.g., 20px, 1.5em, 2rem)
   - Select font weight (Normal, Medium, Semi-bold, Bold)

5. **Image Logo Settings**
   - Upload logo image file (JPG, PNG, GIF, SVG)
   - Or enter direct image URL
   - View current logo preview

6. **Display Settings**
   - **Position**: Choose between left or center alignment
   - **Margin**: Control outer spacing (e.g., 0, 5px, 10px 15px)
   - **Padding**: Control inner spacing (e.g., 8px, 10px, 5px 15px)

7. **Save Settings**
   - Click **Save** to apply changes
   - Changes take effect immediately

## Usage

### Text Logo Example
- **Text**: "My Company"
- **Color**: #ff6600 (using color picker)
- **Font Size**: 24px
- **Font Weight**: Bold
- **Position**: Left
- **Margin**: 0
- **Padding**: 10px

### Image Logo Example
- **Image**: Upload your company logo (recommended size: 150x50px)
- **Position**: Center
- **Margin**: 5px
- **Padding**: 8px

## File Structure

```
redmine_logo/
├── init.rb                                 # Plugin registration
├── app/
│   ├── helpers/
│   │   └── logo_helper.rb                  # Logo rendering helper
│   └── views/
│       └── logo_settings/
│           └── _form.html.erb              # Configuration form
├── assets/
│   └── stylesheets/
│       └── logo.css                        # Plugin styles
├── config/
│   └── locales/
│       ├── en.yml                          # English translations
│       └── zh.yml                          # Chinese translations
├── db/
│   └── migrate/
│       └── 001_create_logo_settings.rb     # Database migration
├── lib/
│   └── redmine_logo/
│       └── view_listener.rb                # View hooks
└── README.md                               # This file
```

## Browser Compatibility

- ✅ Chrome 20+
- ✅ Firefox 29+
- ✅ Safari 12.1+
- ✅ Edge 18+
- ⚠️ IE11: Color picker will fall back to text input

## Troubleshooting

### Logo not displaying
1. Clear browser cache and reload
2. Check that settings are saved in Administration → Logo Management
3. Verify file permissions for uploaded images
4. Restart Redmine service

### Color picker not working
- IE11 does not support HTML5 color input, will fall back to text field
- You can still manually enter color codes (e.g., #ffffff)

### Mobile display issues
- Adjust logo dimensions for responsive design
- Use relative units (em, rem) instead of fixed pixels
- Test on different screen sizes

## License

This plugin is released under the MIT License.

## Support

For issues, questions, or contributions, please visit:
- GitHub Issues: https://github.com/carolcoral/redmine_logo/issues

## Changelog

### Version 1.0.0 (2026-02-02)
- Initial release
- Text and image logo support
- Left and center positioning
- Color picker for text color
- Margin and padding control
- Multi-language support (EN, ZH)
- Responsive design
