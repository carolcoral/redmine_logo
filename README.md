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
- Custom text content (max 10 characters)
- **First Letter Highlight**: Special color for the first letter
- **Color Picker**: Interactive color selection for text color and first letter color
- Fixed font size at 26px for optimal visibility
- Font weight selection (Normal, Medium, Semi-bold, Bold)
- Smart sizing: First letter at full size, remaining letters 8% smaller
- Custom margin and padding control

### 🖼️ Image Logo Features
- **File Upload Only**: Direct image upload (URL configuration removed for security)
- **AJAX Upload**: Upload without page refresh
- **Real-time Preview**: See uploaded logo immediately after upload
- **Upload Button**: Dedicated button for image upload
- Automatic image optimization
- Current logo preview
- Custom margin and padding control
- Responsive max-width: 120px to prevent layout issues

### ⚡ Plugin Control
- **Enable/Disable Switch**: Toggle logo display on/off without removing settings
- Changes apply immediately after saving

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
   - Settings are preserved when disabled

3. **Configure Logo Type**
   - Choose between **Text Logo** or **Image Logo**
   - Configure appropriate settings based on your selection

4. **Text Logo Settings**
   - Enter custom logo text (maximum 10 characters)
   - Select text color using the color picker
   - Select first letter color using the color picker (creates highlight effect)
   - Select font weight (Normal, Medium, Semi-bold, Bold)
   - Font size is fixed at 26px for optimal display

5. **Image Logo Settings**
   - Click **Choose File** to select an image (JPG, PNG, GIF, SVG supported)
   - Click **Upload Picture** button to upload the selected image
   - View real-time upload status (uploading/success/error)
   - Uploaded logo appears immediately in the preview area
   - Only file upload is supported (URL configuration removed)

6. **Display Settings**
   - **Position**: Choose between left or center alignment
   - **Margin**: Control outer spacing (e.g., 0, 5px, 10px 15px)
   - **Padding**: Control inner spacing (e.g., 8px, 10px, 5px 15px)

7. **Save Settings**
   - Click **Save** to apply all changes
   - For image logos, remember to save after uploading
   - Changes take effect immediately

## Usage

### Text Logo Example
- **Text**: "MyCompany" (max 10 chars)
- **Text Color**: #ffffff
- **First Letter Color**: #ff6600 (creates highlight effect)
- **Font Size**: Fixed at 26px
- **Font Weight**: Bold
- **Position**: Left
- **Margin**: 0
- **Padding**: 8px
- **Effect**: First letter "M" in orange (#ff6600), remaining letters "yCompany" in white (#ffffff) at 92% size

### Image Logo Example
- **Image**: Upload your company logo (recommended height: 25px, max width: 120px)
- **Upload Process**: 
  1. Click **Choose File** and select an image
  2. Click **Upload Picture** button
  3. Wait for upload to complete (status shows in real-time)
  4. Preview appears automatically
  5. Click **Save** to apply changes
- **Position**: Center
- **Margin**: 0
- **Padding**: 8px
- **Max Width**: 120px (automatically constrained to prevent layout issues)

## File Structure

```
redmine_logo/
├── init.rb                                 # Plugin registration
├── app/
│   ├── controllers/
│   │   └── logo_settings_controller.rb     # Handles image uploads and settings
│   ├── helpers/
│   │   └── logo_helper.rb                  # Logo rendering helper
│   └── views/
│       └── logo_settings/
│           └── _form.html.erb              # Configuration form with AJAX upload
├── config/
│   ├── locales/
│   │   ├── en.yml                          # English translations
│   │   └── zh.yml                          # Chinese translations
│   └── routes.rb                           # Plugin routes
├── db/
│   └── migrate/
│       └── 001_create_logo_settings.rb     # Database migration
├── lib/
│   └── redmine_logo/
│       └── view_listener.rb                # View hooks and CSS generation
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
1. Check that the plugin is enabled in settings
2. Clear browser cache and reload (Ctrl+Shift+R or Cmd+Shift+R)
3. Verify that settings are saved in Administration → Logo Management
4. Check browser console for JavaScript errors
5. Verify file permissions for uploaded images in `public/plugin_assets/redmine_logo/logos/`
6. Restart Redmine service

### Image upload not working
1. Ensure the form has `enctype="multipart/form-data"` (automatically added by plugin)
2. Check browser console for upload errors
3. Verify server has write permissions to `public/plugin_assets/redmine_logo/logos/`
4. Check image file size and format (JPG, PNG, GIF, SVG supported)
5. Review Redmine logs for detailed error messages

### Color picker not working
- IE11 does not support HTML5 color input, will fall back to text field
- You can still manually enter color codes (e.g., #ffffff for white)
- Modern browsers (Chrome, Firefox, Safari, Edge) fully support color pickers

### Mobile display issues
- Logo automatically scales on mobile devices (0.9x at 768px, 0.8x at 480px)
- Text logo font size is fixed at 26px for consistency
- Image logo max-width is constrained to 120px to prevent layout issues
- Test on different screen sizes to ensure optimal display

## License

This plugin is released under the MIT License.

## Support

For issues, questions, or contributions, please visit:
- GitHub Issues: https://github.com/carolcoral/redmine_logo/issues

## Changelog

### Version 1.0.1 (2026-02-03)
- Added plugin enable/disable switch
- Text logo: Added first letter color customization with special highlight effect
- Text logo: Limited to 10 characters for optimal display
- Text logo: Fixed font size at 26px (removed font size control)
- Text logo: Smart sizing - first letter at full size, remaining letters 8% smaller
- Image logo: Removed URL configuration (file upload only for security)
- Image logo: Added dedicated upload button
- Image logo: Implemented AJAX upload with real-time preview (no page refresh)
- Image logo: Added upload status indicator (uploading/success/error)
- Image logo: Constrained max-width to 120px to prevent layout issues
- Optimized responsive design for mobile devices
- Improved file upload error handling and logging

### Version 1.0.0 (2026-02-02)
- Initial release
- Text and image logo support
- Left and center positioning
- Color picker for text color
- Margin and padding control
- Multi-language support (EN, ZH)
- Responsive design
