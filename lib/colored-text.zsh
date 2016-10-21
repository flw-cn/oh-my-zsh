function ansi256color_fg {
    local lc=$'\e['
    local rc=m

    echo "${lc}38;5;$1$rc";
}

function ansi256color_bg {
    local lc=$'\e['
    local rc=m

    echo "${lc}48;5;$1$rc";
}

function ansi16color_fg {
    local lc=$'\e['
    local rc=m

    echo "${lc}3$1$rc";
}

function ansi16color_fg_bold {
    local lc=$'\e['
    local rc=m

    echo "${lc}9$1$rc";
}

function ansi16color_bg {
    local lc=$'\e['
    local rc=m

    echo "${lc}4$1$rc";
}

function ansi16color_bg_bold {
    local lc=$'\e['
    local rc=m

    echo "${lc}10$1$rc";
}

function text_with_color {
    local lc=$'\e['
    local rc=m

    echo "${lc}0$rc$2$3$1${lc}0$rc";
}
