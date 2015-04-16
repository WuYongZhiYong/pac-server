require! {koa, fs}
app = koa!
abp = fs.readFileSync(__dirname + '/abp.js', 'utf-8')
gfwlist = (new Buffer(fs.readFileSync(__dirname + '/gfwlist.txt', 'utf-8'), 'base64'))
    .toString('utf-8')
    .split('\n')
    .filter (line) ->
        return line and line[0] isnt '!' and line[0] isnt '[';
additional = fs.readFileSync(__dirname + '/additional_rules', 'utf-8')
    .trim()
    .toString('utf-8')
    .split('\n')
    .filter(Boolean)

rules = JSON.stringify(gfwlist.concat(additional))

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
    @body = abp
        .replace('__PROXY__', '"' + proxy(@query.protocol, @query.server or '127.0.0.1:8118') + '"')
        .replace('__RULES__', rules)

app.listen(8899)
