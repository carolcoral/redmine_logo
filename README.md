# Redmine Logo Plugin

A customizable logo plugin for Redmine 6.1.x with text/image logo support, flexible positioning, custom head content insertion, and CSS namespace isolation.

![screenshots](screenshots/2.png)

## Features

- **Text & Image Logos**: Support for custom text logos (max 10 chars) and image uploads (JPG, PNG, GIF, SVG)
- **Flexible Positioning**: Left or center alignment with automatic spacing adjustment
- **Smart Text Styling**: 26px fixed size, first letter highlight, 8% size reduction for remaining letters
- **AJAX Upload**: Real-time image upload with preview and status indicator
- **Custom Head Content**: Insert `<style>`/`<script>` tags (only for logged-in users)
- **CSS Isolation**: All classes/IDs prefixed with `redmine_logo-` to prevent conflicts
- **Enable/Disable Toggle**: Switch logo display on/off without losing settings
- **Responsive Design**: Auto-scales for mobile (0.9x at 768px, 0.8x at 480px)
- **Multi-language**: English and Chinese support

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

1. **Access**: Login as Admin → **Administration → Logo Management** (or **Plugins → Redmine Logo Plugin → Configure**)

2. **Enable/Disable**: Toggle logo display on/off without losing settings

3. **Logo Type**: Choose **Text** or **Image**

4. **Text Logo**: Enter text (≤10 chars), select colors, font weight

5. **Image Logo**: Choose file → Click **Upload Picture** → Wait for preview → Save

6. **Display**: Set position (left/center), margin, and padding

7. **Custom Head** (Optional): Insert `<style>`/`<script>` tags (logged-in users only)

8. **Save**: Click **Save** to apply changes immediately

## Usage Examples

**Text Logo**: "MyCompany" with orange first letter, white text, bold weight, left position

**Image Logo**: Upload logo → Click Upload → Preview → Save (max width: 120px)

**Custom Head**: Add analytics or custom CSS/JS (logged-in users only)

## File Structure

```
redmine_logo/
├── init.rb                      # Plugin registration & settings
├── app/
│   ├── controllers/             # Image upload handling
│   ├── helpers/                 # Logo rendering logic
│   └── views/                   # Configuration form (AJAX upload)
├── config/
│   ├── locales/                 # EN/ZH translations
│   └── routes.rb                # Plugin routes
├── db/migrate/                  # Database migration
├── lib/redmine_logo/            # View hooks & CSS generation
└── README.md
```

## Browser Compatibility

- ✅ Chrome 20+
- ✅ Firefox 29+
- ✅ Safari 12.1+
- ✅ Edge 18+
- ⚠️ IE11: Color picker will fall back to text input

## Troubleshooting

**Logo not displaying**: Check enable status → Clear cache (Ctrl+Shift+R) → Verify settings → Check console → Check file permissions → Restart Redmine

**Image upload fails**: Check console → Verify folder permissions → Check format (JPG/PNG/GIF/SVG) → Review logs

**Color picker**: IE11 uses text fallback, modern browsers fully supported

**Mobile issues**: Auto-scales at 768px (0.9x) and 480px (0.8x), test on multiple devices

## License

This plugin is released under the MIT License.

## Support

For issues, questions, or contributions, please visit:
- GitHub Issues: https://github.com/carolcoral/redmine_logo/issues

## Changelog

### Version 1.0.2 (2026-02-03)
- **Custom Head Content**: Insert `<style>`/`<script>` tags (logged-in users only)
- **CSS Namespace Isolation**: All classes/IDs use `redmine_logo-` prefix
- **Left Positioning**: Uses `position: relative` with `float: left`
- Enhanced security and styling isolation

### Version 1.0.1 (2026-02-03)
- Enable/disable toggle switch
- Text logo: First letter highlight, 10-char limit, fixed 26px size
- Image logo: AJAX upload with real-time preview, upload button, max-width 120px
- Mobile optimizations and improved error handling

### Version 1.0.0 (2026-02-02)
- Initial release with text/image logos, positioning, color picker, and responsive design
