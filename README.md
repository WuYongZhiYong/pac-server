# pac-server
此服务器需要配合 http://jeeker.net/projects/genpac/ 使用，用 `genpac -p "{{PROXY}}" --output=pac.js` 命令在项目根目录下生成 pac.js 文件

可以再用 pm2 来启动服务器，然后设置 crontab：

    0 3 * * * /usr/bin/python /home/ubuntu/genpac/genpac -p "{{PROXY}}" --output=/home/ubuntu/pac-server/pac.js && /home/ubuntu/.nvm/versions/io.js/v1.0.3/bin/iojs /home/ubuntu/.nvm/versions/io.js/v1.0.3/bin/pm2 reload pac

这样
