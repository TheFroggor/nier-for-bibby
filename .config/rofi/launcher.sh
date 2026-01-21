#!/bin/bash

# Чтение цветов из INI-файла для Rofi
COLOR_FILE="$HOME/.config/colors/theme.ini"

# Функция для получения значения из INI-файла
get_color() {
    grep "^$1\s*=" "$COLOR_FILE" | cut -d '=' -f2 | tr -d ' ' | head -n1
}

# Загружаем цвета (используем подчеркивания вместо дефисов для gray-light и gray-dark)
BACKGROUND=$(get_color "background")
FOREGROUND=$(get_color "foreground")
PRIMARY=$(get_color "primary")
SECONDARY=$(get_color "secondary")
SUCCESS=$(get_color "success")
WARNING=$(get_color "warning")
ALERT=$(get_color "alert")
GRAY_LIGHT=$(get_color "gray-light")
GRAY_DARK=$(get_color "gray-dark")

# Проверяем, что цвета загружены
if [ -z "$BACKGROUND" ]; then
    echo "Ошибка: не удалось загрузить цвета из $COLOR_FILE"
    echo "Проверьте путь: $COLOR_FILE"
    exit 1
fi

# Запускаем Rofi с подставленными цветами (используем подчеркивания)
rofi -show drun \
  -theme-str "
    * {
      bg: $BACKGROUND;
      fg: $FOREGROUND;
      primary: $PRIMARY;
      secondary: $SECONDARY;
      success: $SUCCESS;
      warning: $WARNING;
      alert: $ALERT;
      gray_light: $GRAY_LIGHT;
      gray_dark: $GRAY_DARK;
    }
  " \
  -theme ~/.config/rofi/theme.rasi
