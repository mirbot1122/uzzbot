[Forwarded from Alpha]
local function get_message_callback(extra, success, result)
 if result.to.type == 'chat' then
 local chat = 'chat#id'..result.to.id
 chat_del_user(chat, 'user#id'..result.from.id, ok_cb, false)
 else
 return 'Use This in Your Groups'
 end
end

local function callbackreskick(extra, success, result)
 local user = 'user#id'..result.id
 chat_del_user(extra.chatid, user, ok_cb, false)
end

local function run(msg, matches)
 if type(msg.reply_id)~="nil" then
 msgr = get_message(msg.reply_id,get_message_callback, false)
 else
 if msg.to.type == 'chat' then
 local chat = 'chat#id'..msg.to.id
 local cbres_extra = {
 chatid = chat
 }
 local username = matches[1]
 local username = username:gsub("@","")
 res_user(username, callbackreskick, cbres_extra)
 return
 else
 return 'Use This in Your Groups'
 end
 end
end

return {
description = "kick people by username or reply , /kick for reply and /kick @username for kick by username ",
usage = {
"/kick [user_name]",
"/kick" },
patterns = {
"^/kick$",
"^/kick (.*)$"
},
run = run,
privileged = true
}

end
