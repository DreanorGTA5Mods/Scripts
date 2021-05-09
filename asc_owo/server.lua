local faces = {
    "(o´ω｀o)",
    "(´･ω･`);",
    "｡◕‿◕｡",
    "(✿◠‿◠)",
    "(≧◡≦)",
    "(´ω｀)",
    "＼(*^▽^*)/",
    "(•⊙ω⊙•)",
    "(¤﹏¤)",
    "(✖﹏✖)",
    "o(╥﹏╥)o",
    "(◕﹏◕✿)",
    "(>.<)",
    "≧∇≦",
    "(≖︿≖✿)",
    "(╯3╰)",
    "(n˘v˘•)¬",
}

local replacements = {
    { "%f[%a]the%f[%A]", {"twa", "tba", "da"} },
    { "%f[%a]yes%f[%A]", {"mmhmb"} },
    { "%f[%a]you%f[%A]", {"uwu", "uwu", "uwu", "u"} },
    { "%f[%a]your%f[%A]", {"uwus", "uwus", "uwus", "ur"} },
    { "%f[%a]and%f[%A]", {"awnd", "awd"} },
    { "%f[%a]of%f[%A]", {"ob", "obf", "owf", "owbf"} },
    { "%f[%a]but%f[%A]", {"bwt", "bwut"} },
    { "%f[%a]in%f[%A]", {"ibn", "ib", "iwn", "iwn", "iwn", "iwbn"} },
    { "%f[%a]as%f[%A]", {"az", "abs", "aws"} },
    { "%f[%a]to%f[%A]", {"two", "twu", "twu", "tu", "tbu"} },
    { "on%f[%A]", {"ob", "own", "own", "own", "own", "owbn"} },
    { "ws", {"wbs", "ws", "ws"} },
    { "ell", {"eww"} },
    { "ll", {"l", "bl"} },
    { "off", {"awf", "owf", "owf", "owff"} },
    { "ng[s?]%f[%A]", {"nb%1", "nb%1", "nb%1", "inb%1"} },
    { "%f[%a]c%w[^h]", {"cw"} },
    { "(%w)f(%w)", {"%1b%2"} },
    { "[%w]v", {"%1bv"} },
    { "%f[%a]v", {"b"} },
    { "%f[%a]my", {"mwie"} },
    { "ight", {"ibte"} },
    { "igh", {"i"} },
    { "lt", {"wld", "wld", "wld", "wlbd"} },
    { "ine", {"iwne"} },
    { "lf", {"lbf"} },
    { "(e[ae])(d)", {"%1bd"} },
    { "e[ae]", {"ee", "ii", "ie"} },
    { "%f[%a]h([aeiouy])", {"hw%1"} },
    { "uce", {"ubs"} },
    { "(%w)one%f[%A]", {"%1own"} },
    { "([pbcst])l", {"%1w"} },
    { "od", {"owd"} },
    { "%f[%a]l|r", {"w"} },
    { "wh", {"w", "wb"} },
    { "ch", {"cw"} },
    -- { ([aeiou]|\b)l([aeiouy]), ["%1l%2"] },
    { "sh(%w)", {"sw%1"} },
    { "(%w)sh", {"%1bsh"} },
    { "(%w)o", {"%1owo", "%1o", "%1o", "%1o"} },
    { "ng(%w)", {"ngb%1"} },
    { "(%w)me%f[%A]", {"%1mbe"} },
    { "qu", {"kw"} },
    { "([uo])t", {"%1bt"} },
    { "isc", {"ibsk"} },
    { "ck", {"k"} },
    { "us", {"uws"} },
    { "([aeiouy])st", {"%1wst"} },
    { "tt", {"t", "t", "t", "d"} },
    { "%f[%a]th", {"d"} },
    { "th", {"tw", "dt"} },
    { "(%w)tio(%w)", {"%1two%2"} },
    { "(%w)m([aeiou])", {"%1mb%2"} },
    { "no", {"noo"} },
    { "rs", {"s"} },
    { "ant", {"abnt"} },
    { "any", {"awny"} },
    { "!$", {" !", "!", " !!", "! !", "!", "!!!!", " !! !"}, true },
    { "! ", {" ! ", "! ", " !! ", "! ! ", "! ", "!!!! ", " !! ! "}, true },
    { "%?$", {"??", "???", " ?? ?", "??? ?!", " ?!", "!?", " ??!!", "!?? !", "!??", "!???!?!!??", " !!? !?"}, true },
    { "%? ", {"?? ", "??? ", " ?? ? ", "??? ?! ", " ?! ", "!? ", " ??!! ", "!?? ! ", "!?? ", "!???!?!!?? ", " !!? !? "}, true },
    { ",", {",,", ",", "...,,"} },
    { "(%w)%.%f[%A]", {"%1, ", "%1,, ", "%1... ", "%1. ", "%1. . ", "%1,. ", "%1! ", "%1! ! "}, true },
    { "%.%.%.%f[%A]", {",,.. ", "... ", "...... ", ". .... ", ",...... "} },
}

local owoChat = false

TriggerEvent('chat:addSuggestion', '/owo', 'turns on owo chat')
TriggerEvent('chat:addSuggestion', '/uwu', 'turns off owo chat')

AddEventHandler('chatMessage', function(player, playerName, message)
    CancelEvent()
    TriggerClientEvent('chatMessage', -1, playerName,  { 255, 255, 255 }, Owofy(message))
end)

RegisterCommand('owo', function(source)
    TriggerClientEvent('chat:addMessage', source, { color = { 255, 0, 0}, multiline = true, args = {"OwO activated."} })
    owoChat = true
end)

RegisterCommand('uwu', function(source)
    TriggerClientEvent('chat:addMessage', source, { color = { 255, 0, 0}, multiline = true, args = {"OwO deactivated."} })
    owoChat = false
end)

function Owofy(text)
    if owoChat then
        for _, entry in ipairs(replacements) do
            local pattern = entry[1]
            local replacements = entry[2]
            local include_face = entry[3]
            
            math.randomseed(os.time()*100000000000)
            local rnd = math.random(1, #replacements)
            local replacement = replacements[rnd]
    
            if include_face then
                math.randomseed(os.time()*100000000000)
                rnd = math.random(1, #faces)
                text = text:gsub(pattern, replacement .. faces[rnd])
            else
                text = text:gsub(pattern, replacement)
            end
        end
    end
    return text
end