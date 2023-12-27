--[[

  _  ___    _ ____          _   _  _____  _____ _____  _____ _____ _______ _____ 
 | |/ / |  | |  _ \   /\   | \ | |/ ____|/ ____|  __ \|_   _|  __ \__   __/ ____|
 | ' /| |  | | |_) | /  \  |  \| | (___ | |    | |__) | | | | |__) | | | | (___  
 |  < | |  | |  _ < / /\ \ | . ` |\___ \| |    |  _  /  | | |  ___/  | |  \___ \ 
 | . \| |__| | |_) / ____ \| |\  |____) | |____| | \ \ _| |_| |      | |  ____) |
 |_|\_\\____/|____/_/    \_\_| \_|_____/ \_____|_|  \_\_____|_|      |_| |_____/ 
                                                                                 
                                                                                                                                                                                               
discord.gg/kubanscripts | @KubanScripts | https://kubanscripts.tebex.io

Renaming Any Files. = Script Breaking

]]--
fx_version 'cerulean'
game 'gta5'
description 'MultiJob Menu/System'
author 'KubanScripts' 
lua54 'yes'

server_script {
'server/*.lua',
'@oxmysql/lib/MySQL.lua'
}
client_script 'client/*.lua'
shared_scripts {
'shared/*.lua', 
'@ox_lib/init.lua'
}
