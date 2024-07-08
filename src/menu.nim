proc forceMenu: InlineKeyboardMarkup =
  let
    jetpremium = static newInlineKeyboardButton(JETPREMIUM, url = "https://t.me/jetpremium")
    daramad = static newInlineKeyboardButton(DARAMAD, url = "https://t.me/daramad")
    joined = static newInlineKeyboardButton(JOINED, callbackdata = "joined")
  result = newInlineKeyboardMarkup(@[jetpremium, daramad], @[joined])


proc sendForceJoin(b: Telebot, chatId: int): Future[bool] {.gcsafe, async.} =
  acheck b.sendMessage(chatId, JOIN, replyMarkup = forceMenu())
  return true


proc startMenu: InlineKeyboardMarkup =
  let 
    guide = static newInlineKeyboardButton("guide", callbackdata = "guide")
    invite = static newInlineKeyboardButton("invite", callbackdata = "invite")
  result = newInlineKeyboardMarkup(@[guide, invite])


proc sendStartMenu(b: Telebot, userId: int): Future[bool] {.gcsafe, async.} =
  acheck b.sendMessage(userId, START_TXT, replyMarkup = startMenu())
  return true


proc sendInviteBanner(b: Telebot, uid: int): Future[bool] {.gcsafe, async.} =
  let url = "https://t.me/" & b.username & "?start=" & $(uid)
  acheck b.sendMessage(uid, url)
  return true


proc guideMenu: InlineKeyboardMarkup =
  let startMenu = static newInlineKeyboardButton(STARTMENU, callbackdata = "start")
  result = newInlineKeyboardMarkup(@[startMenu])

