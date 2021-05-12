fx_version "bodacious"
game "gta5"

ui_page "web/html/index.html"

client_script {
    '@vrp/lib/utils.lua',
    "client/*"
}

server_script {
    '@vrp/lib/utils.lua',
    "server/*"
}

files {
	"web/*",
    "web/**/*.html",
    "web/**/*.css",
    "web/**/*.js",
    "web/**/*.png"
}