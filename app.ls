require! {koa, fs}
app = koa!
pac = fs.readFileSync(__dirname + '/pac.js', 'utf-8')
function proxy(protocol, server)
    if protocol is 'socks'
        return "SOCKS #server"
    else if protocol is 'socks5'
        return "SOCKS5 #server; SOCKS #server"
    else
        return "PROXY #server"

app.use ->*
    unless @url.indexOf('/ap') > -1
        return
    @type = 'js'
    @body = pac.replace('{{PROXY}}', proxy(@query.protocol, @query.server or '127.0.0.1:8118'))

app.listen(8899)
