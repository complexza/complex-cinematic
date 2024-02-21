fx_version 'cerulean'
game 'gta5'
author 'complexza'
description 'Easy Cinematic Freecam'
version '1.2'

client_script {
    'client/*.lua'
}

server_script {
    'server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

lua54 'yes'
