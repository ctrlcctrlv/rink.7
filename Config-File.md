
Rink's CLI has a config file that allows customizing some functionality. The available options and their default values can be seen here:

```toml
[rink]
# Used for the interactive REPL mode.
prompt = "> "
# Breaks lists, such as search results, over multiple lines.
long_output = false

[currency]
# Currency fetching can be disabled for those that don't want it.
enabled = true
# Allows pointing to alternate Rink-Web instances, or to any other API that offers a compatible format.
endpoint = "https://rinkcalc.app/data/currency.json"
# Accepts common suffixes like ms, s, h, d, y.
timeout = "2s"
cache_duration = "1h"

[colors]
# Set to true to turn on colored output.
enabled = false
# Sets the active theme.
theme = "default"

# Limits section requires Rink v0.6.2 or higher.
[limits]
# Set to true to run queries in a child process, enabling memory limits and ctrl+C to cancel a query.
enabled = false
# Shows how long and how much memory is used after each query.
show_metrics = false
# How much memory should rink be allowed to use for executing queries. Supports multiple byte units.
memory = "20MB"
# How long a query can run before it times out automatically.
timeout = "10s"

# Multiple themes can be placed here with varying names, allowing for easy switching.
[themes.my_theme]
# Generic text and formatting.
plain = "default"
# Error messages.
error = "red"
# The names of units, like `kilogram`.
unit = "cyan"
# Physical quantities like `length` and `time`.
quantity = "dimmed cyan"
number = "default"
# Used in cases like unit not found errors.
user_input = "bold"
doc_string = "italic"
# The `^2` in `m/s^2`.
pow = "default"
# Names of properties in substances, like the `speed` in `speed of light`.
prop_name = "cyan"
# Date time objects, that you can get from using the hash notation or `now`.
date_time = "default"
```

The location of the config file varies by operating system. You can run `rink --config-path` to get the path to it.

| OS      | Location                                             | Example                                                       |
| ------- | ---------------------------------------------------- | ------------------------------------------------------------- |
| Linux   | `$XDG_CONFIG_HOME/rink/config.toml`                  | `/home/tiffany/.config/rink/config.toml`                      |
| Windows | `{FOLDERID_RoamingAppData}\rink\config.toml`         | `C:\Users\Tiffany\AppData\Roaming\rink\config.toml`           |
| macOS   | `$HOME/Library/Application Support/rink/config.toml` | `/Users/Tiffany/Library/Application Support/rink/config.toml` |

## Theme Colors

Color strings for themes are a set of keywords separated by spaces. The following keywords are understood:

- `black`, `red`, `green`, `yellow`, `blue`, `purple`, `cyan`, `white`: Sets the color to that ANSI color.
- `dim`/`dimmed`: Uses a dimmed variant of the color instead of the bright variant.
- `bold`, `italic`, `underline`/`under`, `strikethrough`: Formatting.
- `hidden`/`none`: Makes the text invisible.
- `on`: The color keyword after this will apply to the background instead of the foreground. Example: `black on red`.
- `default`/`plain`: Results in unstyled text.
- integers 0 to 255: Extended terminal color palette codes.
- `#ffffff`: Hex codes can be used to specify truecolor.
- `rgb(0,0,0)`: RGB values can be used to specify truecolor. No spaces are allowed after the commas.
